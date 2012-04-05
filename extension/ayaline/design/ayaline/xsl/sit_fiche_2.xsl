<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="espace" select="' '"/>
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:include href="inc/critere_moda_apartirde.xsl"/>
	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_1.xsl"/>
	<xsl:include href="inc/display_dispos.xsl"/>
	<xsl:include href="inc/rendu_adresse.xsl"/>
	<xsl:include href="inc/bouton_reserver.xsl"/>
	<xsl:include href="inc/galleria_fiche_detail.xsl"/>
	
	<xsl:template match="/produit">
		<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
		<div style="float:left; width: 326px;">
			<xsl:call-template name="galerie-fiche-detail"/>
			
			<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true&amp;key=ABQIAAAAOZJQqoDBwAknMtPNKR-dvRSi2OoyjRwg8X5jAJmNj4togrBv2xSClpdvpd4FJNt4C5i-i6aTtWzs-g"><![CDATA[ ]]></script>
			
			<script type="text/javascript">
				<![CDATA[categorie="]]><xsl:value-of select="categorie/intCategorie"/><![CDATA[";]]>
				<![CDATA[
					function initialize() {
						]]>
						<xsl:choose>
							<xsl:when test="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite != '' and criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite != ''">
								<![CDATA[
							    	var latlng = new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite"/><![CDATA[);
							    ]]>
							</xsl:when>
							<xsl:otherwise>
								<![CDATA[
							    	var latlng = new google.maps.LatLng(46.5, -1.7833);
							    ]]>
							</xsl:otherwise>
						</xsl:choose>
						
					    <![CDATA[
					    var myOptions = {
					      zoom: 15,
					      center: latlng,
					      scrollwheel: false,
					      mapTypeId: google.maps.MapTypeId.ROADMAP
					    };
					    
					    var map = new google.maps.Map(document.getElementById("mapContainer"), myOptions);
					    
					    var marker = new google.maps.Marker({
						    position: latlng, 
						    map: map,
							title:"]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$intitule"/><xsl:with-param name="replace" select="$quot"/><xsl:with-param name="by" select="'\&quot;'"/></xsl:call-template><![CDATA["
						});
				  	}
				]]>
			</script>
			<div class="map">
				<div id="mapContainer" style="width:325px;height:220px;margin-bottom:5px;"><![CDATA[ ]]></div>
			</div>
			<script type="text/javascript">
				<![CDATA[
					initialize();
				]]>
			</script>
			<script type="text/javascript">
				<![CDATA[
					function mapopinfiche(){
						$(".fiche-popin").popin({
							width:1150,
							height:770,
							opacity:.6,
							className:'searchPopin',
							onComplete: function() {
								$(".popin-content-bloc").css('height', "auto");
								
								//Js du calcul de l'itineraire
								Demo = {
									// HTML Nodes
									mapContainer: document.getElementById('map-container'),
									dirContainer: document.getElementById('dir-container'),
									fromInput: document.getElementById('from-input'),
									toInput:"]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite"/><![CDATA[ ]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite"/><![CDATA[",
									travelModeInput: document.getElementById('travel-mode-input'),
									unitInput: document.getElementById('unit-input'),
						
									// API Objects
									dirService: new google.maps.DirectionsService(),
									dirRenderer: new google.maps.DirectionsRenderer(),
									map: null,
						
									showDirections: function(dirResult, dirStatus) {
										if (dirStatus != google.maps.DirectionsStatus.OK) {
											alert('Directions failed: ' + dirStatus);
											return;
										}
						
										// Show directions
										Demo.dirRenderer.setMap(Demo.map);
										Demo.dirRenderer.setPanel(Demo.dirContainer);
										Demo.dirRenderer.setDirections(dirResult);
									},
						
									getSelectedTravelMode: function() {
										var value =
											Demo.travelModeInput.options[Demo.travelModeInput.selectedIndex].value;
										if (value == 'driving') {
										  value = google.maps.DirectionsTravelMode.DRIVING;
										} else if (value == 'bicycling') {
										  value = google.maps.DirectionsTravelMode.BICYCLING;
										} else if (value == 'walking') {
										  value = google.maps.DirectionsTravelMode.WALKING;
										} else {
										  alert('Unsupported travel mode.');
										}
										return value;
									},
						
									getSelectedUnitSystem: function() {
										return Demo.unitInput.options[Demo.unitInput.selectedIndex].value == 'metric' ?
											google.maps.DirectionsUnitSystem.METRIC :
											google.maps.DirectionsUnitSystem.IMPERIAL;
									},
						
									getDirections: function() {
										var fromStr = Demo.fromInput.value;
										var toStr = Demo.toInput;
										var dirRequest = {
										  origin: fromStr,
										  destination: toStr,
										  travelMode: Demo.getSelectedTravelMode(),
										  unitSystem: Demo.getSelectedUnitSystem(),
										  provideRouteAlternatives: true
										};
										Demo.dirService.route(dirRequest, Demo.showDirections);
									},
						
									init: function() {
										var latLng = new google.maps.LatLng(46.5, -1.7833);
										Demo.map = new google.maps.Map(Demo.mapContainer, {
										  zoom: 13,
										  center: latLng,
										  mapTypeId: google.maps.MapTypeId.ROADMAP
										});
						
										// Show directions onload
										Demo.getDirections();
									}
								};
								
								// Onload handler to fire off the app.
								Demo.init();
								//google.maps.event.addDomListener(window, 'load', Demo.init);
							}
						});
					}
				]]>
			</script>
			<a class="fiche-popin" target="_blank" style="margin-left: 120px;">
				<xsl:attribute name="href">/layout/set/vide/Itineraire-Rubrique?nom=<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template></xsl:attribute>
				<b>&amp;gt;&amp;gt; <xsl:value-of select="$termeItineraire"/></b>
			</a>
			<script type="text/javascript">
				<![CDATA[
					mapopinfiche();
				]]>
			</script>
			<br /><br />
			
			<xsl:if test="string-length(criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280003']/valModalite) &gt; 0">
				<script src="http://gadget.open-system.fr/osform.min.js" type="text/JavaScript" ><![CDATA[ ]]></script>
				<script type="text/javascript" xml:space="preserve">
				<![CDATA[
					$(function () {
						]]>
						<xsl:if test="$langue = 'en'">
							<![CDATA[document.oswidget = new OsFG("OSRechercheDetail","22357-1624","uk");]]>
						</xsl:if>
						<xsl:if test="$langue != 'en'">
							<![CDATA[document.oswidget = new OsFG("OSRechercheDetail","22357-1624","fr");]]>
						</xsl:if>
						<![CDATA[						
						document.oswidget.AliasTerritoire("otsablesolonne");
						document.oswidget.ListeIdFournisseur("]]><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280003']/valModalite"/><![CDATA[");
						document.oswidget.Affiche();
					});
				]]>
				</script>
				<div id="OSRechercheDetail"><![CDATA[ ]]></div>
			</xsl:if>
			<br />
			
			<xsl:if test="count(liensMultimedia/lienMultimedia[@type='son']) &gt; 0">
				<xsl:for-each select="liensMultimedia/lienMultimedia[@type='son' and string-length(codeHtmlLienMultimedia) &gt; 0]">
					<div style="margin-top: 20px; display: inline-block;">
						<xsl:call-template name="string-replace-all">
							<xsl:with-param name="text">
								<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="codeHtmlLienMultimedia"/>
									<xsl:with-param name="replace" select="'_dw_entity__gt__'"/>
									<xsl:with-param name="by"><![CDATA[>]]></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="replace" select="'_dw_entity__lt__'"/>
							<xsl:with-param name="by"><![CDATA[<]]></xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:for-each>
			</xsl:if>
			
			<xsl:if test="count(liensMultimedia/lienMultimedia[@type='video']) &gt; 0">
				<xsl:for-each select="liensMultimedia/lienMultimedia[@type='video' and string-length(codeHtmlLienMultimedia) &gt; 0]">
					<div style="margin-top: 20px; display: inline-block;">
						<xsl:call-template name="string-replace-all">
							<xsl:with-param name="text">
								<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="codeHtmlLienMultimedia"/>
									<xsl:with-param name="replace" select="'_dw_entity__gt__'"/>
									<xsl:with-param name="by"><![CDATA[>]]></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
							<xsl:with-param name="replace" select="'_dw_entity__lt__'"/>
							<xsl:with-param name="by"><![CDATA[<]]></xsl:with-param>
						</xsl:call-template>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
		
		
		
		<div style="float:left; width: 310px;">
			<h2 class="bloc-detail-h2" style="width: 295px; margin-left:10px;"><xsl:value-of select="$intitule"/><![CDATA[ ]]></h2>
			<p class="lien-bas" style="margin-right:7px;">
				<xsl:call-template name="boutons-reserver-liste"/>
			</p>
			<p class="clear" style="margin-bottom:5px;"></p>
			
			<div style="margin:0px 0px 20px 10px">
				<xsl:for-each select="adresses/adresse[@type='produit']">
					<div style="padding:15px;background-color:#EEEEEE;">
						<div><strong><xsl:value-of select="$termeAdresseFiche"/></strong></div>
						<xsl:call-template name="rendu-adresse"/>
					</div>
				</xsl:for-each>
				<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
			</div>
			
			<p class="ss-titre apartirde">
				<xsl:if test="criteres/critere[@id=$critere-apartirde]/modalites/modalite[@id=$modalite-apartirde]/valModalite">
					<span class="picto"><xsl:value-of select="$termeAPartirDe"/> <span><xsl:value-of select="criteres/critere[@id=$critere-apartirde]/modalites/modalite[@id=$modalite-apartirde]/valModalite"/> &amp;euro;</span></span>
				</xsl:if>
				<![CDATA[ ]]>
			</p>
			
			<table cellspacing="0" cellpadding="0">
				<tr><td style="padding:0 0 0 15px">
					<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"><![CDATA[ ]]></script>
					<script xml:space="preserve" type="text/javascript">
						<![CDATA[
							$(document).ready(function() {
								$("#tabs").tabs();
							});
						]]>
					</script>
					<div id="tabs">
						<ul>
							<li><a href="#onglet-description"><span><xsl:value-of select="$termeDescriptif"/></span></a></li>
							<li><a href="#onglet-tarifs"><span>Tarifs</span></a></li>
							<li><a href="#onglet-caracteristiques"><span><xsl:value-of select="$termeCaracteristiques"/></span></a></li>
							<li style="background-color: #7AD6E1 !important;"><a href="#onglet-avis"><span><xsl:value-of select="$termeAvis"/></span></a></li>
						</ul>
						
						<div id="onglet-description">
							<xsl:variable name="commentaire"><xsl:if test="$langue = 'en'"><xsl:value-of select="commentaires/commentaire2"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="commentaires/commentaire1"/></xsl:if></xsl:variable>
							<xsl:if test="string-length($commentaire) &gt; 0">
								<p class="padding-bottom: 14px">
									<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="$commentaire"/>
									<xsl:with-param name="replace" select="'\n'"/>
									<xsl:with-param name="by" select="'&lt;br/&gt;'"/>
									</xsl:call-template>
									<![CDATA[ ]]>
								</p>
							</xsl:if>
							
							<xsl:call-template name="periodes-ouverture"/>
							<![CDATA[ ]]>
						</div>
						
						<div id="onglet-tarifs">
							<table cellspacing="0" width="100%">
								<xsl:for-each select="criteres/critere[@id='851000039' or @id='851000058' or @id='851000059' or @id='851000060' or @id='851000061' or @id='851000062' or @id='851000063' or @id='851000064' or @id='851000065' or @id='851000066' or @id='851000067' or @id='851000068' or @id='851000069' or @id='851000070' or @id='851000076' or @id='851000077' or @id='851000071' or @id='851000072' or @id='851000073' or @id='851000074' or @id='851000075']">
									<xsl:variable name="positionCritere" select="position()"/>
									<tr>
										<td>
											<xsl:attribute name="style">width:60%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">7A7368</xsl:if><xsl:if test="(position() mod 2) = 0">E0E0E0</xsl:if>;color:#<xsl:if test="(position() mod 2) = 1">FFFFFF</xsl:if><xsl:if test="(position() mod 2) = 0">353535</xsl:if></xsl:attribute>
											<strong><xsl:value-of select="intCritere"/> :</strong>
										</td>
										<td>
											<xsl:attribute name="style">text-align:center;width:40%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">E4E0DB</xsl:if><xsl:if test="(position() mod 2) = 0">EEEEEE</xsl:if>;color:#353535</xsl:attribute>
											<![CDATA[ ]]>
										</td>
									</tr>
									<xsl:for-each select="modalites/modalite">
										<tr>
											<td>
												<xsl:attribute name="style">width:60%;vertical-align:top;font-size:90%;padding:1px 10px;background-color:#<xsl:if test="($positionCritere mod 2) = 1">7A7368</xsl:if><xsl:if test="($positionCritere mod 2) = 0">E0E0E0</xsl:if>;color:#<xsl:if test="($positionCritere mod 2) = 1">FFFFFF</xsl:if><xsl:if test="($positionCritere mod 2) = 0">353535</xsl:if></xsl:attribute>
												<strong><xsl:value-of select="intModalite"/></strong>
											</td>
											<td>
												<xsl:attribute name="style">text-align:center;width:40%;vertical-align:top;font-size:90%;padding:1px 10px;background-color:#<xsl:if test="($positionCritere mod 2) = 1">E4E0DB</xsl:if><xsl:if test="($positionCritere mod 2) = 0">EEEEEE</xsl:if>;color:#353535</xsl:attribute>
												<xsl:value-of select="valModalite"/> &amp;euro;
											</td>
										</tr>
									</xsl:for-each>
								</xsl:for-each>
								<![CDATA[ ]]>
							</table>
						</div>
						
						<div id="onglet-caracteristiques">
							<xsl:if test="count(criteres/critere[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0]) &gt; 0">
								<table cellspacing="0" width="100%">
									<xsl:for-each select="criteres/critere[($modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0) and @id!='851000039' and @id!='851000058' and @id!='851000059' and @id!='851000060' and @id!='851000061' and @id!='851000062' and @id!='851000063' and @id!='851000064' and @id!='851000065' and @id!='851000066' and @id!='851000067' and @id!='851000068' and @id!='851000069' and @id!='851000070' and @id!='851000076' and @id!='851000077' and @id!='851000071' and @id!='851000072' and @id!='851000073' and @id!='851000074' and @id!='851000075' and @id!=$critere-apartirde]">
										<xsl:if test="count(modalites/modalite) &gt; 0">
											<xsl:variable name="idCritere" select="@id"/>
											<tr>
												<td>
													<xsl:attribute name="style">width:40%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">7A7368</xsl:if><xsl:if test="(position() mod 2) = 0">E0E0E0</xsl:if>;color:#<xsl:if test="(position() mod 2) = 1">FFFFFF</xsl:if><xsl:if test="(position() mod 2) = 0">353535</xsl:if></xsl:attribute>
													<xsl:if test="string-length(intCritere) &gt; 0"><strong><xsl:value-of select="intCritere"/></strong></xsl:if><xsl:if test="string-length(intCritere) = 0">&amp;nbsp;</xsl:if>
												</td>
												<td>
													<xsl:attribute name="style">width:60%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">E4E0DB</xsl:if><xsl:if test="(position() mod 2) = 0">EEEEEE</xsl:if>;color:#353535</xsl:attribute>
													<xsl:for-each select="modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', $idCritere, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', $idCritere, '|'))))]">
														<div>
															<xsl:value-of select="intModalite"/><xsl:if test="string-length(intModalite) &gt; 0 and string-length(valModalite) &gt; 0">&amp;nbsp;:&amp;nbsp;</xsl:if><xsl:if test="string-length(valModalite) &gt; 0"><strong><xsl:value-of select="valModalite"/></strong></xsl:if>
														</div>
													</xsl:for-each>
												</td>
											</tr>
										</xsl:if>
									</xsl:for-each>
								</table>
							</xsl:if>
							<![CDATA[ ]]>
						</div>
						
						<div id="onglet-avis">
							<xsl:choose>
								<xsl:when test="count(liensMultimedia/lienMultimedia[@type='image']) &gt; 0">
									<xsl:for-each select="liensMultimedia/lienMultimedia[@type='image' and string-length(codeHtmlLienMultimedia) &gt; 0 and position() = 1]">
										<div>
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text">
													<xsl:call-template name="string-replace-all">
														<xsl:with-param name="text" select="codeHtmlLienMultimedia"/>
														<xsl:with-param name="replace" select="'_dw_entity__gt__'"/>
														<xsl:with-param name="by"><![CDATA[>]]></xsl:with-param>
													</xsl:call-template>
												</xsl:with-param>
												<xsl:with-param name="replace" select="'_dw_entity__lt__'"/>
												<xsl:with-param name="by"><![CDATA[<]]></xsl:with-param>
											</xsl:call-template>
										</div>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<p>
										<xsl:value-of select="$termeAucunAvisPourLeMoment"/>.<br />
										<xsl:value-of select="$termeSoyezLePremier"/> : <a target="_blank" href="http://www.tripadvisor.fr/Tourism-g196666-Les_Sables_d_Olonne_Vendee_Pays_de_la_Loire-Vacations.html"><xsl:value-of select="$termeVotreAvis"/></a>
									</p>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</div>
					<br/>
				</td></tr>
			</table>
		</div>
		<p class="clear"><![CDATA[ ]]></p>
		<p class="space"><![CDATA[ ]]></p>
		
		<xsl:if test="string-length($lienPrecedent) &gt; 0">
			<div style="text-align:right;"><a>
				<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if>#fiche-<xsl:value-of select="@id"/></xsl:attribute>
				&amp;lt;&amp;lt;&amp;nbsp;<xsl:value-of select="$termeRetourListe"/>
			</a></div>
		</xsl:if>
		
		<div class="float-d" style="margin-bottom:10px;">
			<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pubid=xa-4db82bbb1279e354"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
			<!-- deja present dans le menu pied de page <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4db82bbb1279e354"></script> -->
		</div>
		
		<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
	</xsl:template>
</xsl:stylesheet>
