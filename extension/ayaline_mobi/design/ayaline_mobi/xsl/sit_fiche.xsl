<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="espace" select="' '"/>
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_1.xsl"/>

	<xsl:template match="/produit">
		<div class="titre-fiche">
			<h2><xsl:value-of select="intitule"/></h2>
			<p class="clear"><![CDATA[ ]]></p>
		</div>
		
		<div class="apercu-fiche">
			<img alt="">
				<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
					<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=285</xsl:attribute>
				</xsl:if>
				<xsl:if test="count(newPhotos/newPhoto) = 0">
					<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
					<xsl:attribute name="width">285px</xsl:attribute>
				</xsl:if>
			</img>
			
			<p class="sous-titre" style="margin: 5px 0px 5px 0px;">
				<span><xsl:value-of select="ville/intituleVille"/></span>
			</p>
			
			<p class="adresse">
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
			<br />
			
			<p class="tel">
				<xsl:if test="adresses/adresse[@type='produit']/tel1 != ''">
					<b>T&amp;eacute;l : </b><xsl:value-of select="adresses/adresse[@type='produit']/tel1"/><br />
					<xsl:if test="adresses/adresse[@type='produit']/tel2 != ''">
						<b>Autre t&amp;eacute; : </b><xsl:value-of select="adresses/adresse[@type='produit']/tel2"/>
					</xsl:if>
				</xsl:if>
			</p>
			
			<xsl:if test="adresses/adresse[@type='produit']/tel1 != ''">
				<a class="telephone">
					<xsl:attribute name="href">tel:<xsl:value-of select="adresses/adresse[@type='produit']/tel1"/></xsl:attribute>
					<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			
			<xsl:if test="adresses/adresse[@type='produit']/email != ''">
				<a class="mail">
					<xsl:attribute name="href">mailto:<xsl:value-of select="adresses/adresse[@type='produit']/email"/></xsl:attribute>
					<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			<p class="clear"><![CDATA[ ]]></p>
		</div>
		
		<!-- Appel des definitions des 'ui' de la bibliotheque jquery -->
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"><![CDATA[ ]]></script>
		<script type="text/javascript">
			<![CDATA[
			var firstGmapsInit = true;
			$(function() {
				$( "#accordion" ).accordion({
					autoHeight: false,
					navigation: true
				});
				$("#accordion").bind('accordionchange', function(event, ui) {
					if (ui.newContent.attr('id') == 'tab-gmaps') {
						if (firstGmapsInit) {
							initialize();
							if (navigator.geolocation) {
								navigator.geolocation.getCurrentPosition(function(position) {
									pos = position.coords.latitude+' '+position.coords.longitude;
									getDirections();
								});
							}
							else {
								alert("Votre navigateur ne prend pas en compte la geolocalisation HTML5");
							}
							firstGmapsInit = false;
						}
					}
				});
			});
			]]>
		</script>
		<div id="accordion">
			<h3><a href="#">Description</a></h3>
			<div>
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
			
			<h3><a href="#">Carte/Itin&amp;eacute;raires</a></h3>
			<div id="tab-gmaps">
				<div id="map-js-container"><![CDATA[ ]]></div>
				<div id="map-container" style="width:425px;height:300px;"><![CDATA[ ]]></div>
				<script type="text/javascript">	
					<![CDATA[
						var pos;
						var map;
						var dirService;
						var dirRenderer;
						
						function initialize() {
							document.getElementById('map-js-container').innerHTML = '<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true&amp;key=ABQIAAAAPzlBh0JjFUPqZKi3n0L3LxRNhXKcoHc6ILCDtHOsJEw_kWBWgBR1kXeQdewQ9aUBq3FH6LbXaDfhmw"></' + 'script>';
							var latlng = new google.maps.LatLng(46.5, -1.7833);
							
							var myOptions = {
							  zoom: 13,
							  center: latlng,
							  mapTypeId: google.maps.MapTypeId.ROADMAP
							};
							
							map = new google.maps.Map(document.getElementById("map-container"), myOptions);
							
							dirService = new google.maps.DirectionsService();
							dirRenderer = new google.maps.DirectionsRenderer();
						}
						
						function showDirections(dirResult, dirStatus) {
							if (dirStatus != google.maps.DirectionsStatus.OK) {
							  alert('Aucun itineraire trouve : ' + dirStatus);
							  return;
							}
			
							// Show directions
							dirRenderer.setMap(map);
							dirRenderer.setDirections(dirResult);
						}
						
						function getDirections() {
							var dirRequest = {
							  origin: pos,
							  destination: ']]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite"/><![CDATA[ ]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite"/><![CDATA[',
							  travelMode: google.maps.DirectionsTravelMode.DRIVING
							};
							
							dirService.route(dirRequest, showDirections);
						}
					]]>
				</script>
			</div>
			
			<h3><a href="#">Photos</a></h3>
			<div>
				<xsl:for-each select="newPhotos/newPhoto">
					<a>
						<xsl:attribute name="rel"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=306&amp;amp;mw=1</xsl:attribute>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=60&amp;amp;mw=1</xsl:attribute>
						</img>
					</a>
				</xsl:for-each>
				<![CDATA[ ]]>
			</div>
		</div>
		
		<xsl:if test="string-length($lienPrecedent) &gt; 0">
			<div class="result-suiv">
				<a class="retour">
					<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
					&amp;lt;&amp;nbsp;<xsl:value-of select="$termeRetourListe"/>
				</a>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
