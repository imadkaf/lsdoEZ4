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

function processSendMail($mail) {
	// Attention à  bien s'appuyer sur la conf
	$ini = ezIni::instance();
	$transportType = ezIni::instance()->variable( 'MailSettings', 'Transport' );
	if ( $transportType == 'sendmail' ) {
		$transport = new ezcMailMtaTransport();
	}
	else {
		$transportServer   = $ini->variable( 'MailSettings', 'TransportServer' );
		$transportPort     = $ini->variable( 'MailSettings', 'TransportPort' );
		$transportUser     = $ini->variable( 'MailSettings', 'TransportUser' );
		$transportPassword = $ini->variable( 'MailSettings', 'TransportPassword' );
		$transport = new ezcMailSmtpTransport( $transportServer, $transportUser, $transportPassword, $transportPort);
	}
	$transport->send( $mail );
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

                // Envoi du mail de confirmation à l'internaute (avec l'OT en copie visible)
        		if($patrimoine_ini->hasVariable('Quizz', 'emailExp')){
        			$emailFrom	= new ezcMailAddress($patrimoine_ini->variable('Quizz', 'emailExp'), "Office de Tourisme des Sables d'Olonne");
        			$emailCc	= new ezcMailAddress($patrimoine_ini->variable('Quizz', 'emailCopieVisible'), "Office de Tourisme des Sables d'Olonne");
        		}
        		$receiver 		= $row['email'];
        		$receiverName 	= $row['prenom']." ".$row['nom'];
                $subject 		= '[D\'Code Les Sables] Vous avez gagné !';
                
				// Date et heure de la participation
				setlocale(LC_ALL, "fr_FR");
				$tabDateHeureIg = explode(' ', $row['date_heure_participation']);
				$tabDateIg 		= explode('-', $tabDateHeureIg[0]);
				$tabHeureIg 	= explode(':', $tabDateHeureIg[1]);
				$timestampIG 	= mktime ($tabHeureIg[0], $tabHeureIg[1], $tabHeureIg[2], $tabDateIg[1], $tabDateIg[2], $tabDateIg[0] );
				$affichageDateHeureIg = utf8_encode(strftime ('%A %d %B %G', $timestampIG)) . " à " . date('H:i', $timestampIG);
				
				// Corps du mail
				$message = '<html>
                				<head>
                					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       								<title>[D\'Code Les Sables] Vous avez gagné !</title>
      							</head>
      							<body>
                					<p>Bonjour ' . $row['prenom']." ".$row['nom'] . ',</p>
									<p>Félicitations, vous avez gagné l\'instant gagnant lors de votre participation du '. $affichageDateHeureIg .' au quizz de D\'Code Les Sables.</p>
									<p>Venez vite chercher votre lot à l\'Office de Tourisme en vous munissant du présent mail et de la référence suivante : P'. $participationID . '-IG'. $objInstantGagnant->id . '-Q'. $param_quizzNodeId .'-R'. $quizzReponse . '/'. $row['email'] .'</p>
									<p>A bientôt,</p>
									<p>Office de tourisme des Sables d\'Olonne<br/>
									1, promenade Joffre<br/>
									85100 Les Sables d\'Olonne.<br/>
									Tél : 02.51.96.85.85<br/>
									Fax : 02.51.96.85.71<br/>
									E-mail : info@lessablesdolonne-tourisme.com<br/>
									<a href="http://www.lessablesdolonne-tourisme.com">www.lessablesdolonne-tourisme.com</a></p>
									<p>Horaires d\'ouverture :<br/>
									Octobre à mars :<br/>
									Lundi et dimanche 14h-17h30.<br/>
									Du mardi au samedi 10h-12h30 et 14h-17h30.<br/>
									Avril à juin, et septembre :<br/>
									Tous les jours 10h-12h30 et 14h-18h.<br/>
									Juillet-Août :<br/>
									Tous les jours 9h-19h.</p>
									<p>&nbsp;</p>
									<p>-----------</p>
									<p>Ce mail vous a été envoyé automatiquement.</p>
									<p>&nbsp;</p>
                				</body>
                			</html>';

                // Objet mail : initialisation
                $mail = new ezcMailComposer();
                $mail->from = $emailFrom;
                $mail->subject = $subject;
                $mail->charset = ezIni::instance()->variable( 'MailSettings', 'OutputCharset' );
                $mail->subjectCharset = $mail->charset;
                $mail->htmlText = $message;

                // Envoi au participant
                $mail->addTo( new ezcMailAddress( $receiver, $receiverName ) );
                $mail->addCc( $emailCc );

                // Build du message
                $mail->build();

                // Envoi du mail
                processSendMail($mail);

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
