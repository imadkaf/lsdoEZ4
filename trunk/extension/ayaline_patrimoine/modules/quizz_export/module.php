<?php

$Module = array('name' => 'quizz_export',
    'variable_params' => true);

$ViewList = array();
$ViewList['participants'] = array(
    'script' => 'participants.php',
    'functions' => array('administration'),
    'params' => array(),
    'unordered_params' => array('offset' => 'Offset', 'view' => 'View'),
    'default_navigation_part' => 'quizzexportnavigationpart');

$ViewList['instants_gagnants'] = array(
    'script' => 'instants_gagnants.php',
    'functions' => array('administration'),
    'params' => array(),
    'unordered_params' => array('offset' => 'Offset', 'view' => 'View'),
    'default_navigation_part' => 'quizzexportnavigationpart');


$FunctionList['administration'] = array();
$FunctionList['filling'] = array();