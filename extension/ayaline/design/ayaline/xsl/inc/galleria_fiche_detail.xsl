<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="galerie-fiche-detail">
		<xsl:if test="count(newPhotos/newPhoto) &gt; 0">
			<div id="galleria" class="galerie-fiche">
				<xsl:for-each select="newPhotos/newPhoto">
					<a>
						<xsl:attribute name="rel"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=306&amp;amp;mw=1</xsl:attribute>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=60&amp;amp;mw=1</xsl:attribute>
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
						lightbox: true,
						debug: false // debug is now off for deployment
					});
				]]>
			</script>
			<div class="clear"><![CDATA[&nbsp;]]></div><br />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
