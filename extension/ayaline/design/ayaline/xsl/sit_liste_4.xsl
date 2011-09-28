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

	<xsl:variable name="nbPagesMax" select="5"/>
	<xsl:include href="inc/pagination.xsl"/>

	<xsl:include href="inc/periodes_ouverture_mise_en_avant.xsl"/>

	<xsl:template match="/">
		
		<div class="liste-act-border">
			<xsl:call-template name="nb-produits"/>
		</div>
		
		<xsl:if test="count(resultats/produit) &gt; 0">
			<ul class="list">		
				<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)]">
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(translate(translate(intitule, concat('/-?_.', $quot, $apos, $amp), '        '), $caracteresKo, $caracteresOk), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<xsl:attribute name="style"><xsl:if test="position() &lt; count(../detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)])"></xsl:if></xsl:attribute>
						<xsl:if test="position() mod 2 = 1">
							<xsl:attribute name="class">first</xsl:attribute>
						</xsl:if>
						<a><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
						<h3 class="bloc-liste-h3" style="margin-bottom:0px !important;">
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								<span><xsl:value-of select="intitule"/></span>
							</a>
						</h3>
						<ul class="ss-titre-bis">
							<li class="last" style="padding: 0 !important;"><xsl:value-of select="ville/intituleVille"/></li>
						</ul>
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img alt="">
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=250</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(newPhotos/newPhoto) = 0">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>image_fiche_defaut_grande.jpg</xsl:attribute>
									<xsl:attribute name="width">250</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						<div style="margin-top:5px;">
							<xsl:call-template name="periodes-ouverture"/>
						</div>
						<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000028']) &gt; 0">
							<ul class="criteres liste-act">
								<xsl:for-each select="criteres/critere[@id != '851000011' and @id != '851000028']">
									<xsl:variable name="idCritere" select="@id"/>
									<xsl:variable name="intituleCritere" select="intCritere"/>
									<xsl:if test="count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 0">
										<li style="padding: 5px 0px 5px 0px !important;">
											<div style="padding: 0px 0px 0px 5px">
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
						
						<p>
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
								
								<xsl:value-of select="$commentaire1NettoyeCoupe"/><xsl:if test="string-length($commentaire1Nettoye) &gt; 200">&amp;hellip;</xsl:if>
								<![CDATA[ ]]>
							</xsl:if>
						</p>
						
						<p class="lien-bas" style="display: inline;">
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
					<xsl:if test="position() mod 2 = 0"><![CDATA[</ul><ul class="list">]]></xsl:if>
				</xsl:for-each>
			</ul>
			<script type="text/javascript">
				$(window).load(equilibrerHauteursBlocs);
			</script>
			
			<xsl:call-template name="toute-pagination"/>
			
			<div class="float-d" style="margin-bottom:10px;">
				<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pubid=xa-4db82bbb1279e354"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
				<!-- deja present dans le menu pied de page <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4db82bbb1279e354"></script> -->
			</div>
			<p class="clear"><![CDATA[ ]]></p>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
