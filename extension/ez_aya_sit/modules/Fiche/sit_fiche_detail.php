<?php

require_once('kernel/common/template.php');
require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

$tpl = templateInit();

$contentIni = eZINI::instance('content.ini');
$sitIni = eZINI::instance('ez_aya_sit.ini');

$siteIni = eZINI::instance('site.ini');

$langue = $siteIni->variable('RegionalSettings','Locale');
if ($langue) {
	$langue = substr($langue, 0, 2);
}

$rootNode = $contentIni->variable('NodeSettings','RootNode');
if (!$rootNode) {
	$rootNode = "2";
}

if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
	$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
} else {
	$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
}

if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XmlCachePath')) {
	$cheminCacheXml = $sitIni->variable('GlobalSitParametersOverride','XmlCachePath');
} else {
	$cheminCacheXml = $sitIni->variable('GlobalSitParameters','XmlCachePath');
}
$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;
if (!file_exists($cheminCacheXml)) {
	mkdir($cheminCacheXml, 0777, true);
}

if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XslPath')) {
	$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParametersOverride','XslPath');
} else {
	$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParameters','XslPath');
}

$traductionsStatiques = $sitIni->variable('SitTranslations','StaticSitTranslations');
$traductionsStatiquesComplementaires = array();
		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'StaticSitTranslations')) {
			$traductionsStatiquesComplementaires = $sitIni->variable('GlobalSitParametersOverride','StaticSitTranslations');
		}
		foreach ($traductionsStatiquesComplementaires as $traductionStatiqueComplementaire) {
			if (!in_array($traductionStatiqueComplementaire, $traductionsStatiques)) {
				$traductionsStatiques[] = $traductionStatiqueComplementaire;
			}
		}

$dureeVieCache = $sitIni->variable('GlobalSitParameters','DureeVieCacheFiche') * 60;
$idFiche = $Params['idFiche'];
$cheminCategorie = $Params['cheminCategorie'];

$xslFile = null;
if (array_key_exists('UserParameters', $Params) && array_key_exists('xsl', $Params['UserParameters'])) {
	$xslFile = $Params['UserParameters']['xsl'];
}
if (!$xslFile || !trim($xslFile)) {
	$xslFile = "sit_fiche";
}

$triEnCours = "";
if (array_key_exists('UserParameters', $Params) && array_key_exists('tri', $Params['UserParameters'])) {
	$triEnCours = $Params['UserParameters']['tri'];
}

$rechercheEnCours = "non";
if (array_key_exists('UserParameters', $Params) && array_key_exists('recherche', $Params['UserParameters'])) {
	$rechercheEnCours = $Params['UserParameters']['recherche'];
}

$pageCourante = "";
if (array_key_exists('UserParameters', $Params) && array_key_exists('page', $Params['UserParameters'])) {
	$pageCourante = $Params['UserParameters']['page'];
}

$sitParamsString = $idFiche ? "&idP=".$idFiche : "";
$sitParamsString .= $langue ? "&lang=".$langue : "";

$sitParamsStringCrypte = sha1("Produit__".substr($sitParamsString, 1));

$cheminFichierCacheXml = $cheminCacheXml.$sitParamsStringCrypte.".xml";

$cacheExpire = true;
if (file_exists($cheminFichierCacheXml)) {
	$maintenant = time();
	$dateExpirationCache = filemtime($cheminFichierCacheXml)+$dureeVieCache;
	if ($dateExpirationCache > $maintenant) {
		$cacheExpire = false;
	}
}
$contenuXmlDistant = "";
if ($cacheExpire) {
	$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Produit".$sitParamsString, 5);
	if ($contenuXmlDistant) {
		$contenuXmlCache = utf8_encode(preg_replace("/&([\\w\\d]+|\\#\\d+);/si", "_dw_entity__$1__", $contenuXmlDistant));
		file_put_contents($cheminFichierCacheXml, $contenuXmlCache, LOCK_EX);
	}
}

eZLog::write($rootSitUrl."Produit".$sitParamsString, "ez_aya_sit.log");

