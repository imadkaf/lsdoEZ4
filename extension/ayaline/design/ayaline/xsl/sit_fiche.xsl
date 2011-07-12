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
		<div style="float:left; width: 326px;">
			<h2 class="bloc-liste-h2"><xsl:value-of select="intitule"/></h2>
			<p class="clear" style="margin-bottom:20px;"></p>
		
			<xsl:if test="count(newPhotos/newPhoto) &gt; 0">
				<div id="galleria" class="galerie-fiche">
					<xsl:for-each select="newPhotos/newPhoto">
						<a>
							<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
							<img>
								<xsl:attribute name="alt">""</xsl:attribute>
								<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
							</img>
						</a>
					</xsl:for-each>
					<script type="text/javascript">
						<![CDATA[
							// Load the classic theme
				   			Galleria.loadTheme("/extension/ayaline_gallery/design/standard/javascript/galleria/themes/classic/galleria.classic.min.js");
				    
							// Initialize Galleria
							$('#galleria').galleria({
								autoplay: 5000,
								lightbox: true
							});
						]]>
					</script>
				</div>
				<div class="clear"><![CDATA[ ]]></div><br />
			</xsl:if>
			
			<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"><![CDATA[ ]]></script>
			<script type="text/javascript">
				<![CDATA[
					function initialize() {
						]]>
						<xsl:choose>
							<xsl:when test="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite != '' and criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite != ''">
								<![CDATA[
							    	var latlng = new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite"/><![CDATA[);
							    ]]>
							</xsl:when>
							<xsl:otherwise>
								<![CDATA[
							    	var latlng = new google.maps.LatLng(46.162000, -1.1550);
							    ]]>
							</xsl:otherwise>
						</xsl:choose>
						
					    <![CDATA[
					    var myOptions = {
					      zoom: 15,
					      center: latlng,
					      scrollwheel: false,
					      mapTypeId: google.maps.MapTypeId.ROADMAP
					    };
					    
					    var map = new google.maps.Map(document.getElementById("mapContainer"), myOptions);
					    
					    var marker = new google.maps.Marker({
						    position: latlng, 
						    map: map,
							title:"]]><xsl:value-of select="intitule"/><![CDATA["
						});
				  	}
				]]>
			</script>
			<div class="map">
				<div id="mapContainer" style="width:325px;height:220px;"><![CDATA[ ]]></div>
			</div>
			<script type="text/javascript">
				<![CDATA[
					initialize();
				]]>
			</script>
			
			<div style="margin:15px 0px 15px 0px">
				<xsl:for-each select="adresses/adresse[@type='produit']">
					<div style="padding:15px;background-color:#EEEEEE;">
						<div><strong><xsl:value-of select="$termeAdresseFiche"/></strong></div>
						<xsl:call-template name="rendu-adresse"/>
					</div>
				</xsl:for-each>
				<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
			</div>
		</div>
		
		
		
		<div>
			<xsl:if test="string-length($lienPrecedent) &gt; 0">
				<div style="text-align:right; margin-top:10px;"><a>
					<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if>#fiche-<xsl:value-of select="@id"/></xsl:attribute>
					&amp;lt;&amp;lt;&amp;nbsp;<xsl:value-of select="$termeRetourListe"/>
				</a></div>
			</xsl:if>
			<br/>
			
			<table cellspacing="0" cellpadding="0" style="margin-top: 15px;">
				<tr><td style="padding:0 0 0 15px">
					<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
						<p><xsl:call-template name="string-replace-all">
							<xsl:with-param name="text" select="commentaires/commentaire1"/>
							<xsl:with-param name="replace" select="'\n'"/>
							<xsl:with-param name="by" select="'&lt;br/&gt;'"/>
						</xsl:call-template></p>
					</xsl:if>
					
					<xsl:call-template name="periodes-ouverture"/>
					<br />
					
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
					<xsl:for-each select="liensMultimedia/lienMultimedia[@type='sons' and string-length(codeHtmlLienMultimedia) &gt; 0]">
						<div style="margin:15px 0;text-align:center">
							<p>
								<a target="_blank">
									<xsl:attribute name="href"><xsl:value-of select="lienLienMultimedia"/></xsl:attribute>
									<strong><xsl:value-of select="titreLienMultimedia"/></strong> &amp;mdash; <span style="font-style:italic;color:#999999"><xsl:value-of select="creditLienMultimedia"/></span>
								</a>
							</p>
							<p><xsl:value-of select="descriptionLienMultimedia"/></p>
							<div><xsl:value-of select="codeHtmlLienMultimedia"/></div>
						</div>
					</xsl:for-each>
				</td></tr>
			</table>
		</div>
		
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
		
		<div style="float:left">
			<img alt="" style="float:right;margin-left:20px"><xsl:attribute name="src"><xsl:value-of select="partenaire/logoPartenaire"/></xsl:attribute></img><xsl:value-of select="$termeInformationProposeePar"/>&amp;nbsp;:<br/><strong><xsl:if test="string-length(partenaire/webPartenaire) &gt; 0"><a target="_blank"><xsl:attribute name="href"><xsl:value-of select="partenaire/webPartenaire"/></xsl:attribute><xsl:value-of select="partenaire/intPartenaire"/></a></xsl:if><xsl:if test="string-length(partenaire/webPartenaire) = 0"><xsl:value-of select="partenaire/intPartenaire"/></xsl:if></strong>
		</div>
		<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
	</xsl:template>
</xsl:stylesheet>
