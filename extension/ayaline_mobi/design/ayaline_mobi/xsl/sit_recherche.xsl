<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:template match="/">
		<div class="bloc-type recherche-date">
			<span class="bloc-liste-h2-recherche">Recherche par date</span>
			
			<form method="post" class="form-search-left">
				<xsl:attribute name="action"><xsl:value-of select="$lienCourant"/>/(recherche)/oui<xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
				
				<div class="saisie-date">
					<div style="float:left; width:50%">
						<div style="padding-right:3px">
							<label for="sit_debut_ouv" class="choisissez"><strong><xsl:value-of select="$termeDebutOuv"/></strong></label>
							<input type="text" id="sit_debut_ouv" name="sit_debut_ouv" style="border:1px solid #999999;width:85px" class="champ-texte-calendrier">
								<xsl:if test="string-length($ouvAnnee) = 0">
									<xsl:attribute name="value"><xsl:value-of select="$debutOuv"/></xsl:attribute>
								</xsl:if>
							</input>
						</div>
					</div>
					<div style="float:left; width:50%">
						<div style="padding-left:3px">
							<label for="sit_fin_ouv" class="choisissez"><strong><xsl:value-of select="$termeFinOuv"/></strong></label>
							<input type="text" id="sit_fin_ouv" name="sit_fin_ouv" style="border:1px solid #999999;width:85px" class="champ-texte-calendrier">
								<xsl:if test="string-length($ouvAnnee) = 0">
									<xsl:attribute name="value"><xsl:value-of select="$finOuv"/></xsl:attribute>
								</xsl:if>
							</input>
						</div>
					</div>
					<p class="clear"><![CDATA[ ]]></p>
				</div>
				<br />
				
				<div class="reinitialiser">
					<a style="display:block;">
						<xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute>
						<xsl:value-of select="$termeReinitialiserRecherche"/>
					</a>
				</div>
				
				<div class="bouton-date">
					<button type="submit" name="search_sit" class="button">
						<span><xsl:value-of select="$termeAffinerRecherche"/></span>
					</button>
				</div>
				<br />
			</form>
		</div>
		
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
