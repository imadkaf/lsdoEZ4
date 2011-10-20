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
	<xsl:include href="inc/bouton_reserver.xsl"/>

	<xsl:template match="/">
		<xsl:if test="count(resultats/produit) &gt; 0">
			<ul class="list-inline-bis">
				<xsl:for-each select="resultats/details/detail">
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(intitule, concat('/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<xsl:if test="(position() mod 2) =  1">
							<xsl:attribute name="class">first</xsl:attribute>
						</xsl:if>
						<a><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
						<h3 class="titre-top2">
							<a class="top2"><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><xsl:value-of select="intitule"/></a>
							<xsl:choose>
								<xsl:when test="criteres/critere[@id='851000005']/modalites/modalite[1 and contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]/logoModalite != ''">
									<img alt="" class="float-g">
										<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeCategorie"/> : <xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/></xsl:attribute>
									</img>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="criteres/critere[@id='851000005']/modalites/modalite[1 and contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]/intModalite != ''">
										<xsl:value-of select="criteres/critere[@id='851000005']/modalites/modalite[1]/intModalite"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</h3>
						<ul class="ss-titre-bis">
							<li><xsl:value-of select="ville/intituleVille"/></li>
							<li class="last"><xsl:value-of select="criteres/critere[@id='851000001']/modalites/modalite[1]/intModalite"/></li>
						</ul>
						<p class="ss-titre">
							<xsl:choose>
								<xsl:when test="criteres/critere[@id='851000023']/modalites/modalite[@id='8510000230002']/valModalite">
									<span class="picto">A partir de <span><xsl:value-of select="criteres/critere[@id='851000023']/modalites/modalite[@id='8510000230002']/valModalite"/> &amp;euro;</span></span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="criteres/critere[@id='851000020']/modalites/modalite[@id='8510000200002']/valModalite">
										<span class="picto">A partir de <span><xsl:value-of select="criteres/critere[@id='851000020']/modalites/modalite[@id='8510000200002']/valModalite"/> &amp;euro;</span></span>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</p>
						
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img alt="">
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=280</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(newPhotos/newPhoto) = 0">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						
						<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000005' and @id != '851000001' and @id != '851000023' and @id != '851000020' and @id != '851000028' and @id != '851000010' and @id != '851000308']) &gt; 0">
							<ul class="criteres liste-hotel">
								<xsl:for-each select="criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000005' and @id != '851000001' and @id != '851000023' and @id != '851000020' and @id != '851000028' and @id != '851000010' and @id != '851000308']">
									<xsl:variable name="idCritere" select="@id"/>
									<xsl:variable name="intituleCritere" select="intCritere"/>
									<xsl:if test="count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 0">
										<li style="padding: 5px 0px 5px 0px !important;">
											<div style="padding: 0px 0px 0px 5px">
												<xsl:if test="count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 1 or count(modalites/modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) &gt; 0"><xsl:value-of select="$intituleCritere"/>&amp;nbsp;: <xsl:if test="count(modalites/modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(intModalite) &gt; 0]) &gt; 0"><br/></xsl:if></xsl:if>
												<xsl:for-each select="modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]">
													<xsl:if test="string-length(valModalite) = 0">
														<xsl:if test="string-length(logoModalite) &gt; 0 and $idCritere != '0'">
															<img>
																<xsl:attribute name="src"><xsl:value-of select="logoModalite"/></xsl:attribute>
																<xsl:attribute name="alt"><xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/> : </xsl:if><xsl:value-of select="intModalite"/></xsl:attribute>
																<xsl:attribute name="title"><xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/> : </xsl:if><xsl:value-of select="intModalite"/></xsl:attribute>
															</img>
														</xsl:if>
														<xsl:if test="string-length(logoModalite) = 0 or $idCritere = '0'">
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
						
						<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
							<xsl:variable name="commentaire1Nettoye">
								<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="commentaires/commentaire1"/>
									<xsl:with-param name="replace" select="'\n'"/>
									<xsl:with-param name="by" select="' '"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="commentaire1NettoyeCoupe">
								<xsl:if test="string-length($commentaire1Nettoye) &lt;= 200">
									<xsl:value-of select="$commentaire1Nettoye"/>
								</xsl:if>
								<xsl:if test="string-length($commentaire1Nettoye) &gt; 200">
									<xsl:call-template name="enhanced-substring">
										<xsl:with-param name="text" select="$commentaire1Nettoye"/>
										<xsl:with-param name="currentSize" select="0"/>
										<xsl:with-param name="totalSize" select="200"/>
										<xsl:with-param name="delimiter" select="' '"/>
									</xsl:call-template>
								</xsl:if>
							</xsl:variable>
							<p class="text" style="padding-top:5px;">
								<xsl:value-of select="$commentaire1NettoyeCoupe"/><xsl:if test="string-length($commentaire1Nettoye) &gt; 200">&amp;hellip;</xsl:if>
							</p>
						</xsl:if>
						
						<p class="lien-bas">
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								En savoir plus
							</a>
							<xsl:call-template name="boutons-reserver-liste"/>
							
						</p>
					</li>
				</xsl:for-each>
			</ul>
			<script type="text/javascript">
				equilibre = true;
				$(window).load(equilibrerHauteursBlocs);
			</script>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
