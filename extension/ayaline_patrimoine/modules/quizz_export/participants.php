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
        $titleRow .= '"' . utf8_decode("ID") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Email") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Nom") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Prenom") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Adresse ligne 1") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Adresse ligne 2") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Code postal") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Ville") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Date et heure de participation") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Participation gagnante") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Quizz ID") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Réponse donnée") . '"' . "\n";
        
        $data .= $titleRow;
        foreach ($list2export as $key => $element) {
            $participation_gagnante = "Oui";
            if($element->participation_gagnante == 0){
                $participation_gagnante = "Non";
            }
            
            $row = "";
            $row .= '"' . utf8_decode( $element->id ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->email ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->nom ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->prenom ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->adresse_ligne1 ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->adresse_ligne2 ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->code_postal ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->ville ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->date_heure_participation ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $participation_gagnante ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->quizz_id ) . '"' . $separateur;
            $row .= '"' . utf8_decode( $element->reponse_donnee) . '"' . "\n";

            $data .= $row;
        }

        @unlink($file);
        eZFile::create($file, false, $data);

        if (!eZFile::download($file)) {
            $Module->redirectTo('/quizz_export/participants/');
        }
    }
}

$Result = array();
$Result['left_menu'] = 'design:parts/quizz_export/left_menu.tpl';
$Result['content'] = $tpl->fetch('design:quizz_export/export_participants.tpl');
$Result['path'] = array(array('url' => false,
        'text' => 'Quizz export'));