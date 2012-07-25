<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="periodes-ouverture">
		<xsl:if test="ouvertureAnnee/@value = '1'">
			<xsl:value-of select="$termeOuvertTouteAnnee"/>
		</xsl:if>
		<xsl:if test="count(periodesOuvertures/periodeOuverture) &gt; 0">
			<xsl:for-each select="periodesOuvertures/periodeOuverture">
				<xsl:if test="periodeOuvertureDebut = periodeOuvertureFin">
					<xsl:value-of select="$termeLe"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(periodeOuvertureDebut, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 1, 4)"/>
				</xsl:if>
				<xsl:if test="periodeOuvertureDebut != periodeOuvertureFin">
					<xsl:if test="string-length(periodeOuvertureDebut) &gt; 0"><xsl:value-of select="$termeDu"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(periodeOuvertureDebut, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 1, 4)"/></xsl:if><xsl:if test="string-length(periodeOuvertureFin) &gt; 0"><xsl:value-of select="$espace"/><xsl:value-of select="$termeAu"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(periodeOuvertureFin, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureFin, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureFin, 1, 4)"/></xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
