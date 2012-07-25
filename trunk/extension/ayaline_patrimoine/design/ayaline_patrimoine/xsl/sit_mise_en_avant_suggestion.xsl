<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="amp">&amp;</xsl:variable>
	<xsl:variable name="espace" select="' '"/>

	<xsl:template match="/">
		<xsl:if test="count(produit) &gt; 0">
			<xsl:for-each select="produit">
				<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitMiseEnAvantUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(intitule, concat('%/-?_.', $apos, $amp), '       ')), ' ', '-')"/></xsl:variable>
				<img alt="">
					<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
						<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=58</xsl:attribute>
					</xsl:if>
					<xsl:if test="count(newPhotos/newPhoto) = 0">
						<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
					</xsl:if>
				</img>
				<div class="contenu-suggestions">
					<p class="titre"><xsl:value-of select="intitule"/></p>
					<p class="ville"><xsl:value-of select="ville/intituleVille"/>
						<a class="plus-info-suggestions ui-link">
							<xsl:attribute name="href"><xsl:value-of select="$UrlExterne"/><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							Plus d'info
						</a>
					</p>
				</div>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>