<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:template match="/">
		<div style="padding:5px;background-color:#725F4B;color:white;border:1px solid black;margin-bottom:7px;font-family:arial,sans-serif"><form method="post">
			<xsl:attribute name="action"><xsl:value-of select="$lienCourant"/>/(recherche)/oui<xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
			<xsl:if test="string-length($criteresTri) &gt; 0 and $criteresTri != '||'">
				<div style="padding:5px;background-color:white;color:#725F4B;border:1px solid black;margin-bottom:10px;font-family:arial,sans-serif">
					<label style="color:#725F4B;display:inline;padding:0 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid #725F4B;display:block">
						<strong><xsl:value-of select="$termeTrierPar"/></strong>
					</label>
					<xsl:if test="contains($criteresTri, '|1|')">
						<div style="margin-bottom:7px">
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
							<div style="margin-bottom:7px">
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
			<div style="text-align:right;margin-bottom:5px"><a style="display:block;color:white">
				<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
				<xsl:value-of select="$termeReinitialiserRecherche"/>
			</a></div>
			<div style="text-align:right;margin-bottom:5px"><input type="submit" name="search_sit">
				<xsl:attribute name="value"><xsl:value-of select="$termeAffinerRecherche"/></xsl:attribute>
			</input></div>
			<div style="padding:5px;border:1px solid white;margin-bottom:5px">
				<label style="color:white;display:inline;padding:0 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid white;display:block" for="sit_mc">
					<strong><xsl:value-of select="$termeMotsCles"/></strong>
				</label>
				<input type="text" id="sit_mc" name="sit_mc" style="border:1px solid #999999;width:95%">
					<xsl:attribute name="value"><xsl:value-of select="$motsCles"/></xsl:attribute>
				</input>
			</div>
			<div style="padding:5px;border:1px solid white;margin-bottom:5px">
				<label style="color:white;display:inline;padding:0 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid white;display:block" for="sit_debut_ouv">
					<strong><xsl:value-of select="$termeDebutOuv"/></strong>
				</label>
				<input type="text" id="sit_debut_ouv" name="sit_debut_ouv" style="border:1px solid #999999;width:84%" class="champ-texte-calendrier">
					<xsl:attribute name="value"><xsl:value-of select="$debutOuv"/></xsl:attribute>
				</input>
				<label style="color:white;display:inline;padding:2px 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid white;display:block" for="sit_fin_ouv">
					<strong><xsl:value-of select="$termeFinOuv"/></strong>
				</label>
				<input type="text" id="sit_fin_ouv" name="sit_fin_ouv" style="border:1px solid #999999;width:84%" class="champ-texte-calendrier">
					<xsl:attribute name="value"><xsl:value-of select="$finOuv"/></xsl:attribute>
				</input>
			</div>
			<div style="padding:5px;border:1px solid white;margin-bottom:5px">
				<label style="color:white;display:inline;padding:0 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid white;display:block" for="sit_debut_dispo">
					<strong><xsl:value-of select="$termeAPartirde"/></strong>
				</label>
				<input type="text" id="sit_debut_dispo" name="sit_debut_dispo" style="border:1px solid #999999;width:84%" class="champ-texte-calendrier">
					<xsl:attribute name="value"><xsl:value-of select="$debutDispo"/></xsl:attribute>
				</input>
				<label style="color:white;display:inline;padding:2px 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid white;display:block" for="sit_duree_dispo">
					<strong><xsl:value-of select="$termeNombreNuitees"/></strong>
				</label>
				<input type="text" id="sit_duree_dispo" name="sit_duree_dispo" style="border:1px solid #999999;width:95%">
					<xsl:attribute name="value"><xsl:value-of select="$dureeDispo"/></xsl:attribute>
				</input>
			</div>
			<xsl:for-each select="criteres/criteresSpecs/critere">
				<xsl:variable name="idCritere" select="@id"/>
				<xsl:variable name="typeCritere" select="@type"/>
				<xsl:variable name="intituleCritere" select="intCritere"/>
				<xsl:variable name="nbModalites" select="count(modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))])"/>
				<xsl:if test="$nbModalites &gt; 0">
					<div style="padding:5px;border:1px solid white;margin-bottom:5px">
						<label style="color:white;display:inline;padding:0 0 1px 0;margin-bottom:3px;white-space:normal;font-size:.85em;border-bottom:1px solid white;display:block">
							<xsl:if test="$typeCritere = 2">
								<xsl:attribute name="for">sit_mr_<xsl:value-of select="$idCritere"/></xsl:attribute>
							</xsl:if>
							<strong><xsl:value-of select="$intituleCritere"/></strong>
						</label>
						<xsl:choose>
							<xsl:when test="$typeCritere = 2 or (($typeCritere = 1 or $typeCritere = 3) and count(modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]) = 2)">
								<select style="width:99%;font-size:.85em">
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
								<ul style="margin:0;padding:0">
								<xsl:for-each select="modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]">
									<li style="background:none;list-style:none;padding:0;margin:0">
										<label style="color:white;padding:0;margin:0;white-space:normal;font-size:.85em">
											<xsl:attribute name="for">sit_mr_<xsl:value-of select="@id"/></xsl:attribute>
											<input type="checkbox" style="vertical-align:middle;margin:0 2px 0 0;margin:-4px 0 -4px -4px\9">
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
								<ul style="margin:0;padding:0 0 0 1em">
								<xsl:for-each select="modalites/modalite[contains($criteresRecherche, concat('|', @id, '|')) or contains($criteresRecherche, concat('|', $idCritere, '|'))]">
									<li style="background:none;list-style:disc;padding:0;margin:0">
										<label style="color:white;display:inline;padding:0;margin:0;white-space:normal;font-size:.85em">
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
			<div style="text-align:right"><input type="submit" name="search_sit">
				<xsl:attribute name="value"><xsl:value-of select="$termeAffinerRecherche"/></xsl:attribute>
			</input></div>
			<div style="text-align:right;margin-top:5px"><a style="display:block;color:white">
				<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
				<xsl:value-of select="$termeReinitialiserRecherche"/>
			</a></div>
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