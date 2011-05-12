<?php

/**
 * Mise en session de la variable de la saison sélectionnée
 *
 * $LastChangedDate: 2011-05-04 11:11:11 +0200 (mer., 04 mai 2011) $
 * $Revision: 1 $
 * $Author: gseguin $
 */

$Module = array( 'name' => 'themes' );

$ViewList = array();
$ViewList['edit'] = array( 
						    'functions' => array( 'edit' ),
						    'script' => 'edit.php',
						    'ui_context' => 'edit',
							'params' => array(  )
);
$FunctionList = array();
$FunctionList['edit'] = array();
?>