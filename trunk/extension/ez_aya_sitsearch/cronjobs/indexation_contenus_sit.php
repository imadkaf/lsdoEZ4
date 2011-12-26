<?php
//require_once('extension/ez_aya_sitsearch/classes/sit_utils.class.php');

if(!$isQuiet){
	$cli->output( "Début du cronjob");
}

//Initialisation d'un XML qui sera indexé par SOLR
$doc = new DOMDocument("1.0", "UTF-8");
$root_elt = $doc->createElement('add');
$doc->appendChild($root_elt);

//Récupérer toutes les objets de type "SIT Liste" (fetch content list)
$fetchParameters = array(
	'parent_node_id' => 2,
	'depth' => 10,
	'class_filter_type' => 'include',
	'class_filter_array' => array('sit_liste')
);

$nodeObjects = eZFunctionHandler::execute(
	'content',
	'list',
	$fetchParameters
);

$http = eZHTTPTool::instance();

$sitIni = eZINI::instance('ez_aya_sitsearch.ini');

foreach ($nodeObjects as $nodeObject) {
	
	$lienCourant = $nodeObject->attribute('url_alias');
	//echo $lienCourant;
	eZURI::transformURI($lienCourant);
	
	$sitListe = $nodeObject->dataMap();
	
	if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
		$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
	} else {
		$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
	}
	
	$categorie = $sitListe['categorie']->value();
	$categorie = $categorie[0];
	
	$dureeVieCache = $sitListe['duree_vie_cache']->value() * 60;
	
	$sitParams = array();
	$sitParams['dwcom'] = "11111";
	
	$parametresDiffusionSupplementaires = $sitListe['parametres_diffusion_supplementaires']->value()->attribute('matrix');
	$parametresDiffusionSupplementaires = $parametresDiffusionSupplementaires['rows']['sequential'];
	
	foreach ($parametresDiffusionSupplementaires as $parametreDiffusionSupplementaire) {
		$sitParamName = $parametreDiffusionSupplementaire['columns'][0];
		$sitParamValue = $parametreDiffusionSupplementaire['columns'][1];

		if ($sitParamName && $sitParamValue) {
			if (array_key_exists($sitParamName, $sitParams)) {
				$sitParams[$sitParamName] .= (preg_match("{^dwcrit|mr2$}", $sitParamName) ? "|" : (preg_match("{^mc$}", $sitParamName) ? " " : ",")).$sitParamValue;
			} else {
				$sitParams[$sitParamName] = $sitParamValue;
			}
		}
	}
	
	$sitParamsString = "";
	$sitParamsEncodedString = "";
	foreach ($sitParams as $sitParamName=>$sitParamValue) {
		$sitParamsString .= "&".$sitParamName."=".$sitParamValue;
		$sitParamsEncodedString .= "&".urlencode($sitParamName)."=".urlencode($sitParamValue);
	}

	$sitParamsString .= $categorie ? "&idc=".$categorie : "";
	$sitParamsEncodedString .= $categorie ? "&idc=".$categorie : "";
	$url_fiche_xml = $rootSitUrl."Recherche".$sitParamsEncodedString;
	//$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Recherche".$sitParamsEncodedString, 120);
	$xml = new SimpleXMLElement($url_fiche_xml, null, true);
	
	$nodes = $xml->xpath('//resultats/details/detail');

	foreach($nodes as $node){
		$note_elt = $doc->createElement('doc');
		$root_elt->appendChild($note_elt);
		
		$carac = array(" "); 
		$intitule = str_replace($carac,'-', $node->intitule);
		
		$caracs = array("/");
		$lien = substr($lienCourant, 1);
		$alias = str_replace($caracs,'~', $lien);
		
		$url = 'Fiche/Detail/'.$node->attributes()->id.'/'.$alias.'/'.$intitule;
		var_dump($url);
		
		$id_field = $doc->createElement('field', $node->attributes()->id);
		$id_field->setAttribute('name', 'id');
		$note_elt->appendChild($id_field);
		
		$intitule_field = $doc->createElement('field', $node->intitule);
		$intitule_field->setAttribute('name', 'intitule');
		$note_elt->appendChild($intitule_field);
		
		//$commentaire1 = preg_replace("/&([\\w\\d]+|\\#\\d+);/si",' ', $node->commentaires->commentaire1);
		$cmt1_field = $doc->createElement('field', $node->commentaires->commentaire1);
		$cmt1_field->setAttribute('name', 'commentaire1');
		$note_elt->appendChild($cmt1_field);
		
		$cmt2_field = $doc->createElement('field', $node->commentaires->commentaire2);
		$cmt2_field->setAttribute('name', 'commentaire2');
		$note_elt->appendChild($cmt2_field);
		
		$url_field = $doc->createElement('field', $url);
		$url_field->setAttribute('name', 'url');
		$note_elt->appendChild($url_field);
		
		
		$doc->formatOutput = true;	
		
	}
		
		$doc->save('extension/ez_aya_sitsearch/java/sit_data.xml');
}


if(!$isQuiet) {
	$cli->output( "\nFin du cronjob");
}
?>
