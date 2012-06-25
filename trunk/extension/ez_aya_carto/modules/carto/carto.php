<?php
$ezAyaCartoIni = eZINI::instance('ez_aya_carto.ini');
$SITCategoriesTitle = $ezAyaCartoIni->variable('SITCategoriesSettings', 'SITCategoriesTitle');
$MapCenter = $ezAyaCartoIni->variable('MapSettings', 'MapCenter');
$MapZoom = $ezAyaCartoIni->variable('MapSettings', 'Zoom');
$MapType = $ezAyaCartoIni->variable('MapSettings', 'MapType');
$MapSVProximite = $ezAyaCartoIni->variable('MapSettings', 'MapSVProximite');
$DureeInactivite = $ezAyaCartoIni->variable('GlobalCartoSitParameters', 'DureeInactivite');
$SITSections = $ezAyaCartoIni->variable('MenuSettings', 'SITSections');
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Cartographie google map v3</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="/extension/ez_aya_carto/design/standard/stylesheets/carto.css">
        <script src="/extension/ez_aya_carto/design/standard/javascript/jquery.min.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/jquery-ui.min.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/jquery.idle-timer.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
        <script>
            var streetViewMarker;
            var cartoMarkers = new Array();
            var searchCartoMarkers = new Array();
            var geoCodeMarkers = new Array();
            var valiseMarkers = new Array();
            var detailMarker = false;
            var valiseRoute = new Array();
            var creerTrajetMarkers = new Array();
            var creerTrajetSelectedMode = '0';
            var directionsDisplay = new google.maps.DirectionsRenderer();
            var directionsService = new google.maps.DirectionsService();
            var directionsDisplayTrajet = new google.maps.DirectionsRenderer();
            var directionsServiceTrajet = new google.maps.DirectionsService();
            var geocoder = new google.maps.Geocoder();
            var svProximite = <?php echo $MapSVProximite;?>;
        </script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/outils.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/fonctionalitesValise.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/utils.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/generaldispaly.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/main.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/ez_aya_carto_utils.js"></script>
        <script src="/extension/ez_aya_carto/design/standard/javascript/sreetview.js"></script>

    </head>
    <body>
        <div id="global-carto">
            <div id="overlay-loading"><img src="/extension/ez_aya_carto/design/standard/images/chargement.gif"/></div>
            <div id="google-map"></div>
            <div id="directions-details">
                <div class="control">
                    <a href="#" title="fermer" class="puce-close"></a>
                    <h2 class="directions-details-titre">Détails de l'itinéraire</h2>
                    <div class="clear-both"></div>
                </div>
                <div class="directions-details-content"></div>
            </div>
            <div id="detail-produit">
                <div class="control">
                    <a href="#" title="fermer" class="puce-close"></a>
                    <h2 class="puce-categorie"></h2>
                    <div class="clear-both"></div>
                </div>
                <div class="content">
                </div>
                <div class="centre-valise">
                    <a href="#" class="centre-carte"></a>
                    <a href="#" class="ajout-valise"></a>
                    <a href="#" class="retirer-valise cache"></a>
                    <div class="clear-both"></div>
                </div>
            </div>
            <div id="menu-top"></div>
            <div id="menu-droite">
                <ul class="menu-container">
                    <li class="niv-1">
                        <a id="afficher-titre" href="#" class="has-sub-menu section-menu">Afficher</a>
                        <div class="sous-menu">
                            <ul class="menu-container">
                                <?php
                                foreach ($SITSections as $SITSection) {
                                    $SITSectionTitre = $ezAyaCartoIni->variable($SITSection, 'Titre');
                                    $SITSectionIcone = $ezAyaCartoIni->variable($SITSection, 'Icone');
                                    $SITSectionChildren = $ezAyaCartoIni->variable($SITSection, 'SectionChildren');
                                    ?>
                                    <li class="niv-2">
                                        <?php
                                        $eltStyleCss = "";
                                        if ($SITSectionIcone != false && file_exists($_SERVER['DOCUMENT_ROOT'] . "/extension/ez_aya_carto/design/standard/images/menu/" . $SITSectionIcone)) {
                                            $eltStyleCss .= "background: url('/extension/ez_aya_carto/design/standard/images/menu/$SITSectionIcone') no-repeat 0 50%;";
                                        }
                                        ?>
                                        <a href="#" class="has-sub-menu niv-2" style="<?php echo $eltStyleCss; ?>">
                                            <?php echo $SITSectionTitre; ?>
                                        </a>
                                        <div class="sous-menu">
                                            <div class="titre-sous-menu">
                                                <?php
                                                if ($SITSectionIcone != false && file_exists($_SERVER['DOCUMENT_ROOT'] . "/extension/ez_aya_carto/design/standard/images/menu/" . $SITSectionIcone)) {
                                                    echo "<img src=\"/extension/ez_aya_carto/design/standard/images/menu/" . $SITSectionIcone . "\" />";
                                                }
                                                ?>
                                                <span class="text"><?php echo $SITSectionTitre; ?></span>
                                                <div class="clear-both"></div>
                                            </div>
                                            <ul>
                                                <?php
                                                foreach ($SITSectionChildren as $keySectionChild => $SectionChild) {
                                                    $SectionChildTitle = $SITCategoriesTitle[$SectionChild];
                                                    ?>
                                                    <li>
                                                        <label for="categ_<?php echo $SectionChild; ?>">
                                                            <?php
                                                            $cheminPuceCateg = "/extension/ez_aya_carto/design/standard/images/pictos/menu/categ_undefined.png";
                                                            if (file_exists($_SERVER['DOCUMENT_ROOT'] . "/extension/ez_aya_carto/design/standard/images/pictos/menu/categ_" . $SectionChild . ".png")) {
                                                                $cheminPuceCateg = "/extension/ez_aya_carto/design/standard/images/pictos/menu/categ_" . $SectionChild . ".png";
                                                            }
                                                            ?>
                                                            <img src="<?php echo $cheminPuceCateg; ?>" />
                                                            <span class="categ-name">
                                                                <input class="checkbox-categorie" id="categ_<?php echo $SectionChild; ?>" type="checkbox" name="categ_<?php echo $SectionChild; ?>" />
                                                                <?php echo $SectionChildTitle; ?>  
                                                            </span>
                                                            <div class="clear-both"></div>
                                                        </label>
                                                    </li>
                                                    <?php
                                                }
                                                ?>
                                            </ul>
                                        </div>
                                    </li>
                                    <?php
                                }
                                ?>
                            </ul>
                        </div>
                    </li>
                    <li class="niv-1">
                        <a id="outils-titre" href="#" class="cache has-sub-menu section-menu">Outils</a>
                        <div class="sous-menu">
                            <ul class="menu-container">
                                <li class="niv-2">
                                    <a href="#" class="has-sub-menu" id="outils-geocode">Géolocaliser</a>
                                    <div class="sous-menu">
                                        <div class="titre-sous-menu">
                                            <img src="/extension/ez_aya_carto/design/standard/images/menu/icon_recherche_perimetre.png"/>
                                            <span class="text">Géolocaliser</span>
                                            <div class="clear-both"></div>
                                        </div>
                                        <form id="geocode-form">
                                            <input type="text" id="geocode-address"/>
                                            <input class="submit-puce-loupe" type="submit" id="geocode-address-submit" value="" title="rechercher"/>
                                        </form>
                                        <a href="#" id="delete-markers-geocode" class="medium-font" title="Effacer les marqueurs"></a>
                                    </div>
                                </li>
                                <li class="niv-2">
                                    <a href="#" class="has-sub-menu" id="outils-creer-trajet">Créer un trajet</a>
                                    <div class="sous-menu">
                                        <div class="titre-sous-menu">
                                            <img src="/extension/ez_aya_carto/design/standard/images/menu/icon_trajet_personnalise.png"/>
                                            <span class="text">Créer un trajet</span>
                                            <div class="clear-both"></div>
                                        </div>
                                        <form id="creer-trajet-form">
                                            <div><label for="creer-trajet-mode-drive"><img src="/extension/ez_aya_carto/design/standard/images/menu/icone_envoiture.png" class="puce-20"/><input class="creer-trajet-mode" id="creer-trajet-mode-drive" type="radio" name="travel_mode" value="0" checked="checked" /> En voiture</label></div>
                                            <div><label for="creer-trajet-mode-walk"><img src="/extension/ez_aya_carto/design/standard/images/menu/icone_apied.png" class="puce-20"/><input class="creer-trajet-mode" id="creer-trajet-mode-walk" type="radio" name="travel_mode" value="1"/> A pied</label></div>
                                            <div class="display-table medium-font">
                                                <div class="display-table-cell"><a href="#" id="creer-trajet-reset" title="Effacer le trajet"></a></div>
                                                <div class="display-table-cell"><a href="#" id="creer-trajet-laststep" title="Annuler la dernière étape"></a></div>
                                                <div class="display-table-cell"><a href="#" id="creer-trajet-afficher-details" title="Afficher les détails"></a></div>   
                                            </div>

                                        </form>
                                    </div>
                                </li>
                                <li class="niv-2">
                                    <a href="#" class="has-sub-menu" id="outils-recherche">Rechercher</a>
                                    <div class="sous-menu">
                                        <div class="titre-sous-menu">
                                            <img src="/extension/ez_aya_carto/design/standard/images/menu/icon_recherche_globale.png"/>
                                            <span class="text">Rechercher</span>
                                            <div class="clear-both"></div>
                                        </div>
                                        <form id="outils-recherche-form">
                                            <input type="text" id="outils-recherche-text" />
                                            <input class="submit-puce-loupe" type="submit"  value="" title="rechercher"/>
                                        </form>
                                        <div class="display-table medium-font">
                                            <div class="display-table-cell"><a href="#" id="outils-recherche-reset" title="Réinitialiser la recheche"></a></div>
                                            <div class="display-table-cell"><a href="#" id="outils-recherche-lastsearch" title="Dernière recherche"></a></div>
                                            <div class="display-table-cell"><a href="#" id="outils-recherche-showAll" title="Réafficher tout"></a></div>   
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <div id="menu-bottom">
                <div id="ma-valise">
                    <a id="valise-titre" href="#" class="section-menu">ma valise</a>
                    <div id="valise-container">
                        <div id="valise-elements"></div>
                        <div id="valise-controls" class="display-table">
                            <!--a id="valise-export-gpx" href="#" class="display-table-cell">
                                <span>Exporter au format GPS</span>
                            </a-->
                            <a id="valise-tracer-itineraire" class="display-table-cell" href="#">
                                <span class="first">Tracer l'itinéraie</span>
                                <span class="second cache">Cacher l'itinéraie</span>
                            </a>
                            <a id="valise-affiche-pictos" class="display-table-cell" href="#">
                                <span class="first">Afficher sur la carte</span>
                                <span class="second cache">Cacher sur la carte</span>
                            </a>
                            <div class="clear-both"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script type="text/javascript">
            var myOptions = {
                zoom: <?php echo $MapZoom;?>,
                center: new google.maps.LatLng(<?php echo $MapCenter['lat']; ?>, <?php echo $MapCenter['lng']; ?>),
                mapTypeId: <?php echo "google.maps.MapTypeId.$MapType"; ?>
            }
            var map_container = new google.maps.Map(document.getElementById("google-map"), myOptions);
            /* idleTimer :  */
            (function($){
               var stimeout = <?php echo $DureeInactivite * 1000;?>;

               $(document).bind("idle.idleTimer", function(){
                    reinitialiser();
               });

               $(document).bind("active.idleTimer", function(){
                    
               });

               $(document).idleTimer(stimeout);

           })(jQuery);
           
        </script>
        <div id="script-container"></div>
    </body>
</html>
