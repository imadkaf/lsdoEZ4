<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="quot">"</xsl:variable>
	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="amp">&amp;</xsl:variable>
	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/critere_moda_apartirde.xsl"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/enhanced_substring.xsl"/>

	<xsl:variable name="nbPagesMax" select="5"/>
	<xsl:include href="inc/pagination.xsl"/>

	<xsl:include href="inc/periodes_ouverture.xsl"/>
	<xsl:include href="inc/bouton_reserver.xsl"/>

	<xsl:template match="/">
	
		<div class="liste-act-border">
			<xsl:call-template name="nb-produits"/>
		</div>
		
		<xsl:if test="count(resultats/produit) &gt; 0">
			<ul class="list-block-bis">
				<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)]">
					<xsl:variable name="intitule"><xsl:if test="$langue = 'en'"><xsl:value-of select="intituleGb"/></xsl:if><xsl:if test="$langue = 'de'"><xsl:value-of select="intituleDe"/></xsl:if><xsl:if test="$langue = 'fr'"><xsl:value-of select="intitule"/></xsl:if></xsl:variable>
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate($intitule, concat('%/-?_.', $quot, $apos, $amp), '        ')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<xsl:attribute name="style"><xsl:if test="position() &lt; count(../detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)])"></xsl:if></xsl:attribute>
						<a><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
						<xsl:if test="count(newPhotos/newPhoto) != 0">
						
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img>
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="alt"><xsl:value-of select="$intitule"/><xsl:if test="newPhotos/newPhoto[@credits]"> - <xsl:value-of select="newPhotos/newPhoto/@credits"/></xsl:if></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="$intitule"/><xsl:if test="newPhotos/newPhoto[@credits]"> - <xsl:value-of select="newPhotos/newPhoto/@credits"/></xsl:if></xsl:attribute>
									<!--xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=184</xsl:attribute-->
									<xsl:attribute name="src"><xsl:value-of select="$rootSitUrl"/>Image&amp;idP=<xsl:value-of select="@id"/>&amp;no=1&amp;w=184&amp;mw=1</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						
						</xsl:if>
						<div style="margin-left:194px; float:none;">
							<div class="titre-container">
								<h3>
									<a>
										<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$intitule"/></xsl:attribute>
										<span class="float-g nom"><xsl:value-of select="$intitule"/><![CDATA[ ]]></span>
									</a>
								</h3>
								<ul class="ss-titre-bis">
									<li class="pas-hotel"><xsl:value-of select="ville/intituleVille"/></li>
								</ul>
							</div>
							
							<p class="ss-titre">
								<xsl:if test="criteres/critere[@id=$critere-apartirde]/modalites/modalite[@id=$modalite-apartirde]/valModalite">
									<span class="picto"><xsl:value-of select="$termeAPartirDe"/> <span><xsl:value-of select="criteres/critere[@id=$critere-apartirde]/modalites/modalite[@id=$modalite-apartirde]/valModalite"/> &amp;euro;</span></span>
								</xsl:if>
								<![CDATA[ ]]>
							</p>
							
							<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000028' and @id != '851000308' and @id != $critere-apartirde]) &gt; 0">
								<ul class="criteres">
									<xsl:for-each select="criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0 and @id != '851000011' and @id != '851000028' and @id != '851000308' and @id != $critere-apartirde]">
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
																<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="intModalite"/><![CDATA[ ]]></strong>
															</xsl:if>
														</xsl:if>
														<xsl:if test="string-length(valModalite) &gt; 0">
															<xsl:if test="string-length(intModalite) &gt; 0">&amp;bull;&amp;nbsp;<xsl:value-of select="intModalite"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="valModalite"/><![CDATA[ ]]></strong>
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
							<xsl:variable name="commentaire"><xsl:if test="$langue = 'en'"><xsl:value-of select="commentaires/commentaire2"/></xsl:if><xsl:if test="$langue = 'de'"><xsl:value-of select="commentaires/commentaire3"/></xsl:if><xsl:if test="$langue = 'fr'"><xsl:value-of select="commentaires/commentaire1"/></xsl:if></xsl:variable>
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
								<p class="text">
									<xsl:value-of select="$commentaireNettoyeCoupe"/><xsl:if test="string-length($commentaireNettoye) &gt; 100">&amp;hellip;</xsl:if>
									<![CDATA[ ]]>
								</p>
							</xsl:if>
							
							<p class="lien-bas align-l">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
									<xsl:value-of select="$termeEnSavoirPlus"/>
								</a>
								<xsl:call-template name="boutons-reserver-liste"/>
							</p>
						</div>
						<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
					</li>
				</xsl:for-each>
			</ul>
			<xsl:call-template name="toute-pagination"/>
			
			<div class="float-d" style="margin-bottom:10px;">
				<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pubid=xa-4db82bbb1279e354"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
				<!-- deja present dans le menu pied de page <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4db82bbb1279e354"></script> -->
			</div>
			<p class="clear"><![CDATA[ ]]></p>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
