<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="espace" select="' '"/>
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_1.xsl"/>
	<xsl:include href="inc/display_dispos.xsl"/>
	<xsl:include href="inc/rendu_adresse.xsl"/>
	<xsl:include href="inc/bouton_reserver.xsl"/>
	<xsl:include href="inc/galleria_fiche_detail.xsl"/>

	<xsl:template match="/produit">
		<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
		<div class="box-left">
			<xsl:call-template name="galerie-fiche-detail"/>
			
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
						    icon: '/extension/ayaline/design/ayaline/images/picto-hotel.png',
							title:"]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$intitule"/><xsl:with-param name="replace" select="$quot"/><xsl:with-param name="by" select="'\&quot;'"/></xsl:call-template><![CDATA["
						});
				  	}
				]]>
			</script>
			<div class="map">
				<div id="mapContainer" style="width:325px;height:220px;margin-bottom: 5px;"><![CDATA[ ]]></div>
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
						document.oswidget = new OsFG("OSRechercheDetail","22357-1621","fr");
						document.oswidget.AliasTerritoire("otsablesolonne");
						document.oswidget.ListeIdFournisseur("]]><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280003']/valModalite"/><![CDATA[");
						document.oswidget.Affiche();
					});
				]]>
				</script>
				<div id="OSRechercheDetail"><![CDATA[ ]]></div>
			</xsl:if>
			<br />
			
			<!-- div style="float:left;margin-top:20px;">
				<img alt="" style="float:right;margin-left:20px"><xsl:attribute name="src"><xsl:value-of select="partenaire/logoPartenaire"/></xsl:attribute></img><xsl:value-of select="$termeInformationProposeePar"/>&amp;nbsp;:<br/><strong><xsl:if test="string-length(partenaire/webPartenaire) &gt; 0"><a target="_blank"><xsl:attribute name="href"><xsl:value-of select="partenaire/webPartenaire"/></xsl:attribute><xsl:value-of select="partenaire/intPartenaire"/></a></xsl:if><xsl:if test="string-length(partenaire/webPartenaire) = 0"><xsl:value-of select="partenaire/intPartenaire"/></xsl:if></strong>
			</div-->
			
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
		
		<div class="box-right">
			<h2 class="bloc-detail-h2"><xsl:value-of select="$intitule"/></h2>
			<xsl:choose>
				<xsl:when test="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite != ''">
					<img alt="">
						<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$termeCategorie"/> : <xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/></xsl:attribute>
					</img>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/>
				</xsl:otherwise>
			</xsl:choose>
			<p class="clear"><![CDATA[ ]]></p>
			
			<ul class="ss-titre-bis">
				<li><xsl:value-of select="ville/intituleVille"/></li>
				<li class="last"><xsl:value-of select="criteres/critere[@id='851000001']/modalites/modalite[1]/intModalite"/></li>
			</ul>
			
			<p class="ss-titre">
				<xsl:choose>
					<xsl:when test="criteres/critere[@id='851000023']/modalites/modalite[@id='8510000230002']/valModalite">
						<span class="picto">A partir de <span><xsl:value-of select="criteres/critere[@id='851000023']/modalites/modalite[@id='8510000230002']/valModalite"/> &amp;euro;</span></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="criteres/critere[@id='851000020']/modalites/modalite[@id='8510000200002']/valModalite">
							<span class="picto">A partir de <span><xsl:value-of select="criteres/critere[@id='851000020']/modalites/modalite[@id='8510000200002']/valModalite"/> &amp;euro;</span></span>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</p>
			<p class="lien-bas">
				<xsl:call-template name="boutons-reserver-liste"/>				
			</p>
			<p class="clear"><![CDATA[ ]]></p>
			<br />
			
			<ul class="inline">		
				<xsl:if test="criteres/critere[@id='851000010']">
					<li>
						<xsl:for-each select="criteres/critere[@id='851000010']/modalites/modalite">
							<xsl:choose>
								<xsl:when test="logoModalite != ''">
									<img alt="" style="float: none;">
										<xsl:attribute name="src"><xsl:value-of select="logoModalite"/></xsl:attribute>
										<xsl:attribute name="title">Cha&amp;icirc;nes d'h&amp;ocirc;tel : <xsl:value-of select="intModalite"/></xsl:attribute>
									</img>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="intModalite"/><xsl:if test="position() &lt; count(../modalite)">, </xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</li>
				</xsl:if>
				
				<xsl:if test="criteres/critere[@id='851000007']">
					<li>
						<xsl:for-each select="criteres/critere[@id='851000007']/modalites/modalite">
							<xsl:choose>
									<xsl:when test="logoModalite != ''">
										<img alt="">
											<xsl:attribute name="src"><xsl:value-of select="logoModalite"/></xsl:attribute>
											<xsl:attribute name="title">Cha&amp;icirc;nes d'h&amp;ocirc;tel : <xsl:value-of select="intModalite"/></xsl:attribute>
										</img>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="intModalite"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="position() &lt; count(../modalite)">, </xsl:if>
						</xsl:for-each>
					</li>
				</xsl:if>
			</ul>
			
			<p>
				<xsl:if test="adresses/adresse[@type='produit']/ligne1 != ''">
					<xsl:value-of select="adresses/adresse[@type='produit']/ligne1"/>
					<xsl:if test="adresses/adresse[@type='produit']/ligne2 != ''">
						<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne2"/>
						<xsl:if test="adresses/adresse[@type='produit']/ligne3 != ''">
							<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne3"/>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<xsl:if test="adresses/adresse[@type='produit']/cp != ''">
					<br /><xsl:value-of select="adresses/adresse[@type='produit']/cp"/>
				</xsl:if>
				<xsl:if test="adresses/adresse[@type='produit']/commune != ''">
					&amp;nbsp;<xsl:value-of select="adresses/adresse[@type='produit']/commune"/>
				</xsl:if>
				<xsl:if test="adresses/adresse[@type='produit']/paysMonde != ''">
					<br /><xsl:value-of select="adresses/adresse[@type='produit']/paysMonde"/>
				</xsl:if>
			</p>
			<xsl:if test="adresses/adresse[@type='produit']/tel1 != ''">
				<div>T&amp;eacute;l : <xsl:value-of select="adresses/adresse[@type='produit']/tel1"/></div>
				<xsl:if test="adresses/adresse[@type='produit']/tel2 != ''">
					<div>Autre t&amp;eacute; : <xsl:value-of select="adresses/adresse[@type='produit']/tel2"/></div>
				</xsl:if>
			</xsl:if>
			<xsl:if test="adresses/adresse[@type='produit']/fax != ''">
				<div>Fax : <xsl:value-of select="adresses/adresse[@type='produit']/fax"/></div>
			</xsl:if>
			<xsl:if test="adresses/adresse[@type='produit']/email != ''">
				<div>Email : <a><xsl:attribute name="href">mailto:<xsl:value-of select="adresses/adresse[@type='produit']/email"/></xsl:attribute>
								<xsl:value-of select="adresses/adresse[@type='produit']/email"/></a>
				</div>
			</xsl:if>
			<xsl:if test="adresses/adresse[@type='produit']/web != ''">
				<div>Site web : <a><xsl:attribute name="href"><xsl:value-of select="adresses/adresse[@type='produit']/web"/></xsl:attribute>
									<xsl:value-of select="adresses/adresse[@type='produit']/web"/></a>
				</div>
			</xsl:if>
			<br />


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
					<li><a href="#onglet-tarifs"><span>Tarifs</span></a></li>
					<li><a href="#onglet-caracteristiques"><span>Caract&amp;eacute;ristiques</span></a></li>
					<li style="background-color: #7AD6E1 !important;"><a href="#onglet-avis"><span>Avis</span></a></li>
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
						</p>
					</xsl:if>
					
					<xsl:call-template name="periodes-ouverture"/>
					<![CDATA[ ]]>
				</div>
				
				<div id="onglet-tarifs">
					<table cellspacing="0" width="100%">
						<xsl:for-each select="criteres/critere[@id='851000020' or @id='851000021' or @id='851000022' or @id='851000023' or @id='851000024' or @id='851000025' or @id='851000026' or @id='851000027']">
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
							<!-- Les criteres suivants sont retires pour ne pas etre repetes - etoile 851000005, type : 851000001, prix1 851000020, prix2 851000021, prix3 851000022, prix4 851000023, prix5 851000024, prix6 851000025, prix7 851000026, prix8 851000027, chaine 851000010, label 851000007 -->
							<xsl:for-each select="criteres/critere[($modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0) and (@id != '851000005') and (@id != '851000001') and (@id != '851000020') and (@id != '851000021') and (@id != '851000022') and (@id != '851000023') and (@id != '851000024') and (@id != '851000025') and (@id != '851000026') and (@id != '851000027') and (@id != '851000010') and (@id != '851000007')]">
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
								Aucun avis pour le moment.<br />
								Soyez le premier : <a target="_blank" href="http://www.tripadvisor.fr/Tourism-g196666-Les_Sables_d_Olonne_Vendee_Pays_de_la_Loire-Vacations.html">Votre avis</a>
							</p>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</div>
		</div>
		<p class="clear"><![CDATA[ ]]></p>
		<p class="space"><![CDATA[ ]]></p>
		
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
		
		<p class="clear"><![CDATA[ ]]></p>
	</xsl:template>
</xsl:stylesheet>
