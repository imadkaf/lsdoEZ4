<?php

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

$param_quizzNodeId = $Params['quizzNodeId'];
$quizzNode = eZFunctionHandler::execute('content', 'node', array('node_id' => $param_quizzNodeId));
$tpl->setVariable('quizz_node', $quizzNode);

$quizzReponse = false;
if ($http->hasPostVariable('reponse')) {
    $quizzReponse = htmlspecialchars($http->postVariable('reponse'), ENT_COMPAT);
}elseif ($http->hasSessionVariable('quizzReponse')) {
    $quizzReponse = $http->sessionVariable('quizzReponse');
} 
if($quizzReponse){
    $http->setSessionVariable("quizzReponse", $quizzReponse);
}

$etape1_erreurs = array();
if($quizzReponse == false || preg_match("/^[ ]+$/", $quizzReponse)){
    $etape1_erreurs['Reponse'] = 'Veuillez choisir votre réponse';
}

if(count($etape1_erreurs) != 0){
    $http->setSessionVariable('etape1_erreurs', $etape1_erreurs);
    $Module->redirectTo('/quizz/etape1/' . $quizzNode->NodeID);
}





if ($http->hasSessionVariable('etape2_erreurs')) {
    $erreurs = $http->sessionVariable('etape2_erreurs');
    $tpl->setVariable('erreurs', $erreurs);
    $http->removeSessionVariable('etape2_erreurs');
}
$quizz_form_values = false;

if (isset($_COOKIE['quizz_form_values'])) {
    $quizz_form_values = unserialize($_COOKIE['quizz_form_values']);
}
if ($http->hasSessionVariable("quizz_form_values")) {
    $quizz_form_values = unserialize($http->sessionVariable("quizz_form_values"));
    $http->removeSessionVariable('quizz_form_values');
}
if($quizz_form_values != false){
    $tpl->setVariable('quizz_form_values', $quizz_form_values);
}


$Result['content'] = $tpl->fetch('design:quizz/etape2.tpl');
$Result['path'] = array(
    array(
        'url' => '/',
        'url_alias' => '/',
        'text' => 'Accueil'),
    array(
        'url' => false,
        'url_alias' => false,
        'text' => 'Quizz : etape2'));
?>
