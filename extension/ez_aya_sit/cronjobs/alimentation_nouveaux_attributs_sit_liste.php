<?php

$cli->setUseStyles(true);

if (!$isQuiet) {
	$cli->output($cli->stylize('cyan', "\tDébut alimentation nouveaux attributs SIT liste."));
}

$fetchParameters = array(
	'parent_node_id' => 2,
	'depth' => 10,
	'class_filter_type' => 'include',
	'class_filter_array' => array('affichage_liste_sit')
);

$nodeObjects = eZFunctionHandler::execute(
	'content',
	'list',
	$fetchParameters
);

foreach ($nodeObjects as $nodeObject) {
	$nodeObjectDataMap = $nodeObject->dataMap();
	$sitListeReliee = $nodeObjectDataMap['liaison_liste']->value();

	if ($sitListeReliee) {	
		$sitListeRelieeDataMap = $sitListeReliee->dataMap();
		
		$originalThumbNail = $nodeObjectDataMap['thumbnail']->value()->attribute('original');

		$attributeList = array(
			'titre_liste' => $nodeObjectDataMap['title']->value(),
			'thumbnail' => $originalThumbNail['url'],
			'short_description' => $nodeObjectDataMap['short_description']->value(),
			'googlemaps' => $nodeObjectDataMap['googlemaps']->value(),
			'topics' => $nodeObjectDataMap['topics']->toString()
		);

		$res = eZContentFunctions::updateAndPublishObject($sitListeReliee, array('attributes' => $attributeList));
		
		if ($res) {
			$cli->output($cli->stylize('green', "\tOK : ".$nodeObject->object()->ID."."));
		} else {
			$cli->output($cli->stylize('red', "\tKO : ".$nodeObject->object()->ID."."));
		}
	}
}

if (!$isQuiet) {
	$cli->output($cli->stylize('green', "\tFait."));
}

?>
