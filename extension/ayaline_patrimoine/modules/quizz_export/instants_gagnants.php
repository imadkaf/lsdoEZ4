<?php

require_once( 'kernel/common/template.php' );
$tpl = templateInit();
$http = eZHTTPTool::instance();


$Module = $Params['Module'];

$param_offset = $Params['Offset'];
$param_view = $Params['View'];
$viewParameters = array('offset' => $param_offset, 'view' => $param_view);

$tpl->setVariable('view_parameters', $viewParameters);

if ($http->hasPostVariable('generer_quizz_instantsgagnants')) {
    define("DATEFORMAT", "/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/"); // DATEFORMAT
    $dateDeb = htmlspecialchars($http->postVariable('date_deb'), ENT_COMPAT);
    $dateFin = htmlspecialchars($http->postVariable('date_fin'), ENT_COMPAT);
    $nombre = htmlspecialchars($http->postVariable('nombre'), ENT_COMPAT);
    $generatedDatesIG = false;

    if (is_numeric($nombre) && $nombre > 0 && preg_match(DATEFORMAT, $dateDeb) && preg_match(DATEFORMAT, $dateFin)) {
        $generatedDatesIG = QuizzInstantGagnantManagement::generate($dateDeb, $dateFin, $nombre);
        $tpl->setVariable('generated_dates_ig', $generatedDatesIG);
    }else{
        $erreurs = array();
        $erreurs_description = 'La génération des Instants gagants n\'a pas pu être terminée';
        
        if(!(preg_match(DATEFORMAT, $dateDeb) && preg_match(DATEFORMAT, $dateFin))){
            $erreurs[] = 'Veuillez sélectionner une période.';
        }
        if(!is_numeric($nombre)){
            $erreurs[] = 'Veuillez entrer un nombre valide d\'instants gagnants à générer.';
        }
        
        $tpl->setVariable('erreurs', $erreurs);
        $tpl->setVariable('erreurs_description', $erreurs_description);
    }
    
}

if ($http->hasPostVariable('export_quizz_instantsgagnants')) {
    define("DATEFORMAT", "/^[0-9]{4}" . "-" . "[0-9]{2}" . "-" . "[0-9]{2}$/"); // DATEFORMAT
    $dateDeb = htmlspecialchars($http->postVariable('date_deb'), ENT_COMPAT);
    $dateFin = htmlspecialchars($http->postVariable('date_fin'), ENT_COMPAT);

    if (preg_match(DATEFORMAT, $dateDeb) && preg_match(DATEFORMAT, $dateFin)) {
        $dateDeb .=" 00:00:00";
        $dateFin .=" 23:59:59";
        $list2export = QuizzInstantGagnantManagement::getInstantsGagnantsByDates($dateDeb, $dateFin);

        $dir = eZSys::cacheDirectory() . '/';
        $file = $dir . 'export-instants-gagnants.csv';
        $separateur = ";";
        $data = "";

        $titleRow = "";
        $titleRow .= '"' . utf8_decode("Identifiant") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Date") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Heure") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Instant gagné") . '"' . "\n";

        $data .= $titleRow;
        foreach ($list2export as $key => $element) {
            $igDateHeure = $element->date_heure;
            $igDate = $igDateHeure;
            $igHeur = $igDateHeure;
            $igDateHeure = explode(" ", $igDateHeure);
            if (isset($igDateHeure[0])) {
                $igDate = $igDateHeure[0];
            }
            if (isset($igDateHeure[0])) {
                $igHeur = $igDateHeure[1];
            }




            $row = "";
            $row .= '"' . utf8_decode($element->id) . '"' . $separateur;
            $row .= '"' . utf8_decode($igDate) . '"' . $separateur;
            $row .= '"' . utf8_decode($igHeur) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->gagne) . '"' . "\n";

            $data .= $row;
        }

        @unlink($file);
        eZFile::create($file, false, $data);

        if (!eZFile::download($file)) {
            $Module->redirectTo('/quizz_export/instants-gagnants/');
        }
    }else{
        $erreurs = array();
        $erreurs_description = 'L\'export des Instants gagants n\'a pas pu être terminé';
        $erreurs[] = 'Veuillez sélectionner une période.';
        $tpl->setVariable('erreurs', $erreurs);
        $tpl->setVariable('erreurs_description', $erreurs_description);
    }
}

$Result = array();
$Result['left_menu'] = 'design:parts/quizz_export/left_menu.tpl';
$Result['content'] = $tpl->fetch('design:quizz_export/export_instantsgagnants.tpl');
$Result['path'] = array(
    array('url' => false,
        'text' => 'Quizz export'),
    array('url' => false,
        'text' => 'Instants gagnants')
    );