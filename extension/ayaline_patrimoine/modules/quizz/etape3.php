<?php

$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();
$patrimoine_ini = eZINI::instance('ayaline_patrimoine.ini');

function isMobile() {
//User agent
    $ua = $_SERVER['HTTP_USER_AGENT'];
//test si il s'agit d'un mobile
    return preg_match('/iphone/i', $ua) || preg_match('/android/i', $ua)
            || preg_match('/blackberry/i', $ua);
}

if (isMobile() && $http->hasSessionVariable('quizzNodeId')) {

    $param_quizzNodeId = $http->sessionVariable('quizzNodeId');

    $quizzNode = eZFunctionHandler::execute('content', 'node', array('node_id' => $param_quizzNodeId));
    $tpl->setVariable('quizz_node', $quizzNode);

    $form_values["email"] = htmlspecialchars($http->postVariable('email'), ENT_COMPAT);
    $form_values["nom"] = htmlspecialchars($http->postVariable('nom'), ENT_COMPAT);
    $form_values["prenom"] = htmlspecialchars($http->postVariable('prenom'), ENT_COMPAT);
    $form_values["adresse1"] = htmlspecialchars($http->postVariable('adresse1'), ENT_COMPAT);
    $form_values["adresse2"] = htmlspecialchars($http->postVariable('adresse2'), ENT_COMPAT);
    $form_values["cp"] = htmlspecialchars($http->postVariable('cp'), ENT_COMPAT);
    $form_values["ville"] = htmlspecialchars($http->postVariable('ville'), ENT_COMPAT);
    $form_values["contrat"] = htmlspecialchars($http->postVariable('contrat'), ENT_COMPAT);
    $form_values["recevoir-email"] = htmlspecialchars($http->postVariable('recevoir-email'), ENT_COMPAT);


    define("EMAIL", "/^[[:alnum:]_.-.\+]+" . "@" . "[[:alnum:]_.-]+\." . "([[:alnum:]]{2,3})$/"); // EMAIL
    $erreurs = array();
    if (!QuizzParticipationManagement::canParticipate($form_values["email"], $quizzNode->NodeID)) {
        $erreurs['participation'] = "Vous avez déjà participé à ce Quizz.";
    } else {
        if (strlen($form_values['email']) == 0) {
            $erreurs['email'] = "Veuillez renseigner votre email.";
        } elseif (!preg_match(EMAIL, $form_values['email'])) {
            $erreurs['email'] = "Veuillez renseigner un email valide.";
        }
        if (strlen($form_values["nom"]) == 0) {
            $erreurs['Nom'] = "Veuillez renseigner votre nom.";
        }
        if (strlen($form_values["prenom"]) == 0) {
            $erreurs['Prenom'] = "Veuillez renseigner votre prénom.";
        }
        if (strlen($form_values["cp"]) != 0 && (strlen($form_values["cp"]) != 5 || !is_numeric($form_values["cp"]))) {
            $erreurs['cp'] = "Veuillez renseigner un code postal valide (5 chiffres max)";
        }
        if ($form_values["contrat"] == 0) {
            $erreurs['contrat'] = "Veuillez accepter les conditions générales du règlement.";
        }
    }

    /* Déb : Validation des données du formulaire */
    if (count($erreurs) != 0) {
        /* Déb : Renvoi d'erreurs et Redirection vers etape2 */
        $http->setSessionVariable('etape2_erreurs', $erreurs);

        $http->setSessionVariable('quizz_form_values', serialize($form_values));
        $Module->redirectTo('/quizz/etape2/');
        /* Fin : Renvoi d'erreurs et Redirection vers etape2 */
    } else {

        /* Enregistrer dans les cookies */

        setcookie("quizz_form_values", serialize($form_values), time() + (3600 * 24 * 31 * 3), '/');
        $tpl->setVariable('quizz_form_values', unserialize($_COOKIE['quizz_form_values']));
        $quizzReponse = $http->sessionVariable('quizzReponse');
        $http->removeSessionVariable('quizzReponse');

        /* Vérifier la Réponse (Vrai , Faux , Gagnant) */
        $data_map = $quizzNode->datamap();
        $reponseCorrect = (int) ($data_map['bonne_reponse']->DataText) + 1;
        $participationGagnante = 0;
        $isInstantGagnant = QuizzInstantGagnantManagement::isInstantGagnant();
        $resultatQuizz = 0;
        if ($reponseCorrect == $quizzReponse && $isInstantGagnant) {
            $participationGagnante = 1;
            $resultatQuizz = 1;
        } elseif ($reponseCorrect == $quizzReponse && !$isInstantGagnant) {
            $resultatQuizz = 2;
        }

        /* Enregistrer La participation */
        $row = array(
            'id' => null,
            'email' => $form_values['email'],
            'nom' => $form_values['nom'],
            'prenom' => $form_values['prenom'],
            'adresse_ligne1' => $form_values['adresse1'],
            'adresse_ligne2' => $form_values['adresse2'],
            'code_postal' => $form_values['cp'],
            'ville' => $form_values['ville'],
            'date_heure_participation' => date('Y-m-d H:i:s', time()),
            'participation_gagnante' => $participationGagnante,
            'quizz_id' => $quizzNode->NodeID,
            'reponse_donnee' => $quizzReponse);

        $participationID = QuizzParticipationManagement::save($row['email'], $row['nom'], $row['prenom'], $row['adresse_ligne1'], $row['adresse_ligne2'], $row['code_postal'], $row['ville'], $row['date_heure_participation'], $row['participation_gagnante'], $row['quizz_id'], $row['reponse_donnee']);

        if ($resultatQuizz == 1) {
            $objInstantGagnant = QuizzInstantGagnantManagement::loadById($isInstantGagnant);
            QuizzInstantGagnantManagement::save($objInstantGagnant->date_heure, $participationID, $objInstantGagnant->id);
        }

        switch ($resultatQuizz) {
            case "0"://Mauvaise Réponse
                $Result['content'] = $tpl->fetch('design:quizz/etape3_mauvaise_reponse.tpl');
                break;
            case "1"://Bonne Réponse Instant Gagnant :Gagné
                $Result['content'] = $tpl->fetch('design:quizz/etape3_instant_gagnant.tpl');
                $subject = 'Vous avez gagn� l\'instant gagnant';
                $message = '<html>
                				<head>
                					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       								<title>Instant gagnant</title>
      							</head>
      							<body>
                					F�licitation,<br /><br />Vous avez gagn� l\'instant gagnant lors de votre participation le '.$row['date_heure_participation'].'.<br />Venez vite chercher votre lot � l\'office de tourisme<br /><a href="http://lessables.mobi/Fiche/Detail/2250/lessables.mobi~Infos-pratiques~Offices-de-Tourisme/Office-de-Tourisme-des-Sables-d-Olonne">Nous contacter</a>
                				</body>
                			</html>';
                $headers = "MIME-Version: 1.0\n" ;
        		$headers .= "Content-Type: text/html; charset=\"iso-8859-1\"\n";
        		if($patrimoine_ini->hasVariable('Quizz', 'emailExp'))
        			$headers .= "From: l'office de tourisme <".$patrimoine_ini->variable('Quizz', 'emailExp').">\n";
                mail($row['email'], $subject, $message, $headers);
                break;
            case "2"://Bonne Réponse Instant Gagnant :pérdu
                $Result['content'] = $tpl->fetch('design:quizz/etape3_bonne_reponse.tpl');
                break;
        }
        $http->removeSessionVariable('quizzNodeId');

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

        $Result['node_id'] = $quizzNode->NodeID;
        $Result['path'] = $resultPath;
    }
}
?>
