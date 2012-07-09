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

function setFichierXMLCache($contenuXML, $cheminRepCahce, $nomFichier, $dureeCache) {
    try {
        $cheminRepCahce = $_SERVER['DOCUMENT_ROOT'] . "/" . $cheminRepCahce;
        $cheminFichierCache = $cheminRepCahce . "/" . $nomFichier . ".xml";
        if (!file_exists($cheminRepCahce)) {
            mkdir($cheminRepCahce, 0777, true);
        }
        if (!file_exists($cheminFichierCache)) {
            file_put_contents($cheminFichierCache, $contenuXML);
        } elseif ((filemtime($cheminFichierCache) + $dureeCache) < mktime()) {
            file_put_contents($cheminFichierCache, $contenuXML);
        }
        return true;
    } catch (Exception $e) {
        return false;
    }
}

function fichierXMLCacheExpire($cheminRepCahce, $nomFichier, $dureeCache) {
    try {
        $cheminRepCahce = $_SERVER['DOCUMENT_ROOT'] . "/" . $cheminRepCahce;
        $cheminFichierCache = $cheminRepCahce . "/" . $nomFichier . ".xml";
        if (!file_exists($cheminRepCahce)) {
            return true; //cache expiré
        }
        if (!file_exists($cheminFichierCache)) {
            return true; //cache expiré
        } elseif ((filemtime($cheminFichierCache) + $dureeCache) < time()) {
            return true; //cache expiré
        }
        return false; //cache non expiré
    } catch (Exception $e) {
        return true; //cache expiré
    }
}
/* fonction pour tester sur les dates d'ouvertures*/
function dateOuvJ($datesOuvertures){
    $dateDuJour=date("Y-m-d", time());
    $result=false;
    foreach($datesOuvertures as $dateOuvert){
        $dateOuvertDeb=explode("-",$dateOuvert['dateDebut']);
        $dateOuvertFin=explode("-",$dateOuvert['dateFin']);
        
        $dateOuvertDebTStamp=mktime(0,0,0,$dateOuvertDeb[1],$dateOuvertDeb[2],$dateOuvertDeb[0]);
        $dateOuvertFinTStamp=mktime(0,0,0,$dateOuvertFin[1],$dateOuvertFin[2],$dateOuvertFin[0]);
        
        if(time() >= $dateOuvertDebTStamp && time() <= $dateOuvertFinTStamp ){
            $result=true;
            break;
        }
    }
    
    return $result;
}
function dateOuvS($datesOuvertures){
    $anneeC = (int)date("Y", time());
    $moisC = (int)date("m", time());
    $jourC = (int)date("d", time());
    $numJrSem = (int)date("w", time());
    $dateDebSemaineStamp = mktime(0,0,0,$moisC,($jourC - $numJrSem + 1),$anneeC);
    $dateFinSemaineStamp = mktime(0,0,0,$moisC,($jourC - $numJrSem + 8),$anneeC);
    
    $dateDebSemaine = date("Y-m-d", $dateDebSemaineStamp);
    $dateFinSemaine = date("Y-m-d", $dateFinSemaineStamp);
    
    $result=false;
    foreach($datesOuvertures as $dateOuvert){
        $dateOuvertDeb=explode("-",$dateOuvert['dateDebut']);
        $dateOuvertFin=explode("-",$dateOuvert['dateFin']);
        
        $dateOuvertDebTStamp=mktime(0,0,0,$dateOuvertDeb[1],$dateOuvertDeb[2],$dateOuvertDeb[0]);
        $dateOuvertFinTStamp=mktime(0,0,0,$dateOuvertFin[1],$dateOuvertFin[2],$dateOuvertFin[0]);
        
        if( !($dateDebSemaineStamp > $dateOuvertFinTStamp or $dateFinSemaineStamp < $dateOuvertDebTStamp ) ){
            $result=true;
            break;
        }
    }
    
    return $result;
}
function dateOuvDA($datesOuvertures, $dateDU, $dateAU){
    $dateDUArr=explode("-",$dateDU);
    $dateAUArr=explode("-",$dateAU);
    $dateDUStamp = mktime(0,0,0,$dateDUArr[1],$dateDUArr[2],$dateDUArr[0]);
    $dateAUStamp = mktime(0,0,0,$dateAUArr[1],$dateAUArr[2],$dateAUArr[0]);
    
    $result=false;
    foreach($datesOuvertures as $dateOuvert){
        $dateOuvertDeb=explode("-",$dateOuvert['dateDebut']);
        $dateOuvertFin=explode("-",$dateOuvert['dateFin']);
        
        $dateOuvertDebTStamp=mktime(0,0,0,$dateOuvertDeb[1],$dateOuvertDeb[2],$dateOuvertDeb[0]);
        $dateOuvertFinTStamp=mktime(0,0,0,$dateOuvertFin[1],$dateOuvertFin[2],$dateOuvertFin[0]);
        
        if( !($dateDUStamp > $dateOuvertFinTStamp or $dateAUStamp < $dateOuvertDebTStamp ) ){
            $result=true;
            break;
        }
    }
    
    return $result;
}

