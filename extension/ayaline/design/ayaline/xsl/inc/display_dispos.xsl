<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="display-dispos">
		<xsl:param name="disposChaine"/>
		<xsl:param name="index"/>
		<xsl:param name="mois"/>
		<xsl:choose>
			<xsl:when test="$index &lt;= string-length($disposChaine)">
				<div>
					<xsl:attribute name="style">padding:2px;min-width:16px;font-size:90%;color:white;;text-align:center;border-right:1px solid white;float:left;background-color:#<xsl:choose><xsl:when test="substring($disposChaine, $index, 1) = 'I'">AAAAAA</xsl:when><xsl:when test="substring($disposChaine, $index, 1) = 'L'">CC0000</xsl:when><xsl:otherwise>00AA00</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="$index"/><xsl:value-of select="$espace"/><xsl:value-of select="$mois"/><xsl:value-of select="$espace"/><xsl:value-of select="$anneeCourante"/><![CDATA[ : ]]><xsl:choose><xsl:when test="substring($disposChaine, $index, 1) = 'I'"><xsl:value-of select="$termeFerme"/></xsl:when><xsl:when test="substring($disposChaine, $index, 1) = 'L'"><xsl:value-of select="$termeComplet"/></xsl:when><xsl:otherwise><xsl:value-of select="$termeDisponible"/></xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:value-of select="$index"/>
				</div>
				<xsl:call-template name="display-dispos">
					<xsl:with-param name="disposChaine" select="$disposChaine"/>
					<xsl:with-param name="index" select="$index + 1"/>
					<xsl:with-param name="mois" select="$mois"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>