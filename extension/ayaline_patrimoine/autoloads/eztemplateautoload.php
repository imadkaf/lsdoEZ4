<?php

// Operator autoloading

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] = array(
	'script'=>'extension/ayaline_patrimoine/autoloads/ezpatrimoineutiloperators.php',
	'class'=>'eZPatrimoineUtils',
	'operator_names' => array (
		'striptags','getcookie','getlist_instantsgagnants'
	)
);

?>
