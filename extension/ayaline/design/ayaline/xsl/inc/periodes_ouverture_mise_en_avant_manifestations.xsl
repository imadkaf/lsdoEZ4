<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="periodes-ouverture">
		<xsl:if test="ouvertureAnnee/@value = '1'">
			<div>
				<xsl:attribute name="style">background:url('<xsl:value-of select="$cheminImages"/>picto_calendrier.png') no-repeat 0 50%;padding:3px 3px 3px 23px;</xsl:attribute>
				<strong><xsl:value-of select="$termeOuvertTouteAnnee"/></strong>
			</div>
		</xsl:if>
		<xsl:if test="count(periodesOuvertures/periodeOuverture) &gt; 0">
			<div>
				<div>
					<xsl:for-each select="periodesOuvertures/periodeOuverture[position() = last()]">
						<div>
							<xsl:attribute name="style">margin:5px 0 0px 0px</xsl:attribute>
							<xsl:if test="periodeOuvertureDebut = periodeOuvertureFin">
								<xsl:value-of select="$termeLe"/><xsl:value-of select="$espace"/><strong><xsl:value-of select="substring(periodeOuvertureDebut, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 1, 4)"/></strong>
							</xsl:if>
							<xsl:if test="periodeOuvertureDebut != periodeOuvertureFin">
								<xsl:if test="string-length(periodeOuvertureDebut) &gt; 0"><xsl:value-of select="$termeDu"/><xsl:value-of select="$espace"/><strong><xsl:value-of select="substring(periodeOuvertureDebut, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 1, 4)"/></strong></xsl:if><xsl:if test="string-length(periodeOuvertureFin) &gt; 0"><xsl:value-of select="$espace"/><xsl:value-of select="$termeAu"/><xsl:value-of select="$espace"/><strong style="color:black"><xsl:value-of select="substring(periodeOuvertureFin, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureFin, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureFin, 1, 4)"/></strong></xsl:if>
							</xsl:if>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
