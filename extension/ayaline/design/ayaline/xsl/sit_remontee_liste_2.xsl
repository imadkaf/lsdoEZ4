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
					<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<xsl:if test="(position() mod 2) = 1">
							<xsl:attribute name="class">first</xsl:attribute>
						</xsl:if>
						<a><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
						<h3 class="titre-top2">
							<a class="top2"><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><xsl:value-of select="$intitule"/></a>
							<xsl:choose>
								<xsl:when test="criteres/critere[@id='851000033']/modalites/modalite[1 and contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]/logoModalite != ''">
									<img alt="" class="float-g">
										<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='851000033']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeCategorie"/> : <xsl:value-of select="criteres/critere[@id='851000033']/modalites/modalite[1]/intModalite"/></xsl:attribute>
									</img>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="criteres/critere[@id='851000033']/modalites/modalite[1 and contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]/intModalite != ''">
										<xsl:value-of select="criteres/critere[@id='851000033']/modalites/modalite[1]/intModalite"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</h3>
						<ul class="ss-titre-bis">
							<li class="pas-hotel"><xsl:value-of select="ville/intituleVille"/></li>
						</ul>
						
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img alt="">
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=280</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(newPhotos/newPhoto) = 0">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						
						<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000028' and @id != '851000308' and @id != '851000033']) &gt; 0">
							<ul class="criteres liste-hotel">
								<xsl:for-each select="criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000028' and @id != '851000308' and @id != '851000033']">
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
						<xsl:variable name="commentaire"><xsl:if test="$langue = 'en'"><xsl:value-of select="commentaires/commentaire2"/></xsl:if><xsl:if test="$langue != 'en'"><xsl:value-of select="commentaires/commentaire1"/></xsl:if></xsl:variable>
						<xsl:if test="string-length($commentaire) &gt; 0">
							<xsl:variable name="commentaireNettoye">
								<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="$commentaire"/>
									<xsl:with-param name="replace" select="'\n'"/>
									<xsl:with-param name="by" select="' '"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="commentaireNettoyeCoupe">
								<xsl:if test="string-length($commentaireNettoye) &lt;= 200">
									<xsl:value-of select="$commentaireNettoye"/>
								</xsl:if>
								<xsl:if test="string-length($commentaireNettoye) &gt; 200">
									<xsl:call-template name="enhanced-substring">
										<xsl:with-param name="text" select="$commentaireNettoye"/>
										<xsl:with-param name="currentSize" select="0"/>
										<xsl:with-param name="totalSize" select="200"/>
										<xsl:with-param name="delimiter" select="' '"/>
									</xsl:call-template>
								</xsl:if>
							</xsl:variable>
							<p class="text" style="padding-top:5px;">
								<xsl:value-of select="$commentaireNettoyeCoupe"/><xsl:if test="string-length($commentaireNettoye) &gt; 200">&amp;hellip;</xsl:if>
							</p>
						</xsl:if>
						
						<p class="lien-bas">
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								En savoir plus
							</a>
							<xsl:if test="string-length(criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280002']/valModalite) &gt; 0">
								<a class="reserver">
								<xsl:attribute name="href"><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280002']/valModalite"/></xsl:attribute>
								R&amp;eacute;server
								</a>
							</xsl:if>
							<xsl:if test="string-length(criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280004']/valModalite) &gt; 0">
								<a class="dispos">
								<xsl:attribute name="href"><xsl:value-of select="criteres/critere[@id='851000028']/modalites/modalite[@id='8510000280004']/valModalite"/></xsl:attribute>
								Dispos
								</a>
							</xsl:if>
						</p>
					</li>
				</xsl:for-each>
				<![CDATA[ ]]>
			</ul>
			<script type="text/javascript">
				equilibre = true;
				$(window).load(equilibrerHauteursBlocs);
			</script>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
