<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
	
	<xsl:include href="inc/display_villes.xsl"/>

	<xsl:template match="/">
		<div class="bloc-type">
			<ul class="list-thm">
				<li class="first"><strong>Changer de<br />saison &gt;</strong></li>
				<li>
					<form method="post" action="/saisons/edit/">
						<input type="hidden" name="RedirectURI"><xsl:attribute name="value"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute></input>
						<input type="hidden" value="0" name="season_id" />
						<input class="actif" type="image">
							<xsl:attribute name="src" alt="Automne"><xsl:value-of select="$cheminImagesDesign"/>saison0<xsl:if test="$saisonId = '0'">-on</xsl:if>.png</xsl:attribute>
						</input>
					</form>
				</li>
				<li>
					<form method="post" action="/saisons/edit/">
						<input type="hidden" name="RedirectURI"><xsl:attribute name="value"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute></input>
						<input type="hidden" value="1" name="season_id" />
						<input class="actif" type="image">
							<xsl:attribute name="src" alt="Hiver"><xsl:value-of select="$cheminImagesDesign"/>saison1<xsl:if test="$saisonId = '1'">-on</xsl:if>.png</xsl:attribute>
						</input>
					</form>
				</li>
				<li>
					<form method="post" action="/saisons/edit/">
						<input type="hidden" name="RedirectURI"><xsl:attribute name="value"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute></input>
						<input type="hidden" value="2" name="season_id" />
						<input class="actif" type="image">
							<xsl:attribute name="src" alt="Printemps"><xsl:value-of select="$cheminImagesDesign"/>saison2<xsl:if test="$saisonId = '2'">-on</xsl:if>.png</xsl:attribute>
						</input>
					</form>
				</li>
				<li class="last">
					<form method="post" action="/saisons/edit/">
						<input type="hidden" name="RedirectURI"><xsl:attribute name="value"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute></input>
						<input type="hidden" value="3" name="season_id" />
						<input class="actif" type="image">
							<xsl:attribute name="src" alt="Eté"><xsl:value-of select="$cheminImagesDesign"/>saison3<xsl:if test="$saisonId = '3'">-on</xsl:if>.png</xsl:attribute>
						</input>
					</form>
				</li>
			</ul>
			<h2 class="bloc-liste-h2-recherche">Affiner votre recherche :</h2>
			<p class="clear"></p>
			<form method="post" class="form-search-left">
			<xsl:attribute name="action"><xsl:value-of select="$lienCourant"/>/(recherche)/oui<xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
			<xsl:if test="string-length($criteresTri) &gt; 0 and $criteresTri != '||'">
				<div style="margin-bottom:10px;">
					<span class="choisissez"><strong><xsl:value-of select="$termeTrierPar"/></strong></span>
					<xsl:if test="contains($criteresTri, '|1|')">
						<div class="liste-modalites">
							<div><xsl:value-of select="$termeCommune"/>&amp;nbsp;<a>
								<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/com~asc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
								<xsl:attribute name="style">padding:2px<xsl:if test="concat('com', '~', 'asc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
								<img style="vertical-align:middle">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>tri_asc.gif</xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
								</img>
							</a>&amp;nbsp;<a>
								<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/com~desc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
								<xsl:attribute name="style">padding:2px<xsl:if test="concat('com', '~', 'desc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
								<img style="vertical-align:middle">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>tri_desc.gif</xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
								</img>
							</a><xsl:if test="concat('com', '~', 'asc') = $triEnCours or concat('com', '~', 'desc') = $triEnCours">&amp;nbsp;<a style="padding:2px">
								<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
								<img style="vertical-align:middle">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>croix_noire.png</xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
								</img>
							</a></xsl:if></div>
						</div>
					</xsl:if>
					<xsl:for-each select="criteres/criteresSpecs/critere">
						<xsl:variable name="idCritere" select="@id"/>
						<xsl:variable name="typeCritere" select="@type"/>
						<xsl:variable name="intituleCritere" select="intCritere"/>
						<xsl:if test="contains($criteresTri, concat('|', $idCritere, '|')) or count(modalites/modalite[contains($criteresTri, concat('|', @id, '|'))]) &gt; 0">
							<div class="liste-modalites">
								<xsl:if test="contains($criteresTri, concat('|', $idCritere, '|')) and count(modalites/modalite[contains($criteresTri, concat('|', @id, '|'))]) = 0">
									<div><xsl:value-of select="$intituleCritere"/>&amp;nbsp;<a>
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/c<xsl:value-of select="$idCritere"/>~asc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
										<xsl:attribute name="style">padding:2px<xsl:if test="concat('c', $idCritere, '~', 'asc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>tri_asc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
										</img>
									</a>&amp;nbsp;<a>
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/c<xsl:value-of select="$idCritere"/>~desc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										<xsl:attribute name="style">padding:2px<xsl:if test="concat('c', $idCritere, '~', 'desc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>tri_desc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										</img>
									</a><xsl:if test="concat('c', $idCritere, '~', 'asc') = $triEnCours or concat('c', $idCritere, '~', 'desc') = $triEnCours">&amp;nbsp;<a style="padding:2px">
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>croix_noire.png</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
										</img>
									</a></xsl:if></div>
								</xsl:if>
								<xsl:if test="count(modalites/modalite[contains($criteresTri, concat('|', @id, '|'))]) &gt; 0">
									<div><xsl:value-of select="$intituleCritere"/>&amp;nbsp;:</div>
								</xsl:if>
								<xsl:for-each select="modalites/modalite[contains($criteresTri, concat('|', @id, '|'))]">
									<div>&amp;mdash;&amp;nbsp;<xsl:value-of select="."/>&amp;nbsp;<a>
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/m<xsl:value-of select="@id"/>~asc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
										<xsl:attribute name="style">padding:2px<xsl:if test="concat('m', @id, '~', 'asc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>tri_asc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
										</img>
									</a>&amp;nbsp;<a>
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/m<xsl:value-of select="@id"/>~desc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										<xsl:attribute name="style">padding:2px<xsl:if test="concat('m', @id, '~', 'desc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>tri_desc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										</img>
									</a><xsl:if test="concat('m', @id, '~', 'asc') = $triEnCours or concat('m', @id, '~', 'desc') = $triEnCours">&amp;nbsp;<a style="padding:2px">
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImagesDesign"/>croix_noire.png</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
										</img>
									</a></xsl:if></div>
								</xsl:for-each>
							</div>
						</xsl:if>
					</xsl:for-each>
				</div>
			</xsl:if>
			<div style="text-align:right;margin-bottom:5px"><a style="display:block;">
				<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
				<xsl:value-of select="$termeReinitialiserRecherche"/>
			</a></div>
			<div style="text-align:right;margin-bottom:15px">
				<button type="submit" name="search_sit" class="button">
					<span><xsl:value-of select="$termeAffinerRecherche"/></span>
				</button>
			</div>

			<xsl:if test="string-length($villes) &gt; 0">
				<div style="margin-bottom:10px">
					<label for="sit_cinsee" class="choisissez"><strong><xsl:value-of select="$termeCommune"/></strong></label>
					<select id="sit_cinsee" name="sit_cinsee[]" style="width:100%" multiple="multiple">
						<xsl:call-template name="display-villes">
							<xsl:with-param name="villesChaine" select="$villes"/>
						</xsl:call-template>
					</select>
				</div>
			</xsl:if>
			<div style="margin-bottom:10px">
				<label for="sit_mc" class="choisissez"><strong><xsl:value-of select="$termeMotsCles"/></strong></label>
				<input type="text" id="sit_mc" name="sit_mc" style="border:1px solid #999999;width:99%">
					<xsl:attribute name="value"><xsl:value-of select="$motsCles"/></xsl:attribute>
				</input>
			</div>
			<div style="margin-bottom:10px">
				<div style="float:left; width:50%">
					<div style="padding-right:3px">
						<label for="sit_debut_ouv" class="choisissez"><strong><xsl:value-of select="$termeDebutOuv"/></strong></label>
						<input type="text" id="sit_debut_ouv" name="sit_debut_ouv" style="border:1px solid #999999;width:75px" class="champ-texte-calendrier">
							<xsl:if test="string-length($ouvAnnee) = 0">
								<xsl:attribute name="value"><xsl:value-of select="$debutOuv"/></xsl:attribute>
							</xsl:if>
						</input>
					</div>
				</div>
				<div style="float:left; width:50%">
					<div style="padding-left:3px">
						<label for="sit_fin_ouv" class="choisissez"><strong><xsl:value-of select="$termeFinOuv"/></strong></label>
						<input type="text" id="sit_fin_ouv" name="sit_fin_ouv" style="border:1px solid #999999;width:75px" class="champ-texte-calendrier">
							<xsl:if test="string-length($ouvAnnee) = 0">
								<xsl:attribute name="value"><xsl:value-of select="$finOuv"/></xsl:attribute>
							</xsl:if>
						</input>
					</div>
				</div>
				<div style="clear:both"><![CDATA[ ]]></div>
				<div>
					<script type="text/javascript"><![CDATA[
						var valDebutOuv = ']]><xsl:value-of select="$debutOuv"/><![CDATA[';
						var valFinOuv = ']]><xsl:value-of select="$finOuv"/><![CDATA[';
					]]></script>
					<label for="sit_ouvert_annee">
						<input type="checkbox" id="sit_ouvert_annee" name="sit_ouvert_annee" value="1">
							<xsl:attribute name="onchange">if (this.checked) {jQuery('#sit_debut_ouv,#sit_fin_ouv').val('');} else {jQuery('#sit_debut_ouv').val(valDebutOuv);jQuery('#sit_fin_ouv').val(valFinOuv);}</xsl:attribute>
							<xsl:if test="string-length($ouvAnnee) &gt; 0">
								<xsl:attribute name="checked" select="checked"/>
							</xsl:if>
						</input>
						<xsl:value-of select="$termeOuvertTouteAnnee"/>
					</label>
				</div>
			</div>
			<xsl:for-each select="criteres/criteresSpecs/critere">
				<xsl:variable name="idCritere" select="@id"/>
				<xsl:variable name="typeCritere" select="@type"/>
				<xsl:variable name="intituleCritere" select="intCritere"/>
				<xsl:variable name="nbModalites" select="count(modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))])"/>
				<xsl:if test="$nbModalites &gt; 0">
					<div style="margin-bottom:10px">
						<label class="choisissez">
							<xsl:if test="$typeCritere = 2 or (($typeCritere = 1 or $typeCritere = 3) and count(modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]) = 2)">
								<xsl:attribute name="for">sit_mr_<xsl:value-of select="$idCritere"/></xsl:attribute>
							</xsl:if>
							<strong><xsl:value-of select="$intituleCritere"/></strong>
						</label>
						<xsl:choose>
							<xsl:when test="$typeCritere = 2 or (($typeCritere = 1 or $typeCritere = 3) and count(modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]) = 2)">
								<select style="width:100%">
									<xsl:attribute name="name">sit_mr[<xsl:value-of select="$idCritere"/>][]</xsl:attribute>
									<xsl:attribute name="id">sit_mr_<xsl:value-of select="$idCritere"/></xsl:attribute>
									<option value="">
										<xsl:value-of select="$termeIndifferent"/>
									</option>
									<xsl:for-each select="modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]">
										<option>
											<xsl:if test="contains($modalitesRapides, concat('|', @id, '|'))">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
											<xsl:value-of select="."/>
										</option>
									</xsl:for-each>
								</select>
							</xsl:when>
							<xsl:when test="($typeCritere = 1 or $typeCritere = 3) and count(modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]) != 2">
								<ul class="liste-modalites">
								<xsl:for-each select="modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]">
									<li style="padding:0;">
										<label style="display:block">
											<xsl:attribute name="for">sit_mr_<xsl:value-of select="@id"/></xsl:attribute>
											<input type="checkbox" style="vertical-align:0;margin:0 2px 0 0;margin:-4px 0 -4px -4px\9">
												<xsl:attribute name="name">sit_mr[<xsl:value-of select="$idCritere"/>][]</xsl:attribute>
												<xsl:if test="contains($modalitesRapides, concat('|', @id, '|'))">
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
												<xsl:attribute name="id">sit_mr_<xsl:value-of select="@id"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="@id"/></xsl:attribute>
											</input>
											<xsl:value-of select="."/>
										</label>
									</li>
								</xsl:for-each>
								</ul>
							</xsl:when>
							<xsl:when test="$typeCritere = 4">
								<ul class="liste-modalites">
								<xsl:for-each select="modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]">
									<li style="padding:0;">
										<label>
											<xsl:attribute name="for">sit_nrtr_<xsl:value-of select="@id"/></xsl:attribute>
											<xsl:value-of select="."/><br/>
											<xsl:variable name="valeurCourante"><xsl:if test="@num = '1'"><xsl:value-of select="substring-before(substring-after($modalitesNum, concat('|', @id, '#')), '|')"/></xsl:if><xsl:if test="@num != 1"><xsl:value-of select="substring-before(substring-after($modalitesTexte, concat('|', @id, '#')), '|')"/></xsl:if></xsl:variable>
											<xsl:if test="@num = '1'">
												<select style="font-size:110%">
													<xsl:attribute name="name">sit_nrtr[<xsl:value-of select="@id"/>][ope]</xsl:attribute>
													<option value="&amp;lt;=">
														<xsl:if test="substring-after($valeurCourante, '#') = '&lt;='"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
														&amp;lt;=
													</option>
													<option value="=">
														<xsl:if test="substring-after($valeurCourante, '#') = '='"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
														=
													</option>
													<option value="&amp;gt;=">
														<xsl:if test="substring-after($valeurCourante, '#') = '&gt;='"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
														&amp;gt;=
													</option>
												</select>
											</xsl:if>
											<input type="text">
												<xsl:attribute name="name">sit_nrtr[<xsl:value-of select="@id"/>][val]</xsl:attribute>
												<xsl:attribute name="id">sit_nrtr_<xsl:value-of select="@id"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="substring-before($valeurCourante, '#')"/></xsl:attribute>
												<xsl:attribute name="style">vertical-align:middle;margin-bottom:2px;font-size:1.1em;border:1px solid #999999;vertical-align:0;width:<xsl:if test="@num = '1'">70</xsl:if><xsl:if test="@num != '1'">95</xsl:if>%</xsl:attribute>
											</input>
										</label>
									</li>
								</xsl:for-each>
								</ul>
							</xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</div>
				</xsl:if>
			</xsl:for-each>
			<div style="text-align:right;margin-bottom:5px"><a style="display:block;">
				<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
				<xsl:value-of select="$termeReinitialiserRecherche"/>
			</a></div>
			<div style="text-align:right">
				<button type="submit" name="search_sit" class="button">
					<span><xsl:value-of select="$termeAffinerRecherche"/></span>
				</button>
			</div>
		</form></div>
		<script type="text/javascript"><![CDATA[
			jQuery('#sit_debut_ouv, #sit_fin_ouv').attr('autocomplete', "off").datepicker({
				showAnim: 'fadeIn',
				showOtherMonths: true,
				selectOtherMonths: true,
				showWeek: true
			});
			jQuery('#sit_debut_dispo').attr('autocomplete', "off").datepicker({
				showAnim: 'fadeIn',
				showOtherMonths: true,
				selectOtherMonths: true,
				showWeek: true,
				minDate: new Date()
			});
		]]></script>
	</xsl:template>
</xsl:stylesheet>