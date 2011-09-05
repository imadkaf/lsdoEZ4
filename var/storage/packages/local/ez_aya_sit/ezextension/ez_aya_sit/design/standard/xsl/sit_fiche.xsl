<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture.xsl"/>
	<xsl:include href="inc/display_dispos.xsl"/>
	<xsl:include href="inc/rendu_adresse.xsl"/>

	<xsl:template match="/produit">
		<div style="font-family:arial,sans-serif">
			<xsl:if test="string-length($lienPrecedent) &gt; 0">
				<div style="text-align:right"><a>
					<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if>#fiche-<xsl:value-of select="@id"/></xsl:attribute>
					<xsl:value-of select="$termeRetourListe"/>
				</a></div>
			</xsl:if>
			<br/>
			<div style="float:left">
				<xsl:if test="count(newPhotos/newPhoto) = 0">
					<img alt="">
						<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_grande.jpg</xsl:attribute>
					</img>
				</xsl:if>
				<xsl:for-each select="newPhotos/newPhoto[position() = 1]">
					<div><a target="_blank" style="display:block" rel="lightbox">
						<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=750&amp;amp;mw=1</xsl:attribute>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=300&amp;amp;mw=1</xsl:attribute>
						</img>
					</a></div>
				</xsl:for-each>
				<xsl:if test="count(newPhotos/newPhoto[position() &gt; 1]) &gt; 0">
					<div style="margin-top:5px">
						<xsl:for-each select="newPhotos/newPhoto[position() &gt; 1]">
							<a target="_blank" rel="lightbox">
								<xsl:attribute name="style">float:left;display:block<xsl:if test="position() &gt; 1">;margin-left:5px</xsl:if></xsl:attribute>
								<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=750&amp;amp;mw=1</xsl:attribute>
								<img alt="">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=56&amp;amp;mw=1</xsl:attribute>
								</img>
							</a>
							<xsl:if test="(position() mod 5) = 0">
								<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
							</xsl:if>
						</xsl:for-each>
						<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
					</div>
				</xsl:if>
				<script type="text/javascript">
				<![CDATA[
					var cheminImages = ']]><xsl:value-of select="$cheminImages"/><![CDATA[';
					jQuery('[rel="lightbox"]').lightBox({
						imageLoading: cheminImages+'lightbox/loading.gif',
						imageBtnClose: cheminImages+'lightbox/close.gif',
						imageBtnPrev: cheminImages+'lightbox/prev.png',
						imageBtnNext: cheminImages+'lightbox/next.png',
						imageBlank: cheminImages+'lightbox/blank.gif',
						txtImage: '',
						txtOf: ' / '
					});
				]]>
				</script>
				<div style="margin:15px 0">
					<xsl:for-each select="adresses/adresse[@type='produit']">
						<div style="padding:5px;background-color:#EEEEEE;margin-bottom:10px">
							<div><strong><xsl:value-of select="$termeAdresseFiche"/></strong></div>
							<xsl:call-template name="rendu-adresse"/>
						</div>
					</xsl:for-each>
					<xsl:for-each select="adresses/adresse[@type='prestataire']">
						<div style="padding:5px;background-color:#EEEEEE">
							<div><strong><xsl:value-of select="$termeAdressePrestataire"/></strong></div>
							<xsl:call-template name="rendu-adresse"/>
						</div>
					</xsl:for-each>
					<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
				</div>
			</div>
			<div><table cellspacing="0" cellpadding="0"><tr><td style="padding:0 0 0 15px">
				<h1 style="font-size:2em;font-weight:bold"><xsl:value-of select="intitule"/></h1>
				<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
					<p><xsl:call-template name="string-replace-all">
						<xsl:with-param name="text" select="commentaires/commentaire1"/>
						<xsl:with-param name="replace" select="'\n'"/>
						<xsl:with-param name="by" select="'&lt;br/&gt;'"/>
					</xsl:call-template></p>
				</xsl:if>
				<xsl:call-template name="periodes-ouverture"/>
				<xsl:if test="count(criteres/critere[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0]) &gt; 0">
					<div style="margin-bottom:3px"><strong><xsl:value-of select="$termeCaracteristiques"/></strong></div>
					<table cellspacing="0" width="100%">
						<xsl:for-each select="criteres/critere[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0]">
							<xsl:if test="count(modalites/modalite) &gt; 0">
								<xsl:variable name="idCritere" select="@id"/>
								<tr>
									<td>
										<xsl:attribute name="style">width:40%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">7A7368</xsl:if><xsl:if test="(position() mod 2) = 0">E0E0E0</xsl:if>;color:#<xsl:if test="(position() mod 2) = 1">FFFFFF</xsl:if><xsl:if test="(position() mod 2) = 0">353535</xsl:if></xsl:attribute>
										<xsl:if test="string-length(intCritere) &gt; 0"><strong><xsl:value-of select="intCritere"/></strong></xsl:if><xsl:if test="string-length(intCritere) = 0">&amp;nbsp;</xsl:if>
									</td>
									<td>
										<xsl:attribute name="style">width:60%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">E4E0DB</xsl:if><xsl:if test="(position() mod 2) = 0">EEEEEE</xsl:if>;color:#353535</xsl:attribute>
										<xsl:for-each select="modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', $idCritere, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', $idCritere, '|'))))]">
											<div>
												<xsl:value-of select="intModalite"/><xsl:if test="string-length(intModalite) &gt; 0 and string-length(valModalite) &gt; 0">&amp;nbsp;:&amp;nbsp;</xsl:if><xsl:if test="string-length(valModalite) &gt; 0"><strong><xsl:value-of select="valModalite"/></strong></xsl:if>
											</div>
										</xsl:for-each>
									</td>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</table>
				</xsl:if>
			</td></tr></table></div>
			<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
			<xsl:if test="count(dispos/dispo[@annee=$anneeCourante]) &gt; 0">
				<xsl:variable name="chaineDisposTotales"><xsl:value-of select="dispos/dispo[@annee=$anneeCourante]"/></xsl:variable>
				<xsl:variable name="anneeBissextile"><xsl:if test="($anneeCourante mod 4) = 0">1</xsl:if><xsl:if test="($anneeCourante mod 4) != 0">0</xsl:if></xsl:variable>
				<div style="margin:15px 0">
					<div style="margin-bottom:5px"><strong><xsl:value-of select="$termeDispos"/></strong></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeJanvier"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 1 , 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeJanvier"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeFevrier"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 32, 28 + $anneeBissextile)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeFevrier"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeMars"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 60 + $anneeBissextile, 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeMars"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeAvril"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 91 + $anneeBissextile, 30)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeAvril"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeMai"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 121 + $anneeBissextile, 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeMai"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeJuin"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 152 + $anneeBissextile, 30)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeJuin"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeJuillet"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 182 + $anneeBissextile, 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeJuillet"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeAout"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 213 + $anneeBissextile, 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeAout"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeSeptembre"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 244 + $anneeBissextile, 30)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeSeptembre"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeOctobre"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 274 + $anneeBissextile, 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeOctobre"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeNovembre"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 305 + $anneeBissextile, 30)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeNovembre"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
					<div style="margin-bottom:2px;font-size:90%;color:#999"><strong><xsl:value-of select="$termeDecembre"/></strong></div>
					<xsl:call-template name="display-dispos">
						<xsl:with-param name="disposChaine" select="substring($chaineDisposTotales, 335 + $anneeBissextile, 31)"/>
						<xsl:with-param name="index" select="1"/>
						<xsl:with-param name="mois" select="$termeDecembre"/>
					</xsl:call-template>
					<div style="clear:both;height:3px;overflow:hidden;font-size:0%"><span style="display:none">&amp;nbsp;</span></div>
				</div>
			</xsl:if>
			<!--<div style="margin-bottom:15px;text-align:center">
				<iframe width="100%" height="500" frameborder="0" scrolling="auto">
					<xsl:attribute name="src">http://www.ile-oleron-marennes.com/fileadmin/scripts/pmo_tourisme/bonnes_adresses/localisation.php?latitude=<xsl:value-of select="criteres/critere/modalites/modalite[@id='999000149000001']/valModalite"/>&amp;amp;longitude=<xsl:value-of select="criteres/critere/modalites/modalite[@id='999000149000002']/valModalite"/>&amp;amp;adresse=<xsl:value-of select="adresses/adresse[@type='produit']/ligne1"/>,%20<xsl:value-of select="adresses/adresse[@type='produit']/cp"/>%20<xsl:if test="string-length(adresses/adresse[@type='produit']/ligne2) &gt; 0"><xsl:value-of select="adresses/adresse[@type='produit']/ligne2"/>,%20</xsl:if><xsl:value-of select="adresses/adresse[@type='produit']/commune"/>&amp;amp;intitule=<xsl:value-of select="intitule"/></xsl:attribute>
					Localisation de la fiche : <xsl:value-of select="intitule"/>
				</iframe>
			</div>
			<xsl:if test="count(adresses/adresse[@type='prestataire']) &gt; 0">
				<div style="margin-bottom:15px;text-align:center">
					<iframe width="100%" height="500" frameborder="0" scrolling="auto">
						<xsl:attribute name="src">http://www.ile-oleron-marennes.com/fileadmin/scripts/pmo_tourisme/bonnes_adresses/localisation.php?latitude=&amp;amp;longitude=&amp;amp;adresse=<xsl:value-of select="adresses/adresse[@type='prestataire']/ligne1"/>,%20<xsl:if test="string-length(adresses/adresse[@type='prestataire']/ligne2) &gt; 0"><xsl:value-of select="adresses/adresse[@type='prestataire']/ligne2"/>,%20</xsl:if><xsl:value-of select="adresses/adresse[@type='prestataire']/cp"/>%20<xsl:value-of select="adresses/adresse[@type='prestataire']/commune"/>&amp;amp;intitule=<xsl:value-of select="intitule"/></xsl:attribute>
						Localisation du prestataire de la fiche : <xsl:value-of select="intitule"/>
					</iframe>
				</div>
			</xsl:if>-->
			<div style="float:left">
				<img alt="" style="float:right;margin-left:20px"><xsl:attribute name="src"><xsl:value-of select="partenaire/logoPartenaire"/></xsl:attribute></img><xsl:value-of select="$termeInformationProposeePar"/>&amp;nbsp;:<br/><strong><xsl:if test="string-length(partenaire/webPartenaire) &gt; 0"><a target="_blank"><xsl:attribute name="href"><xsl:value-of select="partenaire/webPartenaire"/></xsl:attribute><xsl:value-of select="partenaire/intPartenaire"/></a></xsl:if><xsl:if test="string-length(partenaire/webPartenaire) = 0"><xsl:value-of select="partenaire/intPartenaire"/></xsl:if></strong>
			</div>
			<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
			<div style="margin:15px 0;text-align:center">
				<!-- <object width="300" height="250" type="application/x-shockwave-flash" data="http://www.deezer.com/embed/player?pid=60027135&amp;ap=0&amp;ln=fr&amp;sl=1"><param name="movie" value="http://www.deezer.com/embed/player?pid=60027135&amp;ap=0&amp;ln=fr&amp;sl=1"/><param name="allowFullScreen" value="true"/><param name="allowscriptaccess" value="always"/></object> -->
				<object width="600" height="500" type="application/x-shockwave-flash" data="http://www.deezer.com/embed/player?pid=59908517&amp;ap=0&amp;ln=fr&amp;sl=1"><param name="movie" value="http://www.deezer.com/embed/player?pid=59908517&amp;ap=0&amp;ln=fr&amp;sl=1"/><param name="allowFullScreen" value="true"/><param name="allowscriptaccess" value="always"/></object>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>