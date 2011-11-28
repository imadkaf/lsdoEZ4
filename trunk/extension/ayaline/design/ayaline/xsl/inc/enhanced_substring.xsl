<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="enhanced-substring">
		<xsl:param name="text"/>
		<xsl:param name="currentSize"/>
		<xsl:param name="totalSize"/>
		<xsl:param name="delimiter"/>
		<xsl:choose>
			<xsl:when test="($currentSize + string-length(substring-before($text, $delimiter)) + 1) &lt; $totalSize">
				<xsl:value-of select="substring-before($text, $delimiter)"/>
				<xsl:value-of select="$delimiter"/>
				<xsl:call-template name="enhanced-substring">
					<xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
					<xsl:with-param name="currentSize" select="$currentSize + string-length(substring-before($text, $delimiter)) + 1"/>
					<xsl:with-param name="totalSize" select="$totalSize"/>
					<xsl:with-param name="delimiter" select="$delimiter"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
