<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="rendu-adresse">
		<p style="padding: 0px 0px 5px 0px;">
			<xsl:if test="string-length(concat(civilite, prenom, nom)) &gt; 0">
				<xsl:if test="string-length(civilite) &gt; 0"><xsl:value-of select="civilite"/>&amp;nbsp;</xsl:if><xsl:if test="string-length(prenom) &gt; 0"><xsl:value-of select="prenom"/>&amp;nbsp;</xsl:if><xsl:value-of select="nom"/><br/>
			</xsl:if>
			<xsl:if test="string-length(ligne1) &gt; 0">
				<xsl:value-of select="ligne1"/><br/>
			</xsl:if>
			<xsl:if test="string-length(ligne2) &gt; 0">
				<xsl:value-of select="ligne2"/><br/>
			</xsl:if>
			<xsl:if test="string-length(ligne3) &gt; 0">
				<xsl:value-of select="ligne3"/><br/>
			</xsl:if>
			<xsl:if test="string-length(concat(cp, commune)) &gt; 0">
				<xsl:if test="string-length(cp) &gt; 0"><xsl:value-of select="cp"/>&amp;nbsp;</xsl:if><xsl:value-of select="commune"/><br/>
			</xsl:if>
			<xsl:if test="string-length(paysMonde) &gt; 0">
				<xsl:value-of select="paysMonde"/><br/>
			</xsl:if>
			<xsl:if test="string-length(tel1) &gt; 0">
				<xsl:value-of select="$termeTelephone"/>&amp;nbsp;:&amp;nbsp;<xsl:value-of select="tel1"/><br/>
			</xsl:if>
			<xsl:if test="string-length(fax) &gt; 0">
				<xsl:value-of select="$termeFax"/>&amp;nbsp;:&amp;nbsp;<xsl:value-of select="fax"/><br/>
			</xsl:if>
			<xsl:if test="string-length(email) &gt; 0">
				<a>
					<xsl:attribute name="href">mailto:<xsl:value-of select="email"/></xsl:attribute>
					<xsl:value-of select="email"/>
				</a>
				<br/>
			</xsl:if>
			<xsl:if test="string-length(web) &gt; 0">
				<a target="_blank">
					<xsl:attribute name="href"><xsl:value-of select="web"/></xsl:attribute>
					<xsl:value-of select="web"/>
				</a>
				<br/>
			</xsl:if>
		</p>
	</xsl:template>

</xsl:stylesheet>