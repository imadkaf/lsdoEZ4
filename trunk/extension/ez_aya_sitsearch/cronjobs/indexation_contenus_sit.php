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
//$cpt = 0;
foreach ($nodeObjects as $nodeObject) {
	//if ($cpt == 10) break;
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
	
	
	$response = file_get_contents($url_fiche_xml);
	//var_dump(mb_detect_encoding($response));
	$response = iconv( "ISO-8859-1", "UTF-8//TRANSLIT", $response );
    $xml = simplexml_load_string($response, null);

    
	$produits = $xml->xpath('//resultats/produit');	
	$details = $xml->xpath('//resultats/details/detail');
	
	foreach($details as $detail){
		//if ($cpt == 10) break;
		//$cpt++;
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
		
		$clean = iconv('UTF-8', 'ASCII//IGNORE//TRANSLIT', utf8_decode(trim($detail->intitule)));	    
		$clean = preg_replace('/[\s]+/', '-', $clean);
	    $clean = preg_replace("/[^a-zA-Z0-9\/_|+-]/", '', $clean);
		$intitule = preg_replace("/-+/si", "-", $clean);

		$lien = substr($lienCourant, 1);
		$alias = str_replace('/','~', $lien);
		
		$url = 'Fiche/Detail/'.$detail->attributes()->id.'/'.$alias.'/'.$intitule;		
		
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
		
		$intitule_field_s = $doc->createElement('field');
		$intitule_field_s->setAttribute('name', 'attr_title_s');
		$text_intitule_field_s = $doc->createTextNode(utf8_decode(trim($detail->intitule)));
		$intitule_field_s->appendChild($text_intitule_field_s);
		$note_elt->appendChild($intitule_field_s);
		
		$intitule_field_t = $doc->createElement('field');
		$intitule_field_t->setAttribute('name', 'attr_title_t');
		$text_intitule_field_t = $doc->createTextNode(utf8_decode(trim($detail->intitule)));
		$intitule_field_t->appendChild($text_intitule_field_t);
		$note_elt->appendChild($intitule_field_t);
		
		$commentaire1 = preg_replace("/&euro;/si",'€', utf8_decode(trim($detail->commentaires->commentaire1)));
		$commentaire1 = preg_replace("/\\\\n|\r/si",'', $commentaire1);
		$commentaire1 = str_replace("\x92","'",$commentaire1);
		$commentaire1 = str_replace("\x9c","oe",$commentaire1);
		$commentaire1 = str_replace("\x97","?",$commentaire1);
		$commentaire1 = str_replace("\xC3\x80","&Agrave;",$commentaire1);
		$commentaire1 = str_replace("\x80","€",$commentaire1);
		$commentaire1 = str_replace("\x96","-",$commentaire1);
		$commentaire1 = str_replace("\x85","...",$commentaire1);
		$commentaire1 = str_replace("\x95"," - ",$commentaire1);
		$commentaire1 = str_replace("<b>","",$commentaire1);
		$commentaire1 = str_replace("</b>","",$commentaire1);
		$commentaire1 = str_replace("&","",$commentaire1);
		$commentaire1 = str_replace(0xE2,"",$commentaire1);
				
		$cmt1_field = $doc->createElement('field');
		$note_elt->appendChild($cmt1_field);
		$cmt1_field->setAttribute('name', 'attr_description_t');
		$text_cmt1 = $doc->createTextNode($commentaire1);
		$cmt1_field->appendChild($text_cmt1);
		
		$available_language_field = $doc->createElement('field', 'fre-FR');
		$available_language_field->setAttribute('name', 'meta_available_language_codes_ms');
		$note_elt->appendChild($available_language_field);
		
		$language_field = $doc->createElement('field', 'fre-FR');
		$language_field->setAttribute('name', 'meta_language_code_ms');
		$note_elt->appendChild($language_field);
		
		
		$main_url_alias_field = $doc->createElement('field');
		$note_elt->appendChild($main_url_alias_field);
		$main_url_alias_field->setAttribute('name', 'meta_main_url_alias_ms');
		$text_main_url_alias_field = $doc->createTextNode($url);
		$main_url_alias_field->appendChild($text_main_url_alias_field );
		
		$meta_name_t_field = $doc->createElement('field');
		$meta_name_t_field->setAttribute('name', 'meta_name_t');
		$text_meta_name_t_field = $doc->createTextNode(utf8_decode(trim($detail->intitule)));
		$meta_name_t_field->appendChild($text_meta_name_t_field);
		$note_elt->appendChild($meta_name_t_field);
				
		$date_maj = str_replace(" ",'T', $detail->dateMAJ).'Z';
		$meta_modified_field = $doc->createElement('field',$date_maj);
		$meta_modified_field->setAttribute('name', 'meta_modified_dt');
		$note_elt->appendChild($meta_modified_field);
		
		$meta_published_field = $doc->createElement('field', $date_maj);
		$meta_published_field->setAttribute('name', 'meta_published_dt');
		$note_elt->appendChild($meta_published_field);
		
		$meta_sort_name_ms = $doc->createElement('field');
		$meta_sort_name_ms->setAttribute('name', 'meta_sort_name_ms');
		$text_meta_sort_name_ms = $doc->createTextNode(utf8_decode(trim($detail->intitule)));
		$meta_sort_name_ms->appendChild($text_meta_sort_name_ms);
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