if (isset($_GET["idc"])) {
    $typeAffichage=1;
    if (isset($_GET["ta"]) && $_GET["ta"] == '2'){
        $typeAffichage=2;
    }
    $categ_id = explode("_", $_GET["idc"]);
    $categ_id = $categ_id[1];
    $categTitle = $SITCategoriesTitle[$categ_id];
    $categTitle = implode("\\'", explode("'", $categTitle));
    $xmlResultat = false;

    if (fichierXMLCacheExpire($urlCache, "cachexmlcateg" . $categ_id, $dureeCache)) {
        $contenuXML = simplexml_load_file($urlRootSit . "Recherche" . "&idc=" . $categ_id . $urlParams);
        setFichierXMLCache($contenuXML->asXML(), $urlCache, "cachexmlcateg" . $categ_id, $dureeCache);
        $xmlResultat = simplexml_load_file($_SERVER['DOCUMENT_ROOT'] . "/" . $urlCache . "/" . "cachexmlcateg" . $categ_id . ".xml");
    } else {
        $xmlResultat = simplexml_load_file($_SERVER['DOCUMENT_ROOT'] . "/" . $urlCache . "/" . "cachexmlcateg" . $categ_id . ".xml");
    }
    if ($xmlResultat) {


        echo "<script>var markersProduitsCateg$categ_id=new Array();</script>";
        foreach ($xmlResultat->details->detail as $detail) {
            /* tester si les valeur Latitude et Longitude sont correctes */
            $testGeoLat = $detail->xpath("./criteres/critere[@id=$idCritGeoloc]/modalites/modalite[@id=$idModaliteLat]/valModalite");
            $testGeoLng = $detail->xpath("./criteres/critere[@id=$idCritGeoloc]/modalites/modalite[@id=$idModaliteLng]/valModalite");
            /* if ta = 2*/
            $datesOuvertures = array();
            $dateOuvertureIsOk=false;
            /* Deb : Construction du tableau $datesOuvertures  */
            $periodesOuvertures = $detail->xpath("./periodesOuvertures/periodeOuverture");
            if(count($periodesOuvertures) > 0){
                foreach($periodesOuvertures as $periodeOuverture){
                    $periodeOuvertureDebut = $periodeOuverture[0]->xpath("periodeOuvertureDebut");
                    $periodeOuvertureDebut = $periodeOuvertureDebut[0];
                    $periodeOuvertureFin = $periodeOuverture[0]->xpath("periodeOuvertureFin");
                    $periodeOuvertureFin = $periodeOuvertureFin[0];
                    $datesOuvertures[] = array("dateDebut"=>(string)$periodeOuvertureDebut[0],"dateFin"=>(string)$periodeOuvertureFin[0]);
                }
            }
            
            /* Fin : Construction du tableau $datesOuvertures  */
            
            
            if($typeAffichage == 2 && isset($_GET["filt"]) && $_GET["filt"] == 'j'){

                $dateOuvertureIsOk = dateOuvJ($datesOuvertures);
            }elseif($typeAffichage == 2 && isset($_GET["filt"]) && $_GET["filt"] == 's'){
                
                $dateOuvertureIsOk = dateOuvS($datesOuvertures);
            }elseif($typeAffichage == 2 && isset($_GET["filt"]) && $_GET["filt"] == 'da' && isset($_GET["du"]) && $_GET["du"] != '' && isset($_GET["au"]) && $_GET["au"] != ''){
                $dateDU = $_GET["du"];
                $dateAU = $_GET["au"];
                $dateOuvertureIsOk = dateOuvDA($datesOuvertures, $dateDU, $dateAU);
            }
            if ( ( count($testGeoLat) > 0 && count($testGeoLng) > 0 && is_numeric((string) $testGeoLat[0]) && is_numeric((string) $testGeoLng[0]) ) && ($typeAffichage == 1 || ($typeAffichage == 2 and $dateOuvertureIsOk)) ) {
                
                $varJS = "";
                $idProduit = (string) $detail[@id];
                
                $intitule = $detail->intitule;
                $intitule = (string) $intitule[0];
                $intitule = implode("\\'", explode("'", $intitule));
                $geoLat = $detail->xpath("./criteres/critere[@id=$idCritGeoloc]/modalites/modalite[@id=$idModaliteLat]/valModalite");
                $geoLat = (string) $geoLat[0];
                $geoLng = $detail->xpath("./criteres/critere[@id=$idCritGeoloc]/modalites/modalite[@id=$idModaliteLng]/valModalite");
                $geoLng = (string) $geoLng[0];
                $detailVille = $detail->xpath("./ville/intituleVille");
                $detailVille = (string) $detailVille[0];
                $detailVille = implode("\\'", explode("'", $detailVille));
                $detailAdr1 = $detail->xpath("./adresses/adresse/ligne1");
                $detailAdr1 = (string) $detailAdr1[0];
                $detailAdr1 = implode("\\'", explode("'", $detailAdr1));
                $detailAdr2 = $detail->xpath("./adresses/adresse/ligne2");
                $detailAdr2 = (string) $detailAdr2[0];
                $detailAdr2 = implode("\\'", explode("'", $detailAdr2));
                $detailAdr3 = $detail->xpath("./adresses/adresse/ligne3");
                $detailAdr3 = (string) $detailAdr3[0];
                $detailAdr3 = implode("\\'", explode("'", $detailAdr3));
                $detailCP = $detail->xpath("./adresses/adresse/cp");
                $detailCP = (string) $detailCP[0];
                $detailTel = $detail->xpath("./adresses/adresse/tel1");
                $detailTel = (string) $detailTel[0];
                $detailFax = $detail->xpath("./adresses/adresse/fax");
                $detailFax = (string) $detailFax[0];
                $detailEmail = $detail->xpath("./adresses/adresse/email");
                $detailEmail = (string) $detailEmail[0];
                $detailEmail = implode("\\'", explode("'", $detailEmail));
                $detailWeb = $detail->xpath("./adresses/adresse/web");
                $detailWeb = (string) $detailWeb[0];
                $detailWeb = implode("\\'", explode("'", $detailWeb));
                
                

                $detailNewPhotos = array();
                foreach ($detail->xpath("./newPhotos/newPhoto") as $newPhoto) {
                    $tempStr = (string) $newPhoto;
                    $tempStr = implode("\'", explode("'", $tempStr));
                    $detailNewPhotos[] = $tempStr;
                }
                $cheminPuceCateg = "/extension/ez_aya_carto/design/standard/images/pictos/map/categ_undefined.png";
                if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/extension/ez_aya_carto/design/standard/images/pictos/map/categ_" . $categ_id . ".png")) {
                    $cheminPuceCateg = "/extension/ez_aya_carto/design/standard/images/pictos/map/categ_" . $categ_id . ".png";
                }
                $varJS.="
                      
                      markersProduitsCateg" . $categ_id . "['prod_$idProduit'] = new google.maps.Marker({
                      position: new google.maps.LatLng($geoLat,$geoLng),
                      map: map_container,
                      title:'" . $intitule . "',
                      icon: new google.maps.MarkerImage('" . $cheminPuceCateg . "',
                                                          new google.maps.Size(21, 30),
                                                          new google.maps.Point(0,0),
                                                          new google.maps.Point(11, 30)
                                                          ),
                      shadow: new google.maps.MarkerImage('/extension/ez_aya_carto/design/standard/images/pictos/map/marker_shadow.png',
                                                          new google.maps.Size(30, 21),
                                                          new google.maps.Point(0,0),
                                                          new google.maps.Point(0, 21)
                                                          )
                      });
                      ";
                $geoAddr = $detailAdr1 . $detailAdr2 . $detailAdr3 . $detailCP . $detailVille;
                $geoAddr = implode("\\'", explode("'", $geoAddr));
                $geoAddr = implode("\\'", explode("'", $geoAddr));
                $blocDetail = "<a href=\"#\" class=\"detail-street-view\" onClick=\"setSreetViewAt(\'$geoLat\',\'$geoLng\',\'$geoAddr\');return false;\" title=\"street view\"></a>";
                $blocDetail .= "<a href=\"#\" class=\"detail-close-street-view cache\" onClick=\"hideStreetView();return false;\" title=\"Fermer street view\"></a>";
                
                $blocDetail .= "<p class=\"intitule\">$intitule</p>";
                $blocDetail .= "<p class=\"adresse\">$detailAdr1 $detailAdr2 $detailAdr3<br/>$detailCP $detailVille</p>";
                $blocDetail .= "<p class=\"tel-fax\">Téléphone : $detailTel<br/>Fax : $detailFax</p>";
                $blocDetail .= "<p class=\"web-mail\"><a>Site Internet : $detailWeb</a><br/><a>Contacter par mail: $detailEmail</a></p>";
                $blocDetail .="<div class=\"new-photos\">";
                foreach ($detailNewPhotos as $key => $newPhoto) {
                    if ($key < 8) {
                        $blocDetail .="<img src=\"/Image/Resize?img=$newPhoto&w=50\" class=\"new-photo\" />";
                        if ((((int) $key + 1) % 4) == 0 && $key != 0) {
                            $blocDetail .="<div class=\"clear-both\"></div>";
                        }
                    }
                }
                $blocDetail .="<div class=\"clear-both\"></div>";
                $blocDetail .="</div>";

                $blocValise = "<div class=\"element-valise\">";
                $blocValise .="<a onClick=\"removeFromValise(\'$idProduit\');return false;\" href=\"#\" title=\"Retirer de ma valise\" id=\"removeValise-$idProduit\" class=\"remove-valise\"></a>";
                $blocValise .="<strong class=\"valise-elt-titre\">$intitule</strong>";
                $blocValiseImg = "";
                if (isset($detailNewPhotos[0])) {
                    $blocValiseImg = "<img class=\"valise-elt-image\" src=\"/Image/Resize?img=$detailNewPhotos[0]&w=50\"/>";
                }
                $blocValise .="<p class=\"valise-adresse\">$blocValiseImg $detailAdr1 $detailAdr2 $detailAdr3<br/>$detailCP $detailVille</p>";
                $blocValise .="<div class=\"clear-both\"></div></div>";
                $varJS.="
                    google.maps.event.addListener(markersProduitsCateg" . $categ_id . "['prod_$idProduit'], 'click', function() {
                        detailMarker={'idProd':'$idProduit','marker':markersProduitsCateg" . $categ_id . "['prod_$idProduit'],'blocValise':'$blocValise'};
                        $('#detail-produit').fadeOut('fast',function(){
                            $('#detail-produit .content').html('$blocDetail');
                            $('#detail-produit .control .puce-categorie').html('Détails : $categTitle');
                            $('#detail-produit').fadeIn('slow');
                            
                            if(valiseHasElement(detailMarker['idProd'])){
                               $('#detail-produit .retirer-valise').removeClass('cache');   
                               $('#detail-produit .ajout-valise').addClass('cache');   
                            }else{
                                $('#detail-produit .ajout-valise').removeClass('cache');   
                                $('#detail-produit .retirer-valise').addClass('cache');
                            }
                        });
                    });
                    ";
                $varJS.="cartoMarkers['categ_$categ_id']=markersProduitsCateg" . $categ_id . ";";
                echo "<script>" . $varJS . "</script>";
            }
        }
    }
}
?>
