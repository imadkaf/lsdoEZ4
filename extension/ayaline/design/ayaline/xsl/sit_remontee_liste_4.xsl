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

	<xsl:include href="inc/periodes_ouverture_mise_en_avant_manifestations.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<!-- Diaporama -->
			<script type="text/javascript">
				$(document).ready(function(){
					$('#bxslider').bxSlider({
						auto: true,
						pause: 5000,
						pager: true
					});
				});
			</script>
			<div class="bxslider remonte_liste">
				<ul id="bxslider">
					<xsl:for-each select="resultats/details/detail">
						<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue = 'de'"><xsl:value-of select="intituleDe"/></xsl:if><xsl:if test="$langue = 'fr'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
						<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitMiseEnAvantUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('%/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/></xsl:variable>
						<li>
							<xsl:attribute name="style"><xsl:if test="position() &lt; count(../detail)"></xsl:if></xsl:attribute>
							<a style="overflow:hidden;"><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
							
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								<img>
									<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
										<xsl:attribute name="alt"><xsl:value-of select="$intitule"/><xsl:if test="newPhotos/newPhoto[@credits]"> - <xsl:value-of select="newPhotos/newPhoto/@credits"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$intitule"/><xsl:if test="newPhotos/newPhoto[@credits]"> - <xsl:value-of select="newPhotos/newPhoto/@credits"/></xsl:if></xsl:attribute>
										<xsl:attribute name="src"><xsl:value-of select="$rootSitUrl"/>Image&amp;amp;idP=<xsl:value-of select="@id"/>&amp;amp;no=1&amp;amp;w=593&amp;amp;mw=1</xsl:attribute>
									</xsl:if>
									<xsl:if test="count(newPhotos/newPhoto) = 0">
										<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
									</xsl:if>
								</img>
							</a>
							<p class="clear"><![CDATA[ ]]></p>
							<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
								<xsl:for-each select="newPhotos/newPhoto[position() = 1]">
									<span style="font-size:11px"><xsl:value-of select="@credits"/><![CDATA[ ]]></span>
								</xsl:for-each>
							</xsl:if>
							<p class="clear"><![CDATA[ ]]></p>
							<xsl:call-template name="periodes-ouverture"/>
							<h3 style="font-size: 20px; padding: 10px 0px 10px 0px;">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="$intitule"/></xsl:attribute>
									<strong><xsl:value-of select="$intitule"/><![CDATA[ ]]></strong>
								</a>
							</h3>
							<!--xsl:variable name="commentaire"><xsl:if test="$langue = 'en'"><xsl:value-of select="commentaires/commentaire2"/></xsl:if><xsl:if test="$langue = 'de'"><xsl:value-of select="commentaires/commentaire3"/></xsl:if><xsl:if test="$langue = 'fr'"><xsl:value-of select="commentaires/commentaire1"/></xsl:if></xsl:variable>
							<xsl:if test="string-length($commentaire) &gt; 0">
								<xsl:variable name="commentaireNettoye">
									<xsl:call-template name="string-replace-all">
										<xsl:with-param name="text" select="$commentaire"/>
										<xsl:with-param name="replace" select="'\n'"/>
										<xsl:with-param name="by" select="' '"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:variable name="commentaireNettoyeCoupe">
									<xsl:if test="string-length($commentaireNettoye) &lt;= 300">
										<xsl:value-of select="$commentaireNettoye"/>
									</xsl:if>
									<xsl:if test="string-length($commentaireNettoye) &gt; 300">
										<xsl:call-template name="enhanced-substring">
											<xsl:with-param name="text" select="$commentaireNettoye"/>
											<xsl:with-param name="currentSize" select="0"/>
											<xsl:with-param name="totalSize" select="300"/>
											<xsl:with-param name="delimiter" select="' '"/>
										</xsl:call-template>
									</xsl:if>
								</xsl:variable>
								<p>
									<xsl:value-of select="$commentaireNettoyeCoupe"/><xsl:if test="string-length($commentaireNettoye) &gt; 300">&amp;hellip;</xsl:if>
									<![CDATA[ ]]>
								</p>
							</xsl:if-->
							<span><xsl:value-of select="ville/intituleVille"/></span>

							<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0]) &gt; 0">
								<ul>
									<xsl:for-each select="criteres/critere">
										<xsl:variable name="idCritere" select="@id"/>
										<xsl:variable name="intituleCritere" select="intCritere"/>
										<xsl:if test="count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 0">
											<li style="background:none;list-style:square;padding-left:0">
												<div style="border-bottom:1px solid #CCCCFF;padding-bottom:3px">
													<xsl:if test="count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 1 or count(modalites/modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) &gt; 0"><xsl:value-of select="$intituleCritere"/>&amp;nbsp;: <xsl:if test="count(modalites/modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(intModalite) &gt; 0]) &gt; 0"><br/></xsl:if></xsl:if>
													<xsl:for-each select="modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]">
														<xsl:if test="string-length(valModalite) = 0">
															<xsl:if test="string-length(logoModalite) &gt; 0">
																<img>
																	<xsl:attribute name="src"><xsl:value-of select="logoModalite"/></xsl:attribute>
																	<xsl:attribute name="alt"><xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/> : </xsl:if><xsl:value-of select="intModalite"/></xsl:attribute>
																	<xsl:attribute name="title"><xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/> : </xsl:if><xsl:value-of select="intModalite"/></xsl:attribute>
																</img>
															</xsl:if>
															<xsl:if test="string-length(logoModalite) = 0">
																<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="intModalite"/></strong>
															</xsl:if>
														</xsl:if>
														<xsl:if test="string-length(valModalite) &gt; 0">
															<xsl:if test="string-length(intModalite) &gt; 0">&amp;bull;&amp;nbsp;<xsl:value-of select="intModalite"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="valModalite"/></strong>
														</xsl:if>
														<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 1 or count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) &gt; 0">
															<xsl:if test="position() &lt; count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))])">, <xsl:if test="string-length(valModalite) &gt; 0"><br/></xsl:if></xsl:if>
														</xsl:if>
													</xsl:for-each>
												</div>
											</li>
										</xsl:if>
									</xsl:for-each>
								</ul>
							</xsl:if>
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
