<?php

$Module = array(
	'name' => 'Fiche',
	'variable_params' => true
);

$ViewList['Detail'] = array(
	'script' => 'sit_fiche_detail.php',
	'params' => array('idFiche', 'cheminCategorie', 'identifierFiche'),
	'ui_context' => 'default'
);

?>
