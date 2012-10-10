<?php

require_once( 'kernel/common/template.php' );
$tpl = templateInit();
$http = eZHTTPTool::instance();


$Module = $Params['Module'];

if ($http->hasPostVariable('export_quizz_participants')) {
    define("DATEFORMAT", "/^[0-9]{4}" . "-" . "[0-9]{2}" . "-" . "[0-9]{2}$/"); // DATEFORMAT
    $dateDeb = htmlspecialchars($http->postVariable('date_deb'), ENT_COMPAT);
    $dateFin = htmlspecialchars($http->postVariable('date_fin'), ENT_COMPAT);

    if (preg_match(DATEFORMAT, $dateDeb) && preg_match(DATEFORMAT, $dateFin)) {
        $dateDeb .=" 00:00:00";
        $dateFin .=" 23:59:59";
        $list2export = QuizzParticipationManagement::getParticipationsByDates($dateDeb, $dateFin);

        $dir = eZSys::cacheDirectory() . '/';
        $file = $dir . 'export-participants.csv';
        $separateur = ";";
        $data = "";

        $titleRow = "";
        $titleRow .= '"' . utf8_decode("Identifiant") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Email") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Nom") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Prénom") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Adresse ligne 1") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Adresse ligne 2") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Code postal") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Ville") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Date et heure de participation") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Intitulé du quiz") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Réponse donnée") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Participation gagnante") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Instant gagnant") . '"' . "\n";

        $data .= $titleRow;
        foreach ($list2export as $key => $element) {
            $participation_gagnante = "Oui";
            if ($element->participation_gagnante == 0) {
                $participation_gagnante = "Non";
            }
            $quizz_name = '';
            $quizz_node = eZFunctionHandler::execute('content', 'node', array('node_id'=> $element->quizz_id));
            
            if (is_object($quizz_node)) {
                $quizz_name = $quizz_node->attribute('name');
            }
            
            $instantGagnant = QuizzInstantGagnantManagement::loadByParticipationId($element->id);
            
            $instantGagnantDateHeur = 'Non Gagnant';
            if(is_object($instantGagnant)){
                $instantGagnantDateHeur = $instantGagnant->date_heure;
            }
            
            $row = "";
            $row .= '"' . utf8_decode($element->id) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->email) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->nom) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->prenom) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->adresse_ligne1) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->adresse_ligne2) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->code_postal) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->ville) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->date_heure_participation) . '"' . $separateur;
            $row .= '"' . utf8_decode($quizz_name) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->reponse_donnee) . '"' . $separateur;
            $row .= '"' . utf8_decode($participation_gagnante) . '"' . $separateur;
            $row .= '"' . utf8_decode($instantGagnantDateHeur) . '"' . "\n";

            $data .= $row;
        }

        @unlink($file);
        eZFile::create($file, false, $data);

        if (!eZFile::download($file)) {
            $Module->redirectTo('/quizz_export/participants/');
        }
    }else{
        $erreurs = array();
        $erreurs_description = 'L\'export des Participants n\'a pas pu être terminé';
        $erreurs[] = 'Veuillez sélectionner une période.';
        $tpl->setVariable('erreurs', $erreurs);
        $tpl->setVariable('erreurs_description', $erreurs_description);
    }
}

$Result = array();
$Result['left_menu'] = 'design:parts/quizz_export/left_menu.tpl';
$Result['content'] = $tpl->fetch('design:quizz_export/export_participants.tpl');
$Result['path'] = array(
    array('url' => false,
        'text' => 'Quizz'),
    array('url' => false,
        'text' => 'Participants')
    );