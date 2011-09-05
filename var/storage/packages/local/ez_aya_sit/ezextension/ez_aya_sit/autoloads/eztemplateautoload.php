<?php

// Operator autoloading

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] = array(
	'script' => 'extension/ez_aya_sit/autoloads/ez_sit_operators.php',
	'class' => 'eZSitOperators',
	'operator_names' => array(
		'sit_liste',
		'sit_recherche'
	)
);

$eZTemplateOperatorArray[] = array(
	'script'=>'extension/ez_aya_sit/autoloads/ezcategoryselectionutiloperators.php',
	'class'=>'eZCategorySelectionUtil',
	'operator_names' => array (
		'option_filter',
		'category_options',
		'object_category_options',
		'object_category_values',
		'has_related_category_options',
		'category_option_simple_array',
		'category_option_array',
		'thresholds',
		'generate_category_string',
		'is_empty_category',
		'category_option_values',
		'inarray'
	)
);

?>
