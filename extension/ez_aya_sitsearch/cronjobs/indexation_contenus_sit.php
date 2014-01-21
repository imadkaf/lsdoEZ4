<?php
//require_once('extension/ez_aya_sitsearch/classes/sit_utils.class.php');

/* Liste des caractères spéciaux */
$char_specs_replace[] = "‾";	$char_specs_patern[] = "/&oline;/";
$char_specs_replace[] = "¯";	$char_specs_patern[] = "/&macr;/";
$char_specs_replace[] = "♠";	$char_specs_patern[] = "/&spades;/";
$char_specs_replace[] = "♣";	$char_specs_patern[] = "/&clubs;/";
$char_specs_replace[] = "♥";	$char_specs_patern[] = "/&hearts;/";
$char_specs_replace[] = "♦";	$char_specs_patern[] = "/&diams;/";
$char_specs_replace[] = "↔";	$char_specs_patern[] = "/&harr;/";
$char_specs_replace[] = "↓";	$char_specs_patern[] = "/&darr;/";
$char_specs_replace[] = "↑";	$char_specs_patern[] = "/&uarr;/";
$char_specs_replace[] = "→";	$char_specs_patern[] = "/&rArr;/";
$char_specs_replace[] = "→";	$char_specs_patern[] = "/&rarr;/";
$char_specs_replace[] = "←";	$char_specs_patern[] = "/&larr;/";
$char_specs_replace[] = "•";	$char_specs_patern[] = "/&bull;/";
$char_specs_replace[] = "Œ";	$char_specs_patern[] = "/&Oelig;/";
$char_specs_replace[] = "Š";	$char_specs_patern[] = "/&Scaron;/";
$char_specs_replace[] = "š";	$char_specs_patern[] = "/&scaron;/";
$char_specs_replace[] = "ˆ";	$char_specs_patern[] = "/&circ;/";
$char_specs_replace[] = "˜";	$char_specs_patern[] = "/&tilde;/";
$char_specs_replace[] = "‹";	$char_specs_patern[] = "/&lsaquo;/";
$char_specs_replace[] = "›";	$char_specs_patern[] = "/&rsaquo;/";
$char_specs_replace[] = "‰";	$char_specs_patern[] = "/&permil;/";
$char_specs_replace[] = "‡";	$char_specs_patern[] = "/&Dagger;/";
$char_specs_replace[] = "†";	$char_specs_patern[] = "/&dagger;/";
$char_specs_replace[] = "„";	$char_specs_patern[] = "/&bdquo;/";
$char_specs_replace[] = "“";	$char_specs_patern[] = "/&ldquo;/";
$char_specs_replace[] = "”";	$char_specs_patern[] = "/&rdquo;/";
$char_specs_replace[] = "‚";	$char_specs_patern[] = "/&sbquo;/";
$char_specs_replace[] = "—";	$char_specs_patern[] = "/&mdash;/";
$char_specs_replace[] = "–";	$char_specs_patern[] = "/&ndash;/";
$char_specs_replace[] = "’";	$char_specs_patern[] = "/&rsquo;/";
$char_specs_replace[] = "‘";	$char_specs_patern[] = "/&lsquo;/";
$char_specs_replace[] = "œ";	$char_specs_patern[] = "/&oelig;/";
$char_specs_replace[] = "...";	$char_specs_patern[] = "/&hellip;/";
$char_specs_replace[] = "Ÿ";	$char_specs_patern[] = "/&Yuml;/";
$char_specs_replace[] = " ";	$char_specs_patern[] = "/&nbsp;/";
$char_specs_replace[] = "¡";	$char_specs_patern[] = "/&iexcl;/";
$char_specs_replace[] = "¢";	$char_specs_patern[] = "/&cent;/";
$char_specs_replace[] = "£";	$char_specs_patern[] = "/&pound;/";
$char_specs_replace[] = "¤";	$char_specs_patern[] = "/&curren;/";
$char_specs_replace[] = "¥";	$char_specs_patern[] = "/&yen;/";
$char_specs_replace[] = "¦";	$char_specs_patern[] = "/&brvbar;/";
$char_specs_replace[] = "§";	$char_specs_patern[] = "/&sect;/";
$char_specs_replace[] = "¨";	$char_specs_patern[] = "/&uml;/";
$char_specs_replace[] = "©";	$char_specs_patern[] = "/&copy;/";
$char_specs_replace[] = "ª";	$char_specs_patern[] = "/&ordf;/";
$char_specs_replace[] = "«";	$char_specs_patern[] = "/&laquo;/";
$char_specs_replace[] = "¬";	$char_specs_patern[] = "/&not;/";
$char_specs_replace[] = "­";	$char_specs_patern[] = "/&shy;/";
$char_specs_replace[] = "®";	$char_specs_patern[] = "/&reg;/";
$char_specs_replace[] = "¯";	$char_specs_patern[] = "/&masr;/";
$char_specs_replace[] = "°";	$char_specs_patern[] = "/&deg;/";
$char_specs_replace[] = "±";	$char_specs_patern[] = "/&plusmn;/";
$char_specs_replace[] = "²";	$char_specs_patern[] = "/&sup2;/";
$char_specs_replace[] = "³";	$char_specs_patern[] = "/&sup3;/";
$char_specs_replace[] = "";	$char_specs_patern[] = "/&acute;/";
$char_specs_replace[] = "µ";	$char_specs_patern[] = "/&micro;/";
$char_specs_replace[] = "¶";	$char_specs_patern[] = "/&para;/";
$char_specs_replace[] = "·";	$char_specs_patern[] = "/&middot;/";
$char_specs_replace[] = "¸";	$char_specs_patern[] = "/&cedil;/";
$char_specs_replace[] = "¹";	$char_specs_patern[] = "/&sup1;/";
$char_specs_replace[] = "º";	$char_specs_patern[] = "/&ordm;/";
$char_specs_replace[] = "»";	$char_specs_patern[] = "/&raquo;/";
$char_specs_replace[] = "¼";	$char_specs_patern[] = "/&frac14;/";
$char_specs_replace[] = "½";	$char_specs_patern[] = "/&frac12;/";
$char_specs_replace[] = "¾";	$char_specs_patern[] = "/&frac34;/";
$char_specs_replace[] = "¿";	$char_specs_patern[] = "/&iquest;/";
$char_specs_replace[] = "À";	$char_specs_patern[] = "/&Agrave;/";
$char_specs_replace[] = "Á";	$char_specs_patern[] = "/&Aacute;/";
$char_specs_replace[] = "Â";	$char_specs_patern[] = "/&Acirc;/";
$char_specs_replace[] = "Ã";	$char_specs_patern[] = "/&Atilde;/";
$char_specs_replace[] = "Ä";	$char_specs_patern[] = "/&Auml;/";
$char_specs_replace[] = "Å";	$char_specs_patern[] = "/&Aring;/";
$char_specs_replace[] = "Æ";	$char_specs_patern[] = "/&Aelig;/";
$char_specs_replace[] = "Ç";	$char_specs_patern[] = "/&Ccedil;/";
$char_specs_replace[] = "È";	$char_specs_patern[] = "/&Egrave;/";
$char_specs_replace[] = "É";	$char_specs_patern[] = "/&Eacute;/";
$char_specs_replace[] = "Ê";	$char_specs_patern[] = "/&Ecirc;/";
$char_specs_replace[] = "Ë";	$char_specs_patern[] = "/&Euml;/";
$char_specs_replace[] = "Ì";	$char_specs_patern[] = "/&Igrave;/";
$char_specs_replace[] = "Í";	$char_specs_patern[] = "/&Iacute;/";
$char_specs_replace[] = "Î";	$char_specs_patern[] = "/&Icirc;/";
$char_specs_replace[] = "Ï";	$char_specs_patern[] = "/&Iuml;/";
$char_specs_replace[] = "Ð";	$char_specs_patern[] = "/&eth;/";
$char_specs_replace[] = "Ñ";	$char_specs_patern[] = "/&Ntilde;/";
$char_specs_replace[] = "Ò";	$char_specs_patern[] = "/&Ograve;/";
$char_specs_replace[] = "Ó";	$char_specs_patern[] = "/&Oacute;/";
$char_specs_replace[] = "Ô";	$char_specs_patern[] = "/&Ocirc;/";
$char_specs_replace[] = "Õ";	$char_specs_patern[] = "/&Otilde;/";
$char_specs_replace[] = "Ö";	$char_specs_patern[] = "/&Ouml;/";
$char_specs_replace[] = "×";	$char_specs_patern[] = "/&times;/";
$char_specs_replace[] = "Ø";	$char_specs_patern[] = "/&Oslash;/";
$char_specs_replace[] = "Ù";	$char_specs_patern[] = "/&Ugrave;/";
$char_specs_replace[] = "Ú";	$char_specs_patern[] = "/&Uacute;/";
$char_specs_replace[] = "Û";	$char_specs_patern[] = "/&Ucirc;/";
$char_specs_replace[] = "Ü";	$char_specs_patern[] = "/&Uuml;/";
$char_specs_replace[] = "Ý";	$char_specs_patern[] = "/&Yacute;/";
$char_specs_replace[] = "Þ";	$char_specs_patern[] = "/&thorn;/";
$char_specs_replace[] = "ß";	$char_specs_patern[] = "/&szlig;/";
$char_specs_replace[] = "à";	$char_specs_patern[] = "/&agrave;/";
$char_specs_replace[] = "á";	$char_specs_patern[] = "/&aacute;/";
$char_specs_replace[] = "â";	$char_specs_patern[] = "/&acirc;/";
$char_specs_replace[] = "ã";	$char_specs_patern[] = "/&atilde;/";
$char_specs_replace[] = "ä";	$char_specs_patern[] = "/&auml;/";
$char_specs_replace[] = "å";	$char_specs_patern[] = "/&aring;/";
$char_specs_replace[] = "æ";	$char_specs_patern[] = "/&aelig;/";
$char_specs_replace[] = "ç";	$char_specs_patern[] = "/&ccedil;/";
$char_specs_replace[] = "è";	$char_specs_patern[] = "/&egrave;/";
$char_specs_replace[] = "é";	$char_specs_patern[] = "/&eacute;/";
$char_specs_replace[] = "ê";	$char_specs_patern[] = "/&ecirc;/";
$char_specs_replace[] = "ë";	$char_specs_patern[] = "/&euml;/";
$char_specs_replace[] = "ì";	$char_specs_patern[] = "/&igrave;/";
$char_specs_replace[] = "í";	$char_specs_patern[] = "/&iacute;/";
$char_specs_replace[] = "î";	$char_specs_patern[] = "/&icirc;/";
$char_specs_replace[] = "ï";	$char_specs_patern[] = "/&iuml;/";
$char_specs_replace[] = "ð";	$char_specs_patern[] = "/&eth;/";
$char_specs_replace[] = "ñ";	$char_specs_patern[] = "/&ntilde;/";
$char_specs_replace[] = "ò";	$char_specs_patern[] = "/&ograve;/";
$char_specs_replace[] = "ó";	$char_specs_patern[] = "/&oacute;/";
$char_specs_replace[] = "ô";	$char_specs_patern[] = "/&ocirc;/";
$char_specs_replace[] = "õ";	$char_specs_patern[] = "/&otilde;/";
$char_specs_replace[] = "ö";	$char_specs_patern[] = "/&ouml;/";
$char_specs_replace[] = "÷";	$char_specs_patern[] = "/&divide;/";
$char_specs_replace[] = "ø";	$char_specs_patern[] = "/&oslash;/";
$char_specs_replace[] = "ù";	$char_specs_patern[] = "/&ugrave;/";
$char_specs_replace[] = "ú";	$char_specs_patern[] = "/&uacute;/";
$char_specs_replace[] = "û";	$char_specs_patern[] = "/&ucirc;/";
$char_specs_replace[] = "ü";	$char_specs_patern[] = "/&uuml;/";
$char_specs_replace[] = "ý";	$char_specs_patern[] = "/&yacute;/";
$char_specs_replace[] = "þ";	$char_specs_patern[] = "/&thorn;/";
$char_specs_replace[] = "ÿ";	$char_specs_patern[] = "/&yuml;/";

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
$ayaIni = eZINI::instance('ez_aya_sitsearch.ini');
if ($ayaIni->hasVariable('SiteMobile', 'lessablesmobi')) {
	$nodeIdSiteMobile = $ayaIni->variable('SiteMobile','lessablesmobi');
}
$cpt = 0;
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
	
	$indexTabSearch=99999;
	
	$pathString=explode('/',$nodeObject->PathString);
	
	if (in_array($nodeIdSiteMobile,$pathString)) {
		$indexTabSearch=100000;
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
		//if ($cpt == 10) break;
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
		
		$meta_path_si = $doc->createElement('field', $indexTabSearch);
		$meta_path_si->setAttribute('name', 'meta_path_si');
		$note_elt->appendChild($meta_path_si);
		
		$meta_path_string_ms = $doc->createElement('field', '/'.$indexTabSearch.'/');
		$meta_path_string_ms->setAttribute('name', 'meta_path_string_ms');
		$note_elt->appendChild($meta_path_string_ms); 
		
		$meta_guid_ms = $doc->createElement('field', md5(eZSolr::installationID().'-'."sit_fiche_".$detail->attributes()->id.'-'."fre-FR"));
		$meta_guid_ms->setAttribute('name', 'meta_guid_ms');
		$note_elt->appendChild($meta_guid_ms);
		
		$meta_section_id_si = $doc->createElement('field', "1");
		$meta_section_id_si->setAttribute('name', 'meta_section_id_si');
		$note_elt->appendChild($meta_section_id_si);				
		
		$intitule_field_s = $doc->createElement('field', preg_replace($char_specs_patern,$char_specs_replace, $detail->intitule));
		$intitule_field_s->setAttribute('name', 'attr_name_s');
		$note_elt->appendChild($intitule_field_s);
		
		$intitule_field_t = $doc->createElement('field', preg_replace($char_specs_patern,$char_specs_replace, $detail->intitule));
		$intitule_field_t->setAttribute('name', 'attr_name_t');
		$note_elt->appendChild($intitule_field_t);
		
		$commentaire1 = preg_replace("/&euro;/si",'€', utf8_encode((string) $detail->commentaires->commentaire1));
		$commentaire1 = preg_replace("/&rand/si",'&amp;rand', $commentaire1);
                
                $commentaire1 = preg_replace($char_specs_patern,$char_specs_replace, $commentaire1);
                //$commentaire1 = utf8_encode($commentaire1);
                
                
		$commentaire1 = preg_replace("/\\\\n|\r/si",'', $commentaire1);
		
		$commentaire1 = preg_replace("/ & /si",' &amp; ', $commentaire1);
		$cmt1_field = $doc->createElement('field', trim($commentaire1));
		$cmt1_field->setAttribute('name', 'attr_content_s');
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
		
		$meta_name_t_field = $doc->createElement('field',preg_replace($char_specs_patern,$char_specs_replace, $detail->intitule ));
		$meta_name_t_field->setAttribute('name', 'meta_name_t');
		$note_elt->appendChild($meta_name_t_field);
		
		
		$date_maj = str_replace(" ",'T', $detail->dateMAJ).'Z';
		$meta_modified_field = $doc->createElement('field',$date_maj);
		$meta_modified_field->setAttribute('name', 'meta_modified_dt');
		$note_elt->appendChild($meta_modified_field);
		
		$meta_published_field = $doc->createElement('field', $date_maj);
		$meta_published_field->setAttribute('name', 'meta_published_dt');
		$note_elt->appendChild($meta_published_field);
		
		$meta_sort_name_ms = $doc->createElement('field', preg_replace($char_specs_patern,$char_specs_replace, $detail->intitule));
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
