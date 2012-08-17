<?php

$Module = array('name' => 'quizz','variable_params' => true );

$ViewList = array();
$ViewList['etape1'] = array(
    'script' => 'etape1.php', 
    'params' => array('quizzNodeId'));
$ViewList['etape2'] = array(
    'script' => 'etape2.php',
    'params' => array('quizzNodeId'));
$ViewList['etape3'] = array(
    'script' => 'etape3.php',
    'params' => array('quizzNodeId'));
?>
