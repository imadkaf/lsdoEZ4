<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="espace" select="' '"/>
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_1.xsl"/>
	<xsl:include href="inc/display_dispos.xsl"/>
	<xsl:include href="inc/rendu_adresse.xsl"/>

	<xsl:template match="/produit">
	
		<div style="float:left; width: 326px;">
			<xsl:if test="count(newPhotos/newPhoto) &gt; 0">
				<div id="galleria" class="galerie-fiche">
					<xsl:for-each select="newPhotos/newPhoto">
						<a>
							<xsl:attribute name="rel"><xsl:value-of select="."/></xsl:attribute>
							<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=306&amp;amp;mw=1</xsl:attribute>
							<img alt="">
								<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=60&amp;amp;mw=1</xsl:attribute>
							</img>
						</a>
					</xsl:for-each>
				</div>
				<script type="text/javascript">
					<![CDATA[
						// Load the classic theme
						Galleria.loadTheme("/extension/ayaline_gallery/design/standard/javascript/galleria/themes/classic/galleria.classic.min.js");

						// Initialize Galleria
						$('#galleria').galleria({
							autoplay: 5000,
							lightbox: true
						});
					]]>
				</script>
				<div class="clear"><![CDATA[ ]]></div><br />
			</xsl:if>
			
			<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true&amp;key=ABQIAAAAOZJQqoDBwAknMtPNKR-dvRSi2OoyjRwg8X5jAJmNj4togrBv2xSClpdvpd4FJNt4C5i-i6aTtWzs-g"><![CDATA[ ]]></script>
			
			<script type="text/javascript">
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
							title:"]]><xsl:value-of select="intitule"/><![CDATA["
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
				<xsl:attribute name="href">/layout/set/vide/Itineraire-Rubrique?nom=<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template></xsl:attribute>
				<b>&amp;gt;&amp;gt; Itin&amp;eacute;raire</b>
			</a>
			<script type="text/javascript">
				<![CDATA[
					mapopinfiche();
				]]>
			</script>
			
			<div style="float:left;margin-top:20px;">
				<img alt="" style="float:right;margin-left:20px"><xsl:attribute name="src"><xsl:value-of select="partenaire/logoPartenaire"/></xsl:attribute></img><xsl:value-of select="$termeInformationProposeePar"/>&amp;nbsp;:<br/><strong><xsl:if test="string-length(partenaire/webPartenaire) &gt; 0"><a target="_blank"><xsl:attribute name="href"><xsl:value-of select="partenaire/webPartenaire"/></xsl:attribute><xsl:value-of select="partenaire/intPartenaire"/></a></xsl:if><xsl:if test="string-length(partenaire/webPartenaire) = 0"><xsl:value-of select="partenaire/intPartenaire"/></xsl:if></strong>
			</div>
			<br />
			
			<xsl:if test="count(liensMultimedia/lienMultimedia[@type='son']) &gt; 0">
				<xsl:for-each select="liensMultimedia/lienMultimedia[@type='son' and string-length(codeHtmlLienMultimedia) &gt; 0]">
					<div style="margin-top: 20px; display: inline-block;"><xsl:value-of select="codeHtmlLienMultimedia"/></div>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="count(liensMultimedia/lienMultimedia[@type='video']) &gt; 0">
				<xsl:for-each select="liensMultimedia/lienMultimedia[@type='video' and string-length(codeHtmlLienMultimedia) &gt; 0]">
					<div style="margin-top: 20px; display: inline-block;"><xsl:value-of select="codeHtmlLienMultimedia"/></div>
				</xsl:for-each>
			</xsl:if>
		</div>
		
		
		
		<div style="float:left; width: 310px;">
			<h2 class="bloc-detail-h2" style="width: 295px; margin-left:10px;"><xsl:value-of select="intitule"/></h2>
			<p class="clear" style="margin-bottom:20px;"></p>
			
			<div style="margin:0px 0px 20px 10px">
				<xsl:for-each select="adresses/adresse[@type='produit']">
					<div style="padding:15px;background-color:#EEEEEE;">
						<div><strong><xsl:value-of select="$termeAdresseFiche"/></strong></div>
						<xsl:call-template name="rendu-adresse"/>
					</div>
				</xsl:for-each>
				<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
			</div>
			
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
							<li><a href="#onglet-description"><span>Descriptif</span></a></li>
							<li><a href="#onglet-caracteristiques"><span>Caract&amp;eacute;ristiques</span></a></li>
							<li style="background-color: #7AD6E1 !important;"><a href="#onglet-avis"><span>Avis</span></a></li>
						</ul>
						
						<div id="onglet-description">
							<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
								<p class="padding-bottom: 14px">
									<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="commentaires/commentaire1"/>
									<xsl:with-param name="replace" select="'\n'"/>
									<xsl:with-param name="by" select="'&lt;br/&gt;'"/>
									</xsl:call-template>
								</p>
							</xsl:if>
							
							<xsl:call-template name="periodes-ouverture"/>
							<![CDATA[ ]]>
						</div>
						
						<div id="onglet-caracteristiques">
							<xsl:if test="count(criteres/critere[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0]) &gt; 0">
								<table cellspacing="0" width="100%">
									<xsl:for-each select="criteres/critere[($modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0)]">
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
									<xsl:for-each select="liensMultimedia/lienMultimedia[@type='image' and string-length(codeHtmlLienMultimedia) &gt; 0]">
										<div><xsl:value-of select="codeHtmlLienMultimedia"/></div>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<p>
										Aucun avis pour le moment.<br />
										Soyez le premier : <a target="_blank" href="http://www.tripadvisor.fr/Tourism-g196666-Les_Sables_d_Olonne_Vendee_Pays_de_la_Loire-Vacations.html">Votre avis</a>
									</p>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</div>
					<br/>
				</td></tr>
			</table>
		</div>
		<p class="clear"></p>
		<p class="space"></p>
		<xsl:if test="string-length($lienPrecedent) &gt; 0">
			<div style="text-align:right"><a>
				<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if>#fiche-<xsl:value-of select="@id"/></xsl:attribute>
				&amp;lt;&amp;lt;&amp;nbsp;<xsl:value-of select="$termeRetourListe"/>
			</a></div>
		</xsl:if>
		
		<div class="float-d" style="margin-bottom:10px;">
			<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pubid=xa-4db82bbb1279e354"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
			<!-- deja present dans le menu pied de page <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4db82bbb1279e354"></script> -->
		</div>
		
		<p class="clear"></p>
		<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
	</xsl:template>
</xsl:stylesheet>
