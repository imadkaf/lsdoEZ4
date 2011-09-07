<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="espace" select="' '"/>
	<xsl:variable name="apos">'</xsl:variable>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_1.xsl"/>
	<xsl:include href="inc/display_dispos.xsl"/>
	<xsl:include href="inc/rendu_adresse.xsl"/>

	<xsl:template match="/produit">
		<div class="titre-fiche">
			<h2><xsl:value-of select="intitule"/></h2>
			<p class="clear"><![CDATA[ ]]></p>
		</div>
		
		<div class="apercu-fiche">
			<img alt="">
				<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
					<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=285</xsl:attribute>
				</xsl:if>
				<xsl:if test="count(newPhotos/newPhoto) = 0">
					<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
					<xsl:attribute name="width">285px</xsl:attribute>
				</xsl:if>
			</img>
			
			<p class="sous-titre" style="margin: 5px 0px 5px 0px;">
				<span><xsl:value-of select="ville/intituleVille"/></span>
			</p>
			
			<p class="adresse">
				<xsl:if test="adresses/adresse[@type='produit']/ligne1 != ''">
					<xsl:value-of select="adresses/adresse[@type='produit']/ligne1"/>
					<xsl:if test="adresses/adresse[@type='produit']/ligne2 != ''">
						<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne2"/>
						<xsl:if test="adresses/adresse[@type='produit']/ligne3 != ''">
							<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne3"/>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<xsl:if test="adresses/adresse[@type='produit']/cp != ''">
					<br /><xsl:value-of select="adresses/adresse[@type='produit']/cp"/>
				</xsl:if>
				<xsl:if test="adresses/adresse[@type='produit']/commune != ''">
					&amp;nbsp;<xsl:value-of select="adresses/adresse[@type='produit']/commune"/>
				</xsl:if>
				<xsl:if test="adresses/adresse[@type='produit']/paysMonde != ''">
					<br /><xsl:value-of select="adresses/adresse[@type='produit']/paysMonde"/>
				</xsl:if>
			</p>
			<br />
			
			<p class="tel">
				<xsl:if test="adresses/adresse[@type='produit']/tel1 != ''">
					<b>T&amp;eacute;l : </b><xsl:value-of select="adresses/adresse[@type='produit']/tel1"/><br />
					<xsl:if test="adresses/adresse[@type='produit']/tel2 != ''">
						<b>Autre t&amp;eacute; : </b><xsl:value-of select="adresses/adresse[@type='produit']/tel2"/>
					</xsl:if>
				</xsl:if>
			</p>
			
			<xsl:if test="adresses/adresse[@type='produit']/tel1 != ''">
				<a class="telephone">
					<xsl:attribute name="href">tel:<xsl:value-of select="adresses/adresse[@type='produit']/tel1"/></xsl:attribute>
					<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			
			<xsl:if test="adresses/adresse[@type='produit']/email != ''">
				<a class="mail">
					<xsl:attribute name="href">mailto:<xsl:value-of select="adresses/adresse[@type='produit']/email"/></xsl:attribute>
					<span>&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</span>
				</a>
			</xsl:if>
			<p class="clear"><![CDATA[ ]]></p>
		</div>
		
		<!-- Scripts ? -->
		
		<div id="accordion">
			<h3><a href="#">Description</a></h3>
			<div>
				<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
					<p class="padding-bottom: 14px">
						<xsl:call-template name="string-replace-all">
						<xsl:with-param name="text" select="commentaires/commentaire1"/>
						<xsl:with-param name="replace" select="'\n'"/>
						<xsl:with-param name="by" select="'&lt;br/&gt;'"/>
						</xsl:call-template>
					</p>
				</xsl:if>
				
				<xsl:call-template name="periodes-ouverture"/>
				<![CDATA[ ]]>
			</div>
			
			<h3><a href="#">Carte/Itin&amp;eacute;raires</a></h3>
			<div>
				La carte et les itin&amp;eacute;raires...		
			</div>
			
			<h3><a href="#">Photos</a></h3>
			<div>
				<xsl:for-each select="newPhotos/newPhoto">
					<a>
						<xsl:attribute name="rel"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=306&amp;amp;mw=1</xsl:attribute>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="."/>&amp;amp;w=60&amp;amp;mw=1</xsl:attribute>
						</img>
					</a>
				</xsl:for-each>
				<![CDATA[ ]]>
			</div>
			
			<h3><a href="#">Avis</a></h3>
			<div>
				<xsl:choose>
					<xsl:when test="count(liensMultimedia/lienMultimedia[@type='image']) &gt; 0">
						<xsl:for-each select="liensMultimedia/lienMultimedia[@type='image' and string-length(codeHtmlLienMultimedia) &gt; 0]">
							<div><xsl:value-of select="codeHtmlLienMultimedia"/></div>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<p>
							Aucun avis pour le moment.<br />
							Soyez le premier : <a target="_blank" href="http://www.tripadvisor.fr/Tourism-g196666-Les_Sables_d_Olonne_Vendee_Pays_de_la_Loire-Vacations.html">Votre avis</a>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
		<br />
		
		<xsl:if test="string-length($lienPrecedent) &gt; 0">
			<div class="result-suiv">
				<a class="retour">
					<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if>#fiche-<xsl:value-of select="@id"/></xsl:attribute>
					&amp;lt;&amp;nbsp;<xsl:value-of select="$termeRetourListe"/>
				</a>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
