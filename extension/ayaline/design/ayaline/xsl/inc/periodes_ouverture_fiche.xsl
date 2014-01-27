<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="split">
		<xsl:param name="string"/>
		<xsl:choose>
			<xsl:when test="contains($string,',')">
				<xsl:value-of select="substring-before($string,',')"/><xsl:if test="contains(substring-after($string,','),',')">,<xsl:value-of select="$espace"/></xsl:if><xsl:if test="not(contains(substring-after($string,','),','))"><xsl:value-of select="$espace"/><xsl:value-of select="$termeEt"/><xsl:value-of select="$espace"/></xsl:if>
				<xsl:call-template name="split">
					<xsl:with-param name="string">
						<xsl:value-of select="substring-after($string,',')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

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
							<xsl:attribute name="style">background:url('<xsl:value-of select="$cheminImages"/>picto_calendrier.png') no-repeat 0 0;padding:2px 0 2px 23px</xsl:attribute>
							<xsl:if test="periodeOuvertureDebut = periodeOuvertureFin">
								<strong><xsl:value-of select="$termeLe"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(periodeOuvertureDebut, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 1, 4)"/></strong>
							</xsl:if>
							<xsl:if test="periodeOuvertureDebut != periodeOuvertureFin">
								<strong><xsl:if test="string-length(periodeOuvertureDebut) &gt; 0"><xsl:value-of select="$termeDu"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(periodeOuvertureDebut, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureDebut, 1, 4)"/></xsl:if><xsl:if test="string-length(periodeOuvertureFin) &gt; 0"><xsl:value-of select="$espace"/><xsl:value-of select="$termeAu"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(periodeOuvertureFin, 9, 2)"/>/<xsl:value-of select="substring(periodeOuvertureFin, 6, 2)"/>/<xsl:value-of select="substring(periodeOuvertureFin, 1, 4)"/></xsl:if></strong>
							</xsl:if>
							
							<xsl:if test="count(horairesOuvertures/horaireOuverture) &gt; 0">
								<br />
								<xsl:for-each select="horairesOuvertures/horaireOuverture">
                                                                        <xsl:if test="string-length(horaireJoursSemaine) &gt; 0">
                                                                            <xsl:value-of select="$termeLe"/><xsl:value-of select="$espace"/>
                                                                            <xsl:call-template name="split">
                                                                                <xsl:with-param name="string">
                                                                                    <xsl:value-of select="horaireJoursSemaine"/>
                                                                                </xsl:with-param>
                                                                            </xsl:call-template>
									</xsl:if>
									<xsl:if test="string-length(horaireOuvertureDebut) &gt; 0 and horaireOuvertureDebut != horaireOuvertureFin ">
										<xsl:value-of select="$espace"/><xsl:value-of select="$termeDe"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(horaireOuvertureDebut, 1, 5)"/>
									</xsl:if>
									<xsl:if test="string-length(horaireOuvertureDebut) &gt; 0 and horaireOuvertureDebut = horaireOuvertureFin">
										<xsl:value-of select="$espace"/><xsl:value-of select="$termeA"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(horaireOuvertureDebut, 1, 5)"/>
									</xsl:if>
									<xsl:if test="string-length(horaireOuvertureFin) &gt; 0 and horaireOuvertureDebut != horaireOuvertureFin">
										<xsl:value-of select="$espace"/><xsl:value-of select="$termeA"/><xsl:value-of select="$espace"/><xsl:value-of select="substring(horaireOuvertureFin, 1, 5)"/>
									</xsl:if>
									<xsl:if test="position() != last()">
										<br />
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
