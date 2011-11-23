<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="espace" select="' '"/>
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_4.xsl"/>

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
				$( ".accordion" ).accordion({
					autoHeight: false
				});
				$(".accordion").bind('accordionchange', function(event, ui) {
					if (ui.newContent.hasClass('tab-gmaps')) {
						if (firstGmapsInit) {
							initialize();
							if (navigator.geolocation) {
								navigator.geolocation.getCurrentPosition(function(position) {
									pos = position.coords.latitude+' '+position.coords.longitude;
									getDirections(']]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite"/><![CDATA[ ]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite"/><![CDATA[');
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
		<div class="accordion">
			<h3><a href="#">Description</a></h3>
			<div>
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
			
			<h3><a href="#">Carte/Itin&amp;eacute;raires</a></h3>
			<div class="tab-gmaps">
				<div class="map-js-container"><![CDATA[ ]]></div>
				<div class="map-container" style="width:425px;height:300px;"><![CDATA[ ]]></div>
			</div>
			
			<h3><a href="#">Photos</a></h3>
			<div>
				<xsl:for-each select="newPhotos/newPhoto">
					<a target="_blank">
						<xsl:attribute name="rel"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/><xsl:value-of select="."/></xsl:attribute>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=60&amp;amp;mw=1</xsl:attribute>
						</img>
					</a>
				</xsl:for-each>
				<![CDATA[ ]]>
			</div>
			
			<h3><a href="#">Avis</a></h3>
			<div class="tripadvisor">
				<xsl:choose><xsl:when test="count(liensMultimedia/lienMultimedia[@type='image']) &gt; 0"><xsl:for-each select="liensMultimedia/lienMultimedia[@type='image' and string-length(codeHtmlLienMultimedia) &gt; 0 and position() = 3]"><div><xsl:call-template name="string-replace-all"><xsl:with-param name="text"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="codeHtmlLienMultimedia"/><xsl:with-param name="replace" select="'_dw_entity__lt__'"/><xsl:with-param name="by"><![CDATA[<]]></xsl:with-param></xsl:call-template></xsl:with-param><xsl:with-param name="replace" select="'_dw_entity__gt__'"/><xsl:with-param name="by"><![CDATA[>]]></xsl:with-param></xsl:call-template></div></xsl:for-each></xsl:when><xsl:otherwise><p>Aucun avis pour le moment.<br />Soyez le premier : <a target="_blank" href="http://www.tripadvisor.fr/Tourism-g196666-Les_Sables_d_Olonne_Vendee_Pays_de_la_Loire-Vacations.html">Votre avis</a></p></xsl:otherwise></xsl:choose>
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
