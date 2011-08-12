<?php

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


$foundOptions = array();

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
}


$tpl->setVariable('foundOptions', $foundOptions);

$tpl->setVariable('attributeId', $attributeId);

$Result['pagelayout'] = 'empty_pagelayout.tpl';
$Result['content'] = $tpl->fetch('design:ezcategoryselection/related_options.tpl');
?>

