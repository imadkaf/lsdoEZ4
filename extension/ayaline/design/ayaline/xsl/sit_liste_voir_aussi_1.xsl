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

	<xsl:include href="inc/periodes_ouverture.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<div class="bloc-type">
				<h2 class="bloc-liste-h2-cote"><xsl:value-of select="$termeVoirAussi"/></h2>
				<p class="clear"><![CDATA[ ]]></p>
				
				<ul class="list-right liste-voir-aussi">		
					<xsl:for-each select="resultats/details/detail[@id != $idFicheEnCours]">
						<xsl:if test="position() &lt;= 5">
							<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
							<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
							<li>
								<a>
									<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
									<img alt="">
										<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
											<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=85</xsl:attribute>
										</xsl:if>
										<xsl:if test="count(newPhotos/newPhoto) = 0">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
											<xsl:attribute name="style">width:85px</xsl:attribute>
										</xsl:if>
									</img>
								</a>
								
								<div style="margin-left: 100px;">
									<h3><a><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><xsl:value-of select="$intitule"/><![CDATA[ ]]></a></h3>
									<xsl:if test="criteres/critere[@id='851000005']">
										<p class="bloc-stars">
											<xsl:choose>
												<xsl:when test="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite != ''">
													<img alt="" style="float:none;padding:0px;">
														<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
														<xsl:attribute name="title">Cat&amp;eacute;gorie : <xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/></xsl:attribute>
													</img>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/>
												</xsl:otherwise>
											</xsl:choose>
										</p>
									</xsl:if>
									<p style="margin-bottom: 10px;"><![CDATA[ ]]></p>
									
									<a class="lien-plus-infos"><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><![CDATA[ ]]></a>
								</div>
							</li>
						</xsl:if>
					</xsl:for-each>
					<![CDATA[ ]]>
				</ul>

				<p class="lien-bas">
					<a class="type0"><xsl:attribute name="href"><xsl:value-of select="$sitListeLien" /></xsl:attribute><xsl:value-of select="$termeToutesFichesMemeCategorie"/></a>
				</p>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
