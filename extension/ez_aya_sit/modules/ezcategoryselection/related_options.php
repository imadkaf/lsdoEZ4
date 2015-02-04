<?php

require_once('kernel/common/template.php');
require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

$http = eZHTTPTool::instance();

$tpl = eZTemplate::factory();

$search = "";
if ($http->hasVariable('s')) {
	$search = $http->variable('s');
}
$attributeId = "";
if ($http->hasVariable('ai')) {
	$attributeId = $http->variable('ai');
}
$categoryAttributeValue = "";
if ($http->hasVariable('cav')) {
	$categoryAttributeValue = $http->variable('cav');
}

$attribute = eZContentClassAttribute::fetch($attributeId);

$class = eZContentClass::fetch($attribute->ContentClassID);

$sitIni = eZINI::instance('ez_aya_sit.ini');

$attributsCriteresTri = $sitIni->variable('ClassesAttributsSit','AttributsCriteresTri_'.$class->Identifier);

if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
	$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
} else {
	$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
}

$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Categories", 5);
$idsToutesCategories = array();
if ($contenuXmlDistant) {
	$simpleXml = simplexml_load_string($contenuXmlDistant);
	$idsToutesCategories = $simpleXml->xpath("/categories/categorie[@nbFils = '0']/@id");
}

$foundOptions = array();

$criteresCommunsTris = array(
	'1' => "Commune",
	'3' => "Nombre de consultations",
	'4' => "Date d'ouverture",
);

if (in_array($attribute->Identifier, $attributsCriteresTri)) {
	if (!$search || strpos(strtr("Aléatoire", "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"), str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"))) !== false) {
		$foundOptions[($attribute->Identifier == 'criteres_tri_principaux' ? "a" : "")."2"] = array();
		$foundOptions[($attribute->Identifier == 'criteres_tri_principaux' ? "a" : "")."2"]['name'] = "Aléatoire";
		$foundOptions[($attribute->Identifier == 'criteres_tri_principaux' ? "a" : "")."2"]['categories'] = "-".join("-",$idsToutesCategories)."-";
	}

	foreach ($criteresCommunsTris as $key=>$critereCommunTri) {
		if (!$search || strpos(strtr($critereCommunTri, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"), str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"))) !== false) {
			$foundOptions[($attribute->Identifier == 'criteres_tri_principaux' ? "a" : "").$key] = array();
			$foundOptions[($attribute->Identifier == 'criteres_tri_principaux' ? "a" : "").$key]['name'] = $critereCommunTri.($attribute->Identifier == 'criteres_tri_principaux' ? " (Ascendant)" : "");
			$foundOptions[($attribute->Identifier == 'criteres_tri_principaux' ? "a" : "").$key]['categories'] = "-".join("-",$idsToutesCategories)."-";

			if ($attribute->Identifier == 'criteres_tri_principaux') {
				$foundOptions["d".$key] = array();
				$foundOptions["d".$key]['name'] = $critereCommunTri. " (Descendant)";
				$foundOptions["d".$key]['categories'] = "-".join("-",$idsToutesCategories)."-";
			}
		}
	}
}

$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Criteres&idC=".$categoryAttributeValue, 5);

$foundOptionsTmp = array();
if ($contenuXmlDistant) {
	$simpleXml = simplexml_load_string($contenuXmlDistant);
	$criteres1 = $simpleXml->xpath("/criteres/criteresSpecs/critere[starts-with(translate(intCritere, 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "') or count(modalites/modalite[starts-with(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "')]) > 0]");

	$criteres2 = $simpleXml->xpath("/criteres/criteresSpecs/critere[starts-with(translate(intCritere, 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "') or count(modalites/modalite[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "')]) > 0]");

	$criteres3 = $simpleXml->xpath("/criteres/criteresSpecs/critere[contains(translate(intCritere, 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "') or count(modalites/modalite[starts-with(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "')]) > 0]");

	$criteres4 = $simpleXml->xpath("/criteres/criteresSpecs/critere[contains(translate(intCritere, 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "') or count(modalites/modalite[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "')]) > 0]");

	foreach (array_merge($criteres1, $criteres2, $criteres3, $criteres4) as $critere) {
		$foundOptionsTmp["".$critere->attributes()->id] = array();

		$critereChildren = $critere->children();
		$foundOptionsTmp["".$critere->attributes()->id]['name'] = $critereChildren[0];
		$foundOptionsTmp["".$critere->attributes()->id]['categories'] = "-".str_replace("," , "-", "".$critere->attributes()->idsToutesCategories)."-";

		if (!$search || strpos(strtr($critereChildren[0], "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"), str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"))) !== false) {
			$modalites = $critereChildren[1]->children();
		} else {
			$modalites = $critereChildren[1]->xpath("modalite[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß', 'abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß'), '" . str_replace("'" , "\\'", strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) . "')]");
		}
		foreach ($modalites as $modalite) {
			$foundOptionsTmp["".$modalite->attributes()->id] = array();
			$foundOptionsTmp["".$modalite->attributes()->id]['name'] = $critereChildren[0]." — ".$modalite;
			$foundOptionsTmp["".$modalite->attributes()->id]['categories'] = "-".str_replace("," , "-", "".$critere->attributes()->idsToutesCategories)."-";
		}
	}
}

if ($attribute->Identifier == 'criteres_tri_principaux') {
	foreach ($foundOptionsTmp as $id=>$foundOptionTmp) {
		$foundOptions["a".$id] = array();


		$foundOptions["a".$id]['name'] = $foundOptionTmp['name']. " (Ascendant)";
		$foundOptions["a".$id]['categories'] = $foundOptionTmp['categories'];

		$foundOptions["d".$id] = array();


		$foundOptions["d".$id]['name'] = $foundOptionTmp['name']. " (Descendant)";
		$foundOptions["d".$id]['categories'] = $foundOptionTmp['categories'];
	}
} else {
	foreach ($foundOptionsTmp as $id=>$foundOptionTmp) {
		$foundOptions["".$id] = array();

		$foundOptions["".$id]['name'] = $foundOptionTmp['name'];
		$foundOptions["".$id]['categories'] = $foundOptionTmp['categories'];
	}

}

/*if ( === 'criteres_tri_principaux') {
	$attributsCriteresTri = $sitIni->variable('ClassesAttributsSit','AttributsCriteresTri_'.$identifierClasseSIT);
	$attribute
}*/


/*$foundOptions = array();

if ($attribute) {
	$attributeOptions = $attribute->content();

	foreach ($attributeOptions['options'] as $attributeOption) {
		if (!$categoryAttributeValue || in_array($categoryAttributeValue, $attributeOption['categories'][0]['category_value'])) {
			if (!$search || strpos(strtr($attributeOption['name'], "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"), strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) === 0) {
				$foundOptions[$attributeOption['id']] = array();
				$foundOptions[$attributeOption['id']]['name'] = $attributeOption['name'];
				$foundOptions[$attributeOption['id']]['categories'] = "-".implode('-', $attributeOption['categories'][0]['category_value'])."-";
			}
		}
	}

	foreach ($attributeOptions['options'] as $attributeOption) {
		if (!$categoryAttributeValue || in_array($categoryAttributeValue, $attributeOption['categories'][0]['category_value'])) {
			if (!$search || strpos(strtr($attributeOption['name'], "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß"), strtr($search, "ABCDEFGHIJKLMNOPQRSTUVWXYZŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß", "abcdefghijklmnopqrstuvwxyzšœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß")) !== false) {
				if (!array_key_exists($attributeOption['id'], $foundOptions)) {
					$foundOptions[$attributeOption['id']] = array();
					$foundOptions[$attributeOption['id']]['name'] = $attributeOption['name'];
					$foundOptions[$attributeOption['id']]['categories'] = "-".implode('-', $attributeOption['categories'][0]['category_value'])."-";
				}
			}
		}
	}
}*/


$tpl->setVariable('foundOptions', $foundOptions);

$tpl->setVariable('attributeId', $attributeId);

$Result['pagelayout'] = 'empty_pagelayout.tpl';
$Result['content'] = $tpl->fetch('design:ezcategoryselection/related_options.tpl');
?>

