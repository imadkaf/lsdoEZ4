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
			<!-- Basique -->
			<xsl:for-each select="resultats/details/detail">
				<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitMiseEnAvantUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(intitule, concat('/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/></xsl:variable>
				<a>
					<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
					<div class="push">
						<div class="arrow">&amp;nbsp;&amp;nbsp;&amp;nbsp;</div>
						
						<div class="text">
							<span>suggestion</span>
							<span class="title"><xsl:value-of select="intitule"/></span>
			  				<span class="description"><xsl:value-of select="ville/intituleVille"/></span>
						</div>
					</div>
				</a>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
