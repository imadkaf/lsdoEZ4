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

	<xsl:variable name="nbPagesMax" select="5"/>
	<xsl:include href="inc/pagination.xsl"/>

	<xsl:include href="inc/periodes_ouverture.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<ul class="liste-hotel-contenu">
				<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)]">
					<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('%/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img alt="" class="float-gauche">
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=115</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(newPhotos/newPhoto) = 0">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
									<xsl:attribute name="width">115px</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						
						<h3>
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								<xsl:value-of select="$intitule"/>
							</a>
						</h3>
						
						<div class="sous-titre">
							<span><xsl:value-of select="ville/intituleVille"/></span><br/>
							<xsl:call-template name="periodes-ouverture"/>
						</div>
						
						<a class="float-droite-picto">
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
						</a>
						
						<p class="clear"><![CDATA[ ]]></p>
					</li>
				</xsl:for-each>
			</ul>
			
			<div class="result-suiv">
				<xsl:call-template name="toute-pagination"/><![CDATA[ ]]>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
