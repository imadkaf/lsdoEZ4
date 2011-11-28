<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="pagination">
		<xsl:param name="numPage"/>
		<xsl:param name="nbPagesAffiches"/>
		<xsl:choose>
			<xsl:when test="$nbPagesAffiches &lt; $nbPages and $nbPagesAffiches &lt; $nbPagesMax and $numPage &gt;= 1 and $numPage &lt;= $nbPages">
				<xsl:if test="$numPage = $pageCourante">
					<strong><xsl:value-of select="$numPage"/></strong>
				</xsl:if>
				<xsl:if test="$numPage != $pageCourante"><a><xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if>/(page)/<xsl:value-of select="$numPage"/></xsl:attribute><xsl:value-of select="$numPage"/></a></xsl:if>
				<xsl:if test="($nbPagesAffiches + 1) &lt; $nbPages and ($nbPagesAffiches + 1) &lt; $nbPagesMax">
					<span> - </span>
				</xsl:if>
				<xsl:call-template name="pagination">
					<xsl:with-param name="numPage" select="$numPage + 1"/>
					<xsl:with-param name="nbPagesAffiches" select="$nbPagesAffiches + 1"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$nbPagesAffiches &lt; $nbPages and $nbPagesAffiches &lt; $nbPagesMax">
				<xsl:call-template name="pagination">
					<xsl:with-param name="numPage" select="$numPage + 1"/>
					<xsl:with-param name="nbPagesAffiches" select="$nbPagesAffiches"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="toute-pagination">
		<xsl:if test="$nbPages &gt; 1">
			<div style="padding:5px;text-align:center;margin-bottom:7px" class="pagination no-margin">
				<div class="sit-pagination">
					<xsl:if test="$pageCourante &gt; 1"><a><xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if></xsl:attribute><xsl:value-of select="$termePremierePage"/></a><span> - </span></xsl:if>
					<xsl:if test="$pageCourante &lt;= 1"><xsl:value-of select="$termePremierePage"/><span> - </span></xsl:if>
					<xsl:if test="$pageCourante &gt; 1"><a><xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="$pageCourante &gt; 2">/(page)/<xsl:value-of select="$pageCourante - 1"/></xsl:if></xsl:attribute><xsl:value-of select="$termePrecedent"/></a><span> - </span></xsl:if>
					<xsl:if test="$pageCourante &lt;= 1"><xsl:value-of select="$termePrecedent"/><span> - </span></xsl:if>
					<xsl:variable name="numPageDebut">
						<xsl:if test="($pageCourante + ceiling($nbPagesMax div 2)) &lt;= $nbPages"><xsl:value-of select="0"/></xsl:if>
						<xsl:if test="($pageCourante + ceiling($nbPagesMax div 2)) &gt; $nbPages"><xsl:value-of select="($pageCourante + ceiling($nbPagesMax div 2)) - $nbPages - 1"/></xsl:if>
					</xsl:variable>
					<span style="padding:0 10px">
						<xsl:call-template name="pagination">
							<xsl:with-param name="numPage" select="$pageCourante - (ceiling($nbPagesMax div 2) + $numPageDebut) + ($nbPagesMax mod 2)"/>
							<xsl:with-param name="nbPagesAffiches" select="0"/>
						</xsl:call-template>
					</span>
					<xsl:if test="$pageCourante &lt; $nbPages"><span> - </span><a><xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if>/(page)/<xsl:value-of select="$pageCourante + 1"/></xsl:attribute><xsl:value-of select="$termeSuivant"/></a></xsl:if>
					<xsl:if test="$pageCourante &gt;= $nbPages"><span> - </span><xsl:value-of select="$termeSuivant"/></xsl:if>
					<xsl:if test="$pageCourante &lt; $nbPages"><span> - </span><a><xsl:attribute name="href"><xsl:value-of select="$lienCourant"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if>/(page)/<xsl:value-of select="$nbPages"/></xsl:attribute><xsl:value-of select="$termeDernierePage"/></a></xsl:if>
					<xsl:if test="$pageCourante &gt;= $nbPages"><span> - </span><xsl:value-of select="$termeDernierePage"/></xsl:if>
				</div>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="nb-produits">
		<div class="pagination no-margin align-l">
			<p class="padding-l"><xsl:if test="$nbResultatsTotal = 0"><xsl:value-of select="$termeAucun"/></xsl:if><xsl:if test="$nbResultatsTotal &gt; 0"><strong><xsl:value-of select="$nbResultatsTotal"/></strong>&amp;nbsp;<xsl:value-of select="$termeResultatsTrouves"/></xsl:if></p>
		</div>
	</xsl:template>
</xsl:stylesheet>
