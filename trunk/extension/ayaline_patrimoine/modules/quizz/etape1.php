<?php

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

function isMobile() {
//User agent
    $ua = $_SERVER['HTTP_USER_AGENT'];
//test si il s'agit d'un mobile
    return preg_match('/iphone/i', $ua) || preg_match('/android/i', $ua)
            || preg_match('/blackberry/i', $ua);
}

if (isMobile() && (isset($Params['quizzNodeId']) || $http->hasSessionVariable('quizzNodeId'))) {
    $param_quizzNodeId = false;
    if (is_numeric($Params['quizzNodeId'])) {
        $param_quizzNodeId = $Params['quizzNodeId'];
        $http->setSessionVariable('quizzNodeId', $param_quizzNodeId);
    } elseif ($http->hasSessionVariable('quizzNodeId')) {
        $param_quizzNodeId = $http->sessionVariable('quizzNodeId');
    }

    $quizzNode = eZFunctionHandler::execute('content', 'node', array('node_id' => $param_quizzNodeId));

    if ($quizzNode->classIdentifier() == 'smp_quizz') {
        $tpl->setVariable('quizz_node', $quizzNode);


        /* Renvoie d'erreurs vers la template pour les afficher */
        $etape1_erreurs = false;
        if ($http->hasSessionVariable('etape1_erreurs')) {
            $etape1_erreurs = $http->sessionVariable('etape1_erreurs');
            $tpl->setVariable('erreurs', $etape1_erreurs);
        }

        /* Effacer la Réponse du Quizz restée dans la session */
        if ($http->hasSessionVariable('quizzReponse')) {
            $http->removeSessionVariable('quizzReponse');
        }
        /* Fin: Renvoie d'erreurs */

        /* Fil d'ariane */
        $path_array = $quizzNode->pathArray();
        $resultPath = array();
        foreach ($path_array as $path_item) {
            $path_item_node = eZFunctionHandler::execute('content', 'node', array('node_id' => $path_item));
            if ($path_item == $param_quizzNodeId) {
                $resultPath[] = array(
                    'url' => false,
                    'url_alias' => false,
                    'node_id' => $path_item,
                    'text' => 'Quizz');
            } elseif ($path_item != 1 && $path_item != 2) {
                $resultPath[] = array(
                    'url' => $path_item_node->url(),
                    'url_alias' => $path_item_node->urlAlias(),
                    'node_id' => $path_item,
                    'text' => $path_item_node->attribute('name'));
            }
        }

        $Result['content'] = $tpl->fetch('design:quizz/etape1.tpl');
        $Result['node_id'] = $quizzNode->NodeID;
        $Result['path'] = $resultPath;
    }
}
?>
