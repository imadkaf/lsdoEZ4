<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="display-villes">
		<xsl:param name="villesChaine"/>
		<xsl:variable name="ville"><xsl:if test="contains($villesChaine, '#')"><xsl:value-of select="substring-before($villesChaine, '#')" /></xsl:if><xsl:if test="not(contains($villesChaine, '#'))"><xsl:value-of select="$villesChaine" /></xsl:if></xsl:variable>
		<option>
			<xsl:attribute name="value"><xsl:value-of select="substring-before($ville, '|')"/></xsl:attribute>
			<xsl:attribute name="onchange">_gaq.push(['_trackEvent', 'Recherche-Avancee', 'Commune', '<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$ville"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by"><![CDATA[-]]></xsl:with-param></xsl:call-template>']);</xsl:attribute>
			<xsl:if test="contains(concat('|', $codesInsee, '|'), concat('|', substring-before($ville, '|'), '|'))">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="substring-after($ville, '|')" />
		</option>
		<xsl:choose>
			<xsl:when test="contains($villesChaine, '#')">
				<xsl:call-template name="display-villes">
					<xsl:with-param name="villesChaine" select="substring-after($villesChaine, '#')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