$cheminRacineSite = "/";
eZURI::transformURI($cheminRacineSite);
$cheminRacineSite = $cheminRacineSite == "/" ? "" : $cheminRacineSite;

$xsltParemters = array();
$xsltParemters['cheminImages'] = eZURLOperator::eZImage($tpl, 'sit/', '');
$xsltParemters['cheminRacineSite'] = $cheminRacineSite;

$xsltParemters['triEnCours'] = $triEnCours;
$xsltParemters['rechercheEnCours'] = $rechercheEnCours;
$xsltParemters['pageCourante'] = $pageCourante;

$xsltParemters['langue'] = $langue;

$cheminRacineSite = "/";
eZURI::transformURI($cheminRacineSite, false, 'full');

$modulePath = array();

$homeNode = eZFunctionHandler::execute(
	'content',
	'node',
	array ('node_id' => $rootNode)
);

$modulePath[] = array('url' => '/', 'url_alias' => '/', 'text' => $homeNode->attribute('name'), 'node_id' => $rootNode);

$currentCheminCategorie = "";

$nodeExist = false;
$previousNode = null;
if ($cheminCategorie) {
	$cheminCategorie = explode("~", $cheminCategorie);
	$contentRootNode = $contentIni->variable('NodeSettings','ContentRootNode');
	foreach ($cheminCategorie as $cheminCategoriePart) {
		$currentCheminCategorie .= ($currentCheminCategorie ? "/" : "").$cheminCategoriePart;
		$currentNode = eZFunctionHandler::execute(
			'content',
			'node',
			array ('node_path' => $currentCheminCategorie)
		);

		if ($currentNode) {
			$previousNode = $currentNode;
			$nodeExist = true;
			if ($currentNode->attribute('node_id') != $rootNode && (!$contentRootNode || $contentRootNode != $rootNode)) {
				$modulePath[] = array('url' => $currentNode->attribute('url_alias'), 'url_alias' => $currentNode->attribute('url_alias'), 'text' => $currentNode->attribute('name'), 'node_id' => $currentNode->attribute('node_id'));
			}
		}
	}
}

if (!$nodeExist && array_key_exists('HTTP_REFERER', $_SERVER)) {
	$httpReferer = preg_replace("{^".$cheminRacineSite."/(.*?)(/\\([^\\)]*\\)/[^/]*)*$}", "$1", $_SERVER['HTTP_REFERER']);
	$httpReferer = $httpReferer ? $httpReferer : "/";
	$previousNode = eZFunctionHandler::execute(
		'content',
		'node',
		array ('node_path' => $httpReferer)
	);

	if ($previousNode) {
		$modulePath[] = array('url' => $previousNode->attribute('url_alias'), 'url_alias' => $previousNode->attribute('url_alias'), 'text' => $previousNode->attribute('name'), 'node_id' => $previousNode->attribute('node_id'));
	}
}

$lienPrecedent = "";
if ($previousNode) {
	$lienPrecedent = $previousNode->attribute('url_alias');
	eZURI::transformURI($lienPrecedent);
}

$xsltParemters['lienPrecedent'] = $lienPrecedent;

$xsltParemters['anneeCourante'] = date("Y");

$categorie = null;
$intituleFiche = "Fiche inconnue";
if (file_exists($cheminFichierCacheXml)) {
	$xmlFiche = simplexml_load_file($cheminFichierCacheXml);
	if ($xmlFiche) {
		$categorieNode = $xmlFiche->xpath("/produit/categorie[string-length(@id) > 0]");
		if ($categorieNode && count($categorieNode) > 0) {
			$categorie = $categorieNode[0]->attributes()->id;
		}

		$intituleFicheNode = $xmlFiche->xpath('/produit/intitule');
		if ($intituleFicheNode && count($intituleFicheNode) > 0) {
			$intituleFiche = utf8_decode("".$intituleFicheNode[0]);
		}
	}
}

$criteresAffiches = array();
$criteresNonAffiches = array();
$modeAffichageCriteres = array('0');
if ($categorie) {
	$fetchParams = array (
		'parent_node_id' => $previousNode ? $previousNode->attribute('node_id') : $rootNode,
		'attribute_filter' => array(array('sit_fiche/categorie', '=', $categorie)),
		'sort_by' => array('modified', false),
		'offset' => 0,
		'limit' => 1,
		'class_filter_type' => 'include',
		'class_filter_array' => array('sit_fiche')
	);

	$detailNodes = eZFunctionHandler::execute(
		'content',
		'list',
		$fetchParams
	);

	if (!$detailNodes || count($detailNodes) == 0) {
		$fetchParams['parent_node_id'] = $rootNode;
		$detailNodes = eZFunctionHandler::execute(
			'content',
			'list',
			$fetchParams
		);
	}

	if ($detailNodes && count($detailNodes) > 0) {
		$sitFiche = $detailNodes[0]->attribute('object');
		if ($sitFiche) {
			$sitFiche = $sitFiche->dataMap();
		}

		if ($sitFiche) {
			$modeAffichageCriteres = $sitFiche['mode_affichage_criteres']->value();
			$criteresAffiches = $sitFiche['criteres_affiches']->value();
			$criteresNonAffiches = $sitFiche['criteres_non_affiches']->value();
		}
	}
}
$xsltParemters['modeAffichageCriteres'] = $modeAffichageCriteres[0] == '1' ? "afficher" : ($modeAffichageCriteres[0] == '2' ? "pas_afficher" : "afficher_tout");
$xsltParemters['criteresAffiches'] = "|".implode("|", $criteresAffiches)."|";
$xsltParemters['criteresNonAffiches'] = "|".implode("|", $criteresNonAffiches)."|";

foreach ($traductionsStatiques as $traductionStatique) {
	if (ezpI18n::tr("sit/termes/override", $traductionStatique) != $traductionStatique) {
		$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes/override", $traductionStatique));
	} else {
		$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes", $traductionStatique));
	}
}

if (!$categorie && $previousNode) {
	$sitListe = $previousNode->attribute('object');

	if (!$sitListe || $sitListe->ClassIdentifier != 'sit_liste') {
		$previousNodeObjects = eZFunctionHandler::execute(
			'content',
			'list',
			array (
				'parent_node_id' => $previousNode->attribute('node_id'),
				'offset' => 0,
				'limit' => 1,
				'class_filter_type' => 'include',
				'class_filter_array' => array('sit_liste')
			)
		);

		if ($previousNodeObjects) {
			$sitListe = $previousNodeObjects[0];
		}
	}

	if ($sitListe) {
		$sitListe = $sitListe->dataMap();

		$categorie = $sitListe['categorie']->value();
		$categorie = $categorie[0];
	}
}
$cheminFichierXsl = null;
if ($categorie) {
	$cheminFichierXsl = $cheminXsl.$xslFile."_".$categorie.".xsl";
}
if (!$cheminFichierXsl || !file_exists($cheminFichierXsl)) {
	$cheminFichierXsl = $cheminXsl.$xslFile.".xsl";
}

/* Déb : Test de la validité de la fiche */
$fichierCacheSimpleXml = simplexml_load_file($cheminFichierCacheXml);
$ficheDateValiditeDebut = $fichierCacheSimpleXml->xpath("/produit/dateValidite/dateValiditeDebut");
$ficheDateValiditeFin = $fichierCacheSimpleXml->xpath("/produit/dateValidite/dateValiditeFin");
$_ficheProduitIsValid = true;
if(is_array($ficheDateValiditeDebut) && count($ficheDateValiditeDebut)>0){
    $ficheDateValiditeDebut = (string)$ficheDateValiditeDebut[0];
}
if(is_array($ficheDateValiditeFin)  && count($ficheDateValiditeFin)>0){
    $ficheDateValiditeFin = (string)$ficheDateValiditeFin[0];
}

/* Redirect si les date de den et fin de validité ne sont pas renseignées */
if(!is_string($ficheDateValiditeDebut) || strlen(trim($ficheDateValiditeDebut)) == 0){
    $_ficheProduitIsValid = false;
}
if(!is_string($ficheDateValiditeFin) || strlen(trim($ficheDateValiditeDebut)) == 0){
    $_ficheProduitIsValid = false;
}

