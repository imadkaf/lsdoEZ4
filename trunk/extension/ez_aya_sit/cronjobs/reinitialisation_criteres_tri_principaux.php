<?php

$cli->setUseStyles(true);

if (!$isQuiet) {
	$cli->output($cli->stylize('cyan', "\tDébut réinitialisation attribut 'Critères de tri principaux'."));
}

$fetchParameters = array(
	'parent_node_id' => 2,
	'depth' => 10,
	'class_filter_type' => 'include',
	'class_filter_array' => array('sit_liste', 'sit_mise_en_avant')
);

$nodeObjects = eZFunctionHandler::execute(
	'content',
	'list',
	$fetchParameters
);

foreach ($nodeObjects as $nodeObject) {
	$nodeObject = $nodeObject->object();
	$nodeObjectDataMap = $nodeObject->dataMap();
	
	$critereTriPrincipal = $nodeObjectDataMap['criteres_tri_principaux']->value();
	if (!preg_match("/^[ad]/", $critereTriPrincipal[0])) {
		$critereTriPrincipal[0] = "d".$critereTriPrincipal[0];
		$attributeList = array(
			'criteres_tri_principaux' => $critereTriPrincipal
		);
	}
	
	$res = eZContentFunctions::updateAndPublishObject($nodeObject, array('attributes' => $attributeList));
	
	if ($res) {
		$cli->output($cli->stylize('green', "\tOK : ".$nodeObject->ID."."));
	} else {
		$cli->output($cli->stylize('red', "\tKO : ".$nodeObject->ID."."));
	}
}

if (!$isQuiet) {
	$cli->output($cli->stylize('green', "\tFait."));
}

?>
