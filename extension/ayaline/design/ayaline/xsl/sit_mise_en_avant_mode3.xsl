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

	<xsl:include href="inc/periodes_ouverture_mise_en_avant.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<!-- Agenda -->
			<div class="bloc-type">
				<h2 class="bloc-liste-h2-cote">Agenda</h2>
				<p class="clear"></p>
				
				<ul class="list-agenda">
					<xsl:for-each select="resultats/details/detail">
						<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitMiseEnAvantUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(intitule, concat('/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/></xsl:variable>
						<li>
							<xsl:attribute name="style"><xsl:if test="position() &lt; count(../detail)"></xsl:if></xsl:attribute>
							<a style="overflow:hidden;"><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
							
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								<img alt="">
									<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
										<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=100</xsl:attribute>
									</xsl:if>
									<xsl:if test="count(newPhotos/newPhoto) = 0">
										<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
									</xsl:if>
								</img>
							</a>
							
							<div style="margin-left:110px">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
									<strong><xsl:value-of select="intitule"/></strong>
								</a>
								
								<p style="font-size: 11px;">
									<xsl:if test="adresses/adresse[@type='produit']/ligne1 != ''">
										<xsl:value-of select="adresses/adresse[@type='produit']/ligne1"/>
										<xsl:if test="adresses/adresse[@type='produit']/ligne2 != ''">
											<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne2"/>
											<xsl:if test="adresses/adresse[@type='produit']/ligne3 != ''">
												<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne3"/>
											</xsl:if>
										</xsl:if>
									</xsl:if>
									- <xsl:value-of select="ville/intituleVille"/>
								</p>
								
								<xsl:call-template name="periodes-ouverture"/>
								
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
							</div>
						</li>
					</xsl:for-each>
				</ul>
			
				<p class="lien-bas">
					<a class="type0">
						<xsl:attribute name="href"><xsl:value-of select="$sitListeUrlAlias" /></xsl:attribute>
						Toutes les dates
					</a>
				</p>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
