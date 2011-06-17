<?php

$Module = array(
	'name' => 'Fiche',
	'variable_params' => true
);

$ViewList['Detail'] = array(
	'script' => 'fiche_detail.php',
	'params' => array('idFiche', 'identifierFiche', 'cheminCategorie'),
	'ui_context' => 'default'
);

?>
