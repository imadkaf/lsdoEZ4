<?php

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

if (isMobile() && $http->hasSessionVariable('quizzNodeId')) {
    $param_quizzNodeId = $http->sessionVariable('quizzNodeId');

    $quizzNode = eZFunctionHandler::execute('content', 'node', array('node_id' => $param_quizzNodeId));
    $tpl->setVariable('quizz_node', $quizzNode);



    $quizzReponse = false;
    if ($http->hasPostVariable('reponse')) {
        $quizzReponse = htmlspecialchars($http->postVariable('reponse'), ENT_COMPAT);
    } elseif ($http->hasSessionVariable('quizzReponse')) {
        $quizzReponse = $http->sessionVariable('quizzReponse');
    }
    if ($quizzReponse) {
        $http->setSessionVariable("quizzReponse", $quizzReponse);
    }

    $etape1_erreurs = array();
    if ($quizzReponse == false || preg_match("/^[ ]+$/", $quizzReponse)) {
        $etape1_erreurs['Reponse'] = 'Veuillez choisir votre réponse';
    }

    if (count($etape1_erreurs) != 0) {
        $http->setSessionVariable('etape1_erreurs', $etape1_erreurs);
        $Module->redirectTo('/quizz/etape1/');
    } else {
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
        if ($quizz_form_values != false) {
            $tpl->setVariable('quizz_form_values', $quizz_form_values);
        }
        if ($http->hasSessionVariable('etape1_erreurs')) {
            $http->removeSessionVariable('etape1_erreurs');
        }

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

        $Result['content'] = $tpl->fetch('design:quizz/etape2.tpl');
        $Result['node_id'] = $quizzNode->NodeID;
        $Result['path'] = $resultPath;
    }
}
?>
