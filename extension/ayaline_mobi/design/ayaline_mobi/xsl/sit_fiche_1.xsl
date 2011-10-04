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
			<xsl:choose>
				<xsl:when test="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite != ''">
					<img alt="">
						<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
						<xsl:attribute name="title">Cat&amp;eacute;gorie : <xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/></xsl:attribute>
					</img>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/>
				</xsl:otherwise>
			</xsl:choose>
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
				<span><xsl:value-of select="ville/intituleVille"/></span>&amp;nbsp;&amp;nbsp;&amp;nbsp;|&amp;nbsp;
				<b><xsl:value-of select="criteres/critere[@id='851000001']/modalites/modalite[1]/intModalite"/></b>
			</p>
			
			<p class="prix" style="margin: 0px 0px 10px 0px;">
				<xsl:choose>
					<xsl:when test="criteres/critere[@id='851000023']/modalites/modalite[@id='8510000230002']/valModalite">
						A partir de <xsl:value-of select="criteres/critere[@id='851000023']/modalites/modalite[@id='8510000230002']/valModalite"/> &amp;euro;
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="criteres/critere[@id='851000020']/modalites/modalite[@id='8510000200002']/valModalite">
							A partir de <xsl:value-of select="criteres/critere[@id='851000020']/modalites/modalite[@id='8510000200002']/valModalite"/> &amp;euro;
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
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
			
			<!--a class="disponibilites">
				<xsl:attribute name="href">#</xsl:attribute>
				<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
			</a-->
			<xsl:if test="string-length(criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280004']/valModalite) &gt; 0">
				<a class="disponibilites">
				<xsl:attribute name="href"><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280004']/valModalite"/></xsl:attribute>
				 <span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			
			<xsl:if test="adresses/adresse[@type='produit']/tel1 != ''">
				<a class="telephone">
					<xsl:attribute name="href">tel:<xsl:value-of select="adresses/adresse[@type='produit']/tel1"/></xsl:attribute>
					<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			
			<xsl:if test="adresses/adresse[@type='produit']/email != ''">
				<a class="mail">
					<xsl:attribute name="href">mailto:<xsl:value-of select="adresses/adresse[@type='produit']/email"/></xsl:attribute>
					<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			<p class="clear"><![CDATA[ ]]></p>
		</div>
		
		<script type="text/javascript">
			<![CDATA[
			var firstGmapsInit = true;
			$(function() {
				$( "#accordion" ).accordion({
					autoHeight: false
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
				<div id="map-container" style="width:auto425px;height:300px;"><![CDATA[ ]]></div>
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
			
			<h3><a href="#">Tarifs</a></h3>
			<div id="tarifs">
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
				</table>
				<![CDATA[ ]]>
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
			
			<h3><a href="#">Avis</a></h3>
			<div id="tripadvisor">
				<!--
				<xsl:choose>
					<xsl:when test="count(liensMultimedia/lienMultimedia[@type='image']) &gt; 0">
						<xsl:for-each select="liensMultimedia/lienMultimedia[@type='image' and string-length(codeHtmlLienMultimedia) &gt; 0 and position() = 3]">
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
				-->
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
