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

$sitIni = eZINI::instance('ez_aya_sit.ini');
$cpt = 0;
foreach ($nodeObjects as $nodeObject) {
	if ($cpt == 10) break;
	$lienCourant = $nodeObject->attribute('url_alias');
	
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
	$sitParams['dwcom'] = "10000";
	$sitParams['dwdate'] = "111";
		
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

	$produits = $xml->xpath('//resultats/produit');	
	$details = $xml->xpath('//resultats/details/detail');
	
	foreach($details as $detail){
		if ($cpt == 10) break;
		$cpt++;
		//var_dump($detail);
		$id_detail = (string) $detail->attributes()->id;
		
		foreach ($produits as $produit){
			$id_produit = (string) $produit->attributes()->id;
			
			if(  $id_produit == $id_detail ){
				$nb_consultations = $produit->attributes()->nbConsultations;
				
			}
		}
		
		$note_elt = $doc->createElement('doc');
		$root_elt->appendChild($note_elt);
		
		$intitule = utf8_encode(preg_replace("/-+/si", "-", preg_replace("/[^\wŠŒŽšœžŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿ]/si",'-', trim($detail->intitule, "-"))));
		
		$lien = substr($lienCourant, 1);
		$alias = str_replace('/','~', $lien);
		
		$url = 'Fiche/Detail/'.$detail->attributes()->id.'/'.$alias.'/'.$intitule;
		//var_dump($url);
		
		/*$meta_installation_id_ms = $doc->createElement('field', eZSolr::installationID());
		$meta_installation_id_ms->setAttribute('name', 'meta_installation_id_ms');
		$note_elt->appendChild($meta_installation_id_ms);*/ 
		
		/*$meta_main_node_id_si= $doc->createElement('field', '99999');
		$meta_main_node_id_si->setAttribute('name', 'meta_main_node_id_si');
		$note_elt->appendChild($meta_main_node_id_si);*/
		
		$meta_installation_url_ms= $doc->createElement('field', '/');
		$meta_installation_url_ms->setAttribute('name', 'meta_installation_url_ms');
		$note_elt->appendChild($meta_installation_url_ms);
		
		$meta_is_invisible_b = $doc->createElement('field', 'false');
		$meta_is_invisible_b->setAttribute('name', 'meta_is_invisible_b');
		$note_elt->appendChild($meta_is_invisible_b); 
		
		$meta_path_si = $doc->createElement('field', '99999');
		$meta_path_si->setAttribute('name', 'meta_path_si');
		$note_elt->appendChild($meta_path_si);
		
		$meta_path_string_ms = $doc->createElement('field', '/99999/');
		$meta_path_string_ms->setAttribute('name', 'meta_path_string_ms');
		$note_elt->appendChild($meta_path_string_ms); 
		
		$meta_guid_ms = $doc->createElement('field', md5(eZSolr::installationID().'-'."sit_fiche_".$detail->attributes()->id.'-'."fre-FR"));
		$meta_guid_ms->setAttribute('name', 'meta_guid_ms');
		$note_elt->appendChild($meta_guid_ms);
		
		$meta_section_id_si = $doc->createElement('field', "1");
		$meta_section_id_si->setAttribute('name', 'meta_section_id_si');
		$note_elt->appendChild($meta_section_id_si);				
		
		$intitule_field_s = $doc->createElement('field', $detail->intitule);
		$intitule_field_s->setAttribute('name', 'attr_title_s');
		$note_elt->appendChild($intitule_field_s);
		
		$intitule_field_t = $doc->createElement('field', $detail->intitule);
		$intitule_field_t->setAttribute('name', 'attr_title_t');
		$note_elt->appendChild($intitule_field_t);
		
		$commentaire1 = preg_replace("/&euro;/si",'€', utf8_encode((string) $detail->commentaires->commentaire1));
		$commentaire1 = preg_replace("/\\\\n|\r/si",'', $commentaire1);
		$commentaire1 = preg_replace("/ & /si",' &amp; ', $commentaire1);
		$cmt1_field = $doc->createElement('field', trim($commentaire1));
		$cmt1_field->setAttribute('name', 'attr_description_t');
		$note_elt->appendChild($cmt1_field);
		
		$available_language_field = $doc->createElement('field', 'fre-FR');
		$available_language_field->setAttribute('name', 'meta_available_language_codes_ms');
		$note_elt->appendChild($available_language_field);
		
		$language_field = $doc->createElement('field', 'fre-FR');
		$language_field->setAttribute('name', 'meta_language_code_ms');
		$note_elt->appendChild($language_field);
		
		$main_url_alias_field = $doc->createElement('field', $url);
		$main_url_alias_field->setAttribute('name', 'meta_main_url_alias_ms');
		$note_elt->appendChild($main_url_alias_field);
		
		$meta_name_t_field = $doc->createElement('field', $detail->intitule);
		$meta_name_t_field->setAttribute('name', 'meta_name_t');
		$note_elt->appendChild($meta_name_t_field);
		
		
		$date_maj = str_replace(" ",'T', $detail->dateMAJ).'Z';
		$meta_modified_field = $doc->createElement('field',$date_maj);
		$meta_modified_field->setAttribute('name', 'meta_modified_dt');
		$note_elt->appendChild($meta_modified_field);
		
		$meta_published_field = $doc->createElement('field', $date_maj);
		$meta_published_field->setAttribute('name', 'meta_published_dt');
		$note_elt->appendChild($meta_published_field);
		
		$meta_sort_name_ms = $doc->createElement('field', $detail->intitule);
		$meta_sort_name_ms->setAttribute('name', 'meta_sort_name_ms');
		$note_elt->appendChild($meta_sort_name_ms);
		
		$meta_url_alias_ms = $doc->createElement('field', $url);
		$meta_url_alias_ms->setAttribute('name', 'meta_url_alias_ms');
		$note_elt->appendChild($meta_url_alias_ms);
		
		$meta_is_hidden_b = $doc->createElement('field', 'false');
		$meta_is_hidden_b->setAttribute('name', 'meta_is_hidden_b');
		$note_elt->appendChild($meta_is_hidden_b);
		
		$meta_view_count_si = $doc->createElement('field', $nb_consultations);
		$meta_view_count_si->setAttribute('name', 'meta_view_count_si');
		$note_elt->appendChild($meta_view_count_si);
				
		$doc->formatOutput = true;			
	}
		
		$doc->save('extension/ez_aya_sitsearch/java/sit_data.xml');
}


if(!$isQuiet) {
	$cli->output( "\nFin du cronjob");
}
?>
