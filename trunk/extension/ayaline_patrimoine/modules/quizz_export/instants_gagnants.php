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

    if (is_numeric($nombre) && $nombre > 0 && preg_match(DATEFORMAT, $dateDeb) && preg_match(DATEFORMAT, $dateFin)) {
        QuizzInstantGagnantManagement::generate($dateDeb, $dateFin, $nombre);
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
        $titleRow .= '"' . utf8_decode("ID") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Date et heure") . '"' . $separateur;
        $titleRow .= '"' . utf8_decode("Gagné") . '"' . "\n";
        
        $data .= $titleRow;
        foreach ($list2export as $key => $element) {
            
            $row = "";
            $row .= '"' . utf8_decode($element->id) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->date_heure) . '"' . $separateur;
            $row .= '"' . utf8_decode($element->gagne) . '"' . "\n";

            $data .= $row;
        }

        @unlink($file);
        eZFile::create($file, false, $data);

        if (!eZFile::download($file)) {
            $Module->redirectTo('/quizz_export/instants-gagnants/');
        }
    }
}

$Result = array();
$Result['left_menu'] = 'design:parts/quizz_export/left_menu.tpl';
$Result['content'] = $tpl->fetch('design:quizz_export/export_instantsgagnants.tpl');
$Result['path'] = array(array('url' => false,
        'text' => 'Quizz export'));