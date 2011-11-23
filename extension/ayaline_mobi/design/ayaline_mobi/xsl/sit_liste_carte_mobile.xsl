<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="amp">&amp;</xsl:variable>
	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/enhanced_substring.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">		
			<script type="text/javascript">
				<![CDATA[
					//Variable temp
					var tempoMarker;
					
					//Tableau
					var latlng = new Array();
					
					var markers = [];
					
					var infobulles = [];
				]]>
				<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)]">
					<xsl:if test="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite != '' and criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite != ''">
						<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
						<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
						<![CDATA[
							tempoMarker = new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite"/><![CDATA[);
							latlng.push(tempoMarker);
						
							var contentString = '<div class="moninfobulle">'+
									'<h3 class="titre-defaut">]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><![CDATA[</h3>'+
									']]><xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
											<img class="float-g photo" alt="">
												<xsl:variable name="photoInfobulle"><xsl:value-of select="newPhotos/newPhoto"/></xsl:variable>
												<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$photoInfobulle"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="concat('\', $apos)"/></xsl:call-template>&amp;amp;w=120</xsl:attribute>
											</img>
										</xsl:if>
										<xsl:if test="count(newPhotos/newPhoto) = 0">
											<img class="float-g photo" alt="" style="max-height: 100px; width: 120px;">
												<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
											</img>
										</xsl:if><![CDATA['+
									'<span class="float-d">]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="ville/intituleVille"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><![CDATA[</span><br />'+
									']]><xsl:variable name="commentaire"><xsl:if test="$langue = 'en'"><xsl:value-of select="commentaires/commentaire2"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="commentaires/commentaire1"/></xsl:if></xsl:variable><xsl:if test="string-length($commentaire) &gt; 0">
											<xsl:variable name="commentaireNettoye">
												<xsl:call-template name="string-replace-all">
													<xsl:with-param name="text" select="$commentaire"/>
													<xsl:with-param name="replace" select="'\n'"/>
													<xsl:with-param name="by" select="' '"/>
												</xsl:call-template>
											</xsl:variable>
											<xsl:variable name="commentaireNettoyeCoupe">
												<xsl:if test="string-length($commentaireNettoye) &lt;= 100">
													<xsl:value-of select="$commentaireNettoye"/>
												</xsl:if>
												<xsl:if test="string-length($commentaireNettoye) &gt; 100">
													<xsl:call-template name="enhanced-substring">
														<xsl:with-param name="text" select="$commentaireNettoye"/>
														<xsl:with-param name="currentSize" select="0"/>
														<xsl:with-param name="totalSize" select="100"/>
														<xsl:with-param name="delimiter" select="' '"/>
													</xsl:call-template>
												</xsl:if>
											</xsl:variable>
											<p class="commentaire">
												<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$commentaireNettoyeCoupe"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><xsl:if test="string-length($commentaireNettoye) &gt; 100">&amp;hellip;</xsl:if>
											</p>
										</xsl:if><![CDATA[<div class="clear"></div>'+
									'<p class="lien">]]>
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
							
							infobulles.push(infowindow);

							var marker = new google.maps.Marker({
								position: new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='851000011']/modalites/modalite[@id='8510000110002']/valModalite"/><![CDATA[),
								map: map,
								title:"]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$intitule"/><xsl:with-param name="replace" select="$quot"/><xsl:with-param name="by" select="'\&quot;'"/></xsl:call-template><![CDATA["
							});
							
							markers.push(marker);
						]]>
					</xsl:if>
				</xsl:for-each>
			</script>
			<div class="map-js-container"><![CDATA[ ]]></div>
			<div class="mapContainerListe" style="width:100%;height:300px;border-bottom: 1px solid #C9BDB2;"><![CDATA[ ]]></div>
			<script type="text/javascript">
				<![CDATA[
					$(document).ready( function () {
						var firstGmapsInit = true;
						if (firstGmapsInit) {
							setTimeout(function () {initializeListe(latlng, markers, infobulles)}, 100);
							firstGmapsInit = false;
						}
					});
				]]>
			</script>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