//$ficheDateValiditeDebutTS = strtotime(trim($ficheDateValiditeDebut));
//$ficheDateValiditeFinTS = strtotime(trim($ficheDateValiditeFin)) + (24*60*60);//+1j pour inclure ledernier jour de date de fin


/* Normaliser le format date (yyyy-dd-mm) */
$ficheDateValiditeDebut = preg_replace("/\\//","-",$ficheDateValiditeDebut);
$ficheDateValiditeFin = preg_replace("/\\//","-",$ficheDateValiditeFin);

$ficheDateValiditeDebutArr = explode("-",$ficheDateValiditeDebut);
$ficheDateValiditeFinArr = explode("-",$ficheDateValiditeFin);

$ficheDateValiditeDebutInt = (int) preg_replace("/-/","",$ficheDateValiditeDebut);
$ficheDateValiditeFinInt = (int) preg_replace("/-/","",$ficheDateValiditeFin);
$currentDateInt = (int)date('Ymd');

/* Hack pour timestamp false (date > 2038 )*/
if(is_array($ficheDateValiditeDebutArr) && is_array($ficheDateValiditeFinArr)){
    /* Valide pour le format yyyy-mm-dd */
    foreach ($ficheDateValiditeDebutArr as $dateKey=>$dateVal){
        if((int)$dateVal > 9){
            $dateVal = '0'.((int)$dateVal);
        }
        $ficheDateValiditeDebutArr[$dateKey] = (int)$dateVal;
    }
    foreach ($ficheDateValiditeFinArr as $dateKey => $dateVal){
        if((int)$dateVal > 9){
            $dateVal ='0'.((int)$dateVal);
        }
        $ficheDateValiditeFinArr[$dateKey] = $dateVal;
    }
    $ficheDateValiditeDebutInt = (int)  implode("", $ficheDateValiditeDebutArr);
    $ficheDateValiditeFinInt = (int)  implode("", $ficheDateValiditeFinArr) + 1;
}

if(!$_ficheProduitIsValid || $ficheDateValiditeDebutInt > $currentDateInt || $currentDateInt > $ficheDateValiditeFinInt){
    /* Redirection vers la page sit liste */
    if(is_object($previousNode) && $previousNode->attribute('url_alias')){
        return $Module->redirectTo( $previousNode->attribute('url_alias'));
    }
    return $Module->redirectTo( '/' );
}
/* Fin : Test de la validité de la fiche */

$contenuBloc = "";
if (file_exists($cheminFichierCacheXml) && file_exists($cheminFichierXsl)) {
	$contenuBloc = SitUtils::getHtmlResult($cheminFichierCacheXml, $cheminFichierXsl, $xsltParemters);
}

$contenuBloc = preg_replace("/_dw_entity__#13__\n/si", " ", $contenuBloc);
$contenuBloc = utf8_decode(preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc));
$contenuBloc = preg_replace("/&amp;([\\w\\d]+|\\#\\d+);/si", "&$1;", html_entity_decode($contenuBloc));
$contenuBloc = "\n".preg_replace("/(http:\\/\\/[^\\/]+):\\d+/si", "$1", $contenuBloc)."\n";

$tpl->setVariable('idFicheEnCours', $idFiche);
$tpl->setVariable('contenuBloc', $contenuBloc);
$tpl->setVariable('previousNode', $previousNode);
$tpl->setVariable('view_parameters', $Params['UserParameters']);

$Result['content'] = $tpl->fetch("design:fiche_detail/fiche_detail.tpl");

$intituleFiche = preg_replace("/&([\\w\\d]+|\\#\\d+);/si", "_dw_entity__$1__", html_entity_decode($intituleFiche));
$intituleFiche = utf8_decode(preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $intituleFiche));
$intituleFiche = html_entity_decode($intituleFiche);

$modulePath[] = array('url' => false, 'url_alias' => false, 'text' => utf8_encode($intituleFiche), 'node_id' => false);

$Result['path'] = $modulePath;

?>
