<?php

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

$param_quizzNodeId = $Params['quizzNodeId'];

$quizzNode = eZFunctionHandler::execute('content', 'node', array('node_id'=>$param_quizzNodeId));
$tpl->setVariable('quizz_node', $quizzNode);

/* Renvoie d'erreurs vers la template pour les afficher */
$etape1_erreurs = false;
if($http->hasSessionVariable('etape1_erreurs')){
    $etape1_erreurs = $http->sessionVariable('etape1_erreurs');
    $tpl->setVariable('erreurs', $etape1_erreurs);
}

/* Effacer la Réponse du Quizz restée dans la session*/
if($http->hasSessionVariable('quizzReponse')){
    $http->removeSessionVariable('quizzReponse');
}
/* Fin: Renvoie d'erreurs */

$Result['content'] = $tpl->fetch('design:quizz/etape1.tpl');
$Result['path'] = array(
    array(
        'url' => '/',
        'url_alias' => '/',
        'text' => 'Accueil'),
    array(
        'url' => false,
        'url_alias' => false,
        'text' => 'Quizz : etape1'));

?>
