<?php

header('Content-Type: text/html; charset=utf-8');
$ezAyaCartoIni = eZINI::instance('ez_aya_carto.ini');
$SITCategoriesTitle = $ezAyaCartoIni->variable('SITCategoriesSettings', 'SITCategoriesTitle');
$urlRootSit = $ezAyaCartoIni->variable('GlobalCartoSitParameters', 'RootCartoSitUrl');
$urlParams = $ezAyaCartoIni->variable('GlobalCartoSitParameters', 'URLParams');
$urlCache = $ezAyaCartoIni->variable('GlobalCartoSitParameters', 'URLCache');
$dureeCache = $ezAyaCartoIni->variable('GlobalCartoSitParameters', 'DureeCache');
$critereGeolocalisation = $ezAyaCartoIni->variable('GlobalCartoSitParameters', 'CritereGeolocalisation');

$idCritGeoloc = $critereGeolocalisation['idCrit'];
$idModaliteLat = $critereGeolocalisation['idModaliteLat'];
$idModaliteLng = $critereGeolocalisation['idModaliteLng'];

if (isset($_GET['mc']) && $_GET['mc'] != '') {
    $motCle = $_GET['mc'];

    echo "<ul>";
    foreach ($SITCategoriesTitle as $categ_id => $categ_name) {

        if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/" . $urlCache . "/" . "cachexmlcateg" . $categ_id . ".xml")) {
            $xmlResultat = simplexml_load_file($_SERVER['DOCUMENT_ROOT'] . "/" . $urlCache . "/" . "cachexmlcateg" . $categ_id . ".xml");

            if ($xmlResultat) {
                foreach ($xmlResultat->details->detail as $detail) {
                    $testGeoLat = $detail->xpath("./criteres/critere[@id=$idCritGeoloc]/modalites/modalite[@id=$idModaliteLat]/valModalite");
                    $testGeoLng = $detail->xpath("./criteres/critere[@id=$idCritGeoloc]/modalites/modalite[@id=$idModaliteLng]/valModalite");
                    if (( count($testGeoLat) > 0 && count($testGeoLng) > 0 && is_numeric((string) $testGeoLat[0]) && is_numeric((string) $testGeoLng[0]))) {
                        $idProduit = (string) $detail[@id];
                        $intitule = $detail->intitule;
                        $intitule = (string) $intitule[0];
                        $intitule_js = implode("\\'", explode("'", $intitule));
                        if (preg_match("/^$motCle/i", $intitule)) {
                            $valOD = "origin";
                            if(isset($_GET["od"])){
                                $valOD = $_GET["od"];
                            }
                            echo "<li><a id=\"idac_$categ_id-$idProduit\" href=\"Javascript:rechercheItinFiche($categ_id,$idProduit,'$valOD','idac_$categ_id-$idProduit')\">$intitule</a></li>";
                        }
                    }
                }
            }
        }
    }
    echo "</ul>";
}
?>
