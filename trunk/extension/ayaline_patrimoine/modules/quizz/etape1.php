<?php

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

$param_quizzNodeId = false;
if(isset($Params['quizzNodeId']) && is_numeric($Params['quizzNodeId'])){
    $param_quizzNodeId = $Params['quizzNodeId'];
    $http->setSessionVariable('quizzNodeId', $param_quizzNodeId);
}elseif($http->hasSessionVariable('quizzNodeId')){
    $param_quizzNodeId = $http->sessionVariable('quizzNodeId');
}

$quizzNode = eZFunctionHandler::execute('content', 'node', array('node_id'=>$param_quizzNodeId));
$tpl->setVariable('quizz_node', $quizzNode);

//if($http->hasSessionVariable('quizzNodeId') ){
//    $http->removeSessionVariable('quizzNodeId');
//}


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
$Result['node_id'] = $quizzNode->NodeID;
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
