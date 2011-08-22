<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:template match="/">
		<div class="bloc-type">
			<ul class="list-thm">
				<li class="first"><strong>Changer de<br />saison &gt;</strong></li>
				<li><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm1-bis.png" alt="" /></a></li>
				<li><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm2-bis.png" alt="" /></a></li>
				<li><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm3-bis.png" alt="" /></a></li>
				<li class="last"><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm4-bis.png" alt="" /></a></li>
			</ul>
			<!-- ul class="list-thm">
				<li class="first"><strong>Changer de<br />th&amp;egrave;me &gt;</strong></li>
				<li><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm1.png" alt="" /></a></li>
				<li><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm2.png" alt="" /></a></li>
				<li><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm3.png" alt="" /></a></li>
				<li class="last"><a href="#"><img src="/extension/ayaline/design/ayaline/images/thm4.png" alt="" /></a></li>
			</ul-->
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
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>tri_asc.gif</xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
								</img>
							</a>&amp;nbsp;<a>
								<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/com~desc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
								<xsl:attribute name="style">padding:2px<xsl:if test="concat('com', '~', 'desc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
								<img style="vertical-align:middle">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>tri_desc.gif</xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
								</img>
							</a><xsl:if test="concat('com', '~', 'asc') = $triEnCours or concat('com', '~', 'desc') = $triEnCours">&amp;nbsp;<a style="padding:2px">
								<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
								<xsl:attribute name="title"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
								<img style="vertical-align:middle">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>croix_noire.png</xsl:attribute>
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
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>tri_asc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
										</img>
									</a>&amp;nbsp;<a>
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/c<xsl:value-of select="$idCritere"/>~desc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										<xsl:attribute name="style">padding:2px<xsl:if test="concat('c', $idCritere, '~', 'desc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>tri_desc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										</img>
									</a><xsl:if test="concat('c', $idCritere, '~', 'asc') = $triEnCours or concat('c', $idCritere, '~', 'desc') = $triEnCours">&amp;nbsp;<a style="padding:2px">
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>croix_noire.png</xsl:attribute>
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
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>tri_asc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriCroissant"/></xsl:attribute>
										</img>
									</a>&amp;nbsp;<a>
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if>/(tri)/m<xsl:value-of select="@id"/>~desc<xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										<xsl:attribute name="style">padding:2px<xsl:if test="concat('m', @id, '~', 'desc') = $triEnCours">;background-color:#CCCCCC</xsl:if></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>tri_desc.gif</xsl:attribute>
											<xsl:attribute name="alt"><xsl:value-of select="$termeTriDecroissant"/></xsl:attribute>
										</img>
									</a><xsl:if test="concat('m', @id, '~', 'asc') = $triEnCours or concat('m', @id, '~', 'desc') = $triEnCours">&amp;nbsp;<a style="padding:2px">
										<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="$termeAnnulerTri"/></xsl:attribute>
										<img style="vertical-align:middle">
											<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>croix_noire.png</xsl:attribute>
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
							<xsl:attribute name="value"><xsl:value-of select="$debutOuv"/></xsl:attribute>
						</input>
					</div>
				</div>
				<div style="float:left; width:50%">
					<div style="padding-left:3px">
						<label for="sit_fin_ouv" class="choisissez"><strong><xsl:value-of select="$termeFinOuv"/></strong></label>
						<input type="text" id="sit_fin_ouv" name="sit_fin_ouv" style="border:1px solid #999999;width:75px" class="champ-texte-calendrier">
							<xsl:attribute name="value"><xsl:value-of select="$finOuv"/></xsl:attribute>
						</input>
					</div>
				</div>
				<div style="clear:both"><![CDATA[ ]]></div>
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
											<xsl:value-of select="."/>
											<input type="text" style="vertical-align:middle;margin-bottom:2px;font-size:.85em;border:1px solid #999999;width:95%">
												<xsl:attribute name="name">sit_nrtr[<xsl:value-of select="@id"/>]</xsl:attribute>
												<xsl:attribute name="id">sit_nrtr_<xsl:value-of select="@id"/></xsl:attribute>
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