<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="galerie-fiche-detail">
		<xsl:param name="titrefiche"/>
		<xsl:param name="idP"/>
		<xsl:if test="count(newPhotos/newPhoto) &gt; 0">
			<div id="galleria" class="galerie-fiche">
			<xsl:value-of select="$titrefiche"/>
				<xsl:for-each select="newPhotos/newPhoto">
					<a>
						<xsl:attribute name="rel"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="$rootSitUrl"/>Image&amp;idP=<xsl:value-of select="$idP"/>&amp;no=<xsl:value-of select="position()"/>&amp;w=306&amp;mw=1</xsl:attribute>
						<img>
							<xsl:attribute name="alt"><xsl:value-of select="$titrefiche"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="$titrefiche"/><xsl:if test="@credits"> - <xsl:value-of select="@credits"/> == <xsl:value-of select="$idP"/></xsl:if></xsl:attribute>
							<!--xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=60&amp;amp;mw=1</xsl:attribute-->
							<xsl:attribute name="src"><xsl:value-of select="$rootSitUrl"/>Image&amp;idP=<xsl:value-of select="$idP"/>&amp;no=<xsl:value-of select="position()"/>&amp;w=60&amp;mw=1</xsl:attribute>
						</img>
					</a>
				</xsl:for-each>
			</div>
			<script type="text/javascript" src="/extension/ayaline_gallery/design/standard/javascript/galleria/themes/classic/galleria.classic.min.js"><![CDATA[&nbsp;]]></script>
			<script type="text/javascript">
				<![CDATA[
					//Load the classic theme
					//Galleria.loadTheme("/extension/ayaline_gallery/design/standard/javascript/galleria/themes/classic/galleria.classic.min.js");

					// Initialize Galleria
					$('#galleria').galleria({
						autoplay: 5000,
						height: 300,
						lightbox: true,
						debug: false // debug is now off for deployment
					});
				]]>
			</script>
			<div class="clear"><![CDATA[&nbsp;]]></div><br />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
