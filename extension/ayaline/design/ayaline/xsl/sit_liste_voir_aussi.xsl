<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="amp">&amp;</xsl:variable>
	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/enhanced_substring.xsl"/>

	<xsl:include href="inc/periodes_ouverture.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<div class="bloc-type">
				<h2 class="bloc-liste-h2-cote"><xsl:value-of select="$termeVoirAussi"/></h2>
				<p class="clear"><![CDATA[ ]]></p>
				
				<ul class="list-right liste-voir-aussi">
					<xsl:for-each select="resultats/details/detail[@id != $idFicheEnCours]">
						<xsl:if test="position() &lt;= 5">
							<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
							<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('%/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
							<li>
								<a>
									<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
									<img>
										<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
											<xsl:if test="newPhotos/newPhoto[@nom] or newPhotos/newPhoto[@legende]">
												<xsl:attribute name="alt"><xsl:if test="newPhotos/newPhoto[@nom]"><xsl:value-of select="newPhotos/newPhoto/@nom"/> - </xsl:if><xsl:if test="newPhotos/newPhoto[@legende]"><xsl:value-of select="newPhotos/newPhoto/@legende"/></xsl:if></xsl:attribute>
												<xsl:attribute name="title"><xsl:if test="newPhotos/newPhoto[@nom]"><xsl:value-of select="newPhotos/newPhoto/@nom"/> - </xsl:if><xsl:if test="newPhotos/newPhoto[@legende]"><xsl:value-of select="newPhotos/newPhoto/@legende"/></xsl:if></xsl:attribute>
											</xsl:if>
											<xsl:if test="not(newPhotos/newPhoto[@nom]) and not(newPhotos/newPhoto[@legende])">
												<xsl:attribute name="alt"><xsl:value-of select="$intitule"/></xsl:attribute>
												<xsl:attribute name="title"><xsl:value-of select="$intitule"/></xsl:attribute>
											</xsl:if>
										
											<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=85</xsl:attribute>
										</xsl:if>
									</img>
								</a>
								
								<div style="margin-left: 100px;">
									<h3><a><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><xsl:attribute name="title"><xsl:value-of select="$intitule"/></xsl:attribute><xsl:value-of select="$intitule"/><![CDATA[ ]]></a></h3>
									
									<p style="margin-bottom: 10px;"><![CDATA[ ]]></p>
									
									<a class="lien-plus-infos"><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><![CDATA[ ]]></a>
								</div>
							</li>
						</xsl:if>
					</xsl:for-each>
					<![CDATA[ ]]>
				</ul>

				<p class="lien-bas">
					<a class="type0"><xsl:attribute name="href"><xsl:value-of select="$sitListeLien" /></xsl:attribute>
					<xsl:value-of select="$termeToutesFichesMemeCategorie"/></a>
				</p>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
