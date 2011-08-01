<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="amp">&amp;</xsl:variable>
	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/enhanced_substring.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true&amp;key=ABQIAAAAOZJQqoDBwAknMtPNKR-dvRSi2OoyjRwg8X5jAJmNj4togrBv2xSClpdvpd4FJNt4C5i-i6aTtWzs-g"><![CDATA[ ]]></script>
			
			<script type="text/javascript">
				<![CDATA[
					function initialize() {
						//Mettre les coordonnees du centre des Sables d'Olonne
						var latlng = new google.maps.LatLng(46.1667, -1.15);
						
						var myOptions = {
						  zoom: 13,
						  center: latlng,
						  scrollwheel: false,
						  mapTypeId: google.maps.MapTypeId.ROADMAP
						};
						
						var map = new google.maps.Map(document.getElementById("mapContainerListe"), myOptions);
						
						]]>
						<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)]">
							<xsl:if test="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite != '' and criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite != ''">
								<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(translate(translate(intitule, concat('/-?_.', $apos, $amp), '	   '), $caracteresKo, $caracteresOk), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
								<![CDATA[
									var contentString = '<div class="moninfobulle">'+
											'<div class="titre"><h3>]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><![CDATA[</h3>'+
											']]><xsl:choose>
													<xsl:when test="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite != ''">
														<img alt="" class="etoile">
															<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
															<xsl:attribute name="title"><![CDATA[Cat&eacute;gorie : ]]><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/></xsl:attribute>
														</img>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/>
													</xsl:otherwise>
												</xsl:choose><![CDATA[</div>'+
											']]><xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
													<img class="float-g photo" alt="">
														<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=120</xsl:attribute>
													</img>
												</xsl:if><![CDATA['+
											'<span class="float-d">]]><xsl:value-of select="ville/intituleVille"/><![CDATA[</span><br />'+
											']]><xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
													<xsl:variable name="commentaire1Nettoye">
														<xsl:call-template name="string-replace-all">
															<xsl:with-param name="text" select="commentaires/commentaire1"/>
															<xsl:with-param name="replace" select="'\n'"/>
															<xsl:with-param name="by" select="' '"/>
														</xsl:call-template>
													</xsl:variable>
													<xsl:variable name="commentaire1NettoyeCoupe">
														<xsl:if test="string-length($commentaire1Nettoye) &lt;= 200">
															<xsl:value-of select="$commentaire1Nettoye"/>
														</xsl:if>
														<xsl:if test="string-length($commentaire1Nettoye) &gt; 200">
															<xsl:call-template name="enhanced-substring">
																<xsl:with-param name="text" select="$commentaire1Nettoye"/>
																<xsl:with-param name="currentSize" select="0"/>
																<xsl:with-param name="totalSize" select="200"/>
																<xsl:with-param name="delimiter" select="' '"/>
															</xsl:call-template>
														</xsl:if>
													</xsl:variable>
													<p class="commentaire">
														<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$commentaire1NettoyeCoupe"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><xsl:if test="string-length($commentaire1Nettoye) &gt; 200">&amp;hellip;</xsl:if>
													</p>
												</xsl:if><![CDATA[<div class="clear"></div>'+
											'<p class="lien">]]>
												<a class="link-popin" target="_blank">
													<xsl:attribute name="href">/layout/set/vide/Itineraire-Rubrique?nom=<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template></xsl:attribute>
													<![CDATA[<b>>> Itin&eacute;raire</b>]]>
												</a>
												<a class="float-d">
													<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
													<![CDATA[<b>>> En savoir plus / R&eacute;server</b>]]>
												</a>
											<![CDATA[</p>'+
										'</div>';

									var infowindow = new google.maps.InfoWindow({
										content: contentString,
										maxWidth: 300
									});

									var marker = new google.maps.Marker({
										position: new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite"/><![CDATA[),
										map: map,
										icon: '/extension/ayaline/design/ayaline/images/picto-hotel.png',
										title:"]]><xsl:value-of select="intitule"/><![CDATA["
									});
									
									marker._infowindow = infowindow;
									
									google.maps.event.addListener(marker, 'click', function() {
										this._infowindow.open(map, this);
										
										//Pour lancer la popin
										$(".moninfobulle .link-popin").popin({
											width:1150,
											height:770,
											opacity:.6,
											className:'searchPopin',
											onComplete: function() {
											
												$(".popin-content-bloc").css('height', "auto");
												
												Demo.toInput = "]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite"/><![CDATA[ ]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite"/><![CDATA[";
												Demo.mapContainer = document.getElementById('map-container');
												Demo.dirContainer = document.getElementById('dir-container');
												Demo.fromInput = document.getElementById('from-input');
												Demo.travelModeInput = document.getElementById('travel-mode-input');
												Demo.unitInput = document.getElementById('unit-input');

												// Onload handler to fire off the app.
												Demo.init();
											}
										});
									});
								]]>
							</xsl:if>
						</xsl:for-each>
						<![CDATA[
							//Js du calcul de l'itineraire
							Demo = {
								// HTML Nodes
								mapContainer: document.getElementById('map-container'),
								dirContainer: document.getElementById('dir-container'),
								fromInput: document.getElementById('from-input'),
								toInput:"",
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
				  	}
				]]>
			</script>
			<div id="mapContainerListe" style="width:635px;height:400px;margin-bottom:10px;border: 1px solid #E9E3DE;"><![CDATA[ ]]></div>
			<script type="text/javascript">
				<![CDATA[
					initialize();
				]]>
			</script>
			
			<span class="picto-hotel">H&amp;ocirc;tels</span>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
