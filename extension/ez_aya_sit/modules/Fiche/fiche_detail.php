<?php

require_once('kernel/common/template.php');
require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

$tpl = templateInit();

$contentIni = eZINI::instance('content.ini');
$sitIni = eZINI::instance('ez_aya_sit.ini');

$rootNode = $contentIni->variable('NodeSettings','RootNode');
if (!$rootNode) {
	$rootNode = "2";
}

$rootSitUrl = $sitIni->variable('GlobalSitParameters','RootSitUrl');

$cheminCacheXml = $sitIni->variable('GlobalSitParameters','XmlCachePath');
$currentDirectory = $_SERVER['DOCUMENT_ROOT'];
foreach (explode("/", $cheminCacheXml) as $cheminCacheXmlPart) {
	if ($cheminCacheXmlPart && !file_exists($currentDirectory)) {
		$currentDirectory .= "/".$cheminCacheXmlPart;
		mkdir($currentDirectory);
	}
}
$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;

$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParameters','XslPath');

$traductionsStatiques = $sitIni->variable('SitTranslations','StaticSitTranslations');

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
		$contenuXmlCache = utf8_encode(str_replace("&#128;", "__euro__", $contenuXmlDistant));
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

$cheminRacineSite = "/";
eZURI::transformURI($cheminRacineSite, false, 'full');

$modulePath = array();

$homeNode = eZFunctionHandler::execute(
	'content',
	'node',
	array ('node_path' => "/")
);

$modulePath[] = array('url' => '/', 'text' => $homeNode->attribute('name'));

$currentCheminCategorie = "";

$nodeExist = false;
$previousNode = null;
if ($cheminCategorie) {
	$cheminCategorie = explode("~", $cheminCategorie);
	foreach ($cheminCategorie as $cheminCategoriePart) {
		$currentCheminCategorie .= ($currentCheminCategorie ? "/" : "").$cheminCategoriePart;
		$currentNode = eZFunctionHandler::execute(
			'content',
			'node',
			array ('node_path' => $currentCheminCategorie)
		);

		if ($currentNode) {
			$nodeExist = true;
			$previousNode = $currentNode;
			$modulePath[] = array('url' => $currentNode->attribute('url_alias'), 'text' => $currentNode->attribute('name'));
		}
	}
}

if (!$nodeExist && array_key_exists('HTTP_REFERER', $_SERVER)) {
	$previousNode = eZFunctionHandler::execute(
		'content',
		'node',
		array ('node_path' => preg_replace("{^".$cheminRacineSite."/(.*?)(/\([^\)]*\)/[^/]*)*$}", "$1", $_SERVER['HTTP_REFERER']))
	);

	if ($previousNode) {
		$modulePath[] = array('url' => $previousNode->attribute('url_alias'), 'text' => $previousNode->attribute('name'));
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
	$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes", $traductionStatique));
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

$contenuBloc = "";
if (file_exists($cheminFichierCacheXml) && file_exists($cheminFichierXsl)) {
	$contenuBloc = SitUtils::getHtmlResult($cheminFichierCacheXml, $cheminFichierXsl, $xsltParemters);
}

$contenuBloc = preg_replace("/&([\w\d]+|\#\d+);/si", "_dw_entity__$1__", html_entity_decode($contenuBloc));
$contenuBloc = preg_replace("/&/si", "&amp;", $contenuBloc);
$contenuBloc = preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc);
$contenuBloc = preg_replace("/(http:\/\/[^\/]+):\d+/si", "$1", $contenuBloc);
$contenuBloc = "\n".preg_replace("/  /si", "\t", utf8_decode(str_replace("__euro__", "&euro;", $contenuBloc)))."\n";

$tpl->setVariable('contenuBloc', $contenuBloc);
$tpl->setVariable('previousNode', $previousNode);
$tpl->setVariable('view_parameters', $Params['UserParameters']);

$Result['content'] = $tpl->fetch("design:fiche_detail/fiche_detail.tpl");

$modulePath[] = array('url' => false, 'text' => $intituleFiche);

$Result['path'] = $modulePath;

?>
