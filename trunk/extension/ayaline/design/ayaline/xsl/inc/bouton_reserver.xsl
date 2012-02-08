<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="boutons-reserver-liste">
		<xsl:if test="string-length(criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280002']/valModalite) &gt; 0">
			<a class="reserver" target="_blank">
				<xsl:attribute name="href"><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280002']/valModalite"/></xsl:attribute>
				<xsl:attribute name="onclick">_gaq.push(['_trackEvent', 'Reserver', <![CDATA[categorie]]>, '<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by"><![CDATA[-]]></xsl:with-param></xsl:call-template>']);</xsl:attribute>
				<xsl:value-of select="$termeReserver"/>
			</a>
		</xsl:if>
		<xsl:if test="string-length(criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280004']/valModalite) &gt; 0">
			<a class="dispos" target="_blank">
				<xsl:attribute name="href"><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280004']/valModalite"/></xsl:attribute>
				<xsl:attribute name="onclick">_gaq.push(['_trackEvent', 'Dispo', <![CDATA[categorie]]>, '<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'\&quot;'"/></xsl:call-template>']);</xsl:attribute>
				<xsl:value-of select="$termeDispos"/>
			</a>
				
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
