<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/periodes_ouverture_10.xsl"/>
	<xsl:include href="inc/display_dispos.xsl"/>
	<xsl:include href="inc/rendu_adresse.xsl"/>

	<xsl:template match="/produit">
		<xsl:if test="string-length($lienPrecedent) &gt; 0">
			<div style="text-align:right"><a>
				<xsl:attribute name="href"><xsl:value-of select="$lienPrecedent"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if>#fiche-<xsl:value-of select="@id"/></xsl:attribute>
				&amp;lt;&amp;lt;&amp;nbsp;<xsl:value-of select="$termeRetourListe"/>
			</a></div>
		</xsl:if>
		<br/>
		
		<div class="box-left">
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
				<div style="margin-top:5px;margin-bottom:17px">
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

			<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"><![CDATA[ ]]></script>
			<script type="text/javascript">
				<![CDATA[
					function initialize() {
					    var latlng = new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite"/><![CDATA[);
					    
					    var myOptions = {
					      zoom: 15,
					      center: latlng,
					      mapTypeId: google.maps.MapTypeId.ROADMAP
					    };
					    
					    var map = new google.maps.Map(document.getElementById("mapContainer"), myOptions);
					    
					    var marker = new google.maps.Marker({
						    position: latlng, 
						    map: map,
						    icon: '/extension/ayaline/design/ayaline/images/picto-hotel.png',
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
			
			<div class="form-rech">
				<span>Recherchez les disponibilites</span>
				<form method="post" action="#">
					<div class="date">
						<p class="label">Date arrivee :</p>
						<p class="agenda"><a href="#"><img alt="" src="/extension/ayaline/design/ayaline/images/agenda.gif" /></a></p>
						<label for="date-arrivee"></label>
						<select class="small" id="date-arrivee" name="date-arrivee">
							<option value="19">19</option>
						</select>
						<label class="none" for="mois">Mois</label>
						<select class="big" id="mois" name="mois">
							<option value="Fevrier">Fevrier</option>
						</select>
						<label class="none" for="annee">Annee</label>
						<select class="middle" id="annee" name="annee">
							<option value="2011">2011</option>
						</select>
					</div>
					<p class="clear"></p>
					<div class="duree">
						<p class="float-g">Duree :</p>
						<div class="float-g width-auto">
							<p>
								<input type="radio" id="semaine" name="semaine" />
								<label for="semaine" class="none">Semaine</label>											
							</p>
							<p>
								<input type="radio" id="nuit" name="nuit" />
								<label for="nuit" class="none">Nuit</label>											
							</p>
						</div>
						<div class="float-g width-auto">
							<p>
								<label class="none" for="nbre-semaine">Semaine</label>
								<select id="nbre-semaine" name="nbre-semaine">
									<option value="">1 semaine</option>
								</select>
							</p>
							<p class="none">
								<label class="none" for="nbre-nuit">Nuit</label>
								<select id="nbre-nuit" name="nbre-nuit">
									<option value="">1 nuit</option>
								</select>
							</p>
						</div>
					</div>
					<p class="clear"></p>
					<div class="nbr">
						<p class="float-g">												
							<label for="nb-ad">Nb d'adultes :</label>
						</p>
						<div class="float-g">												
							<select id="nb-ad" name="nb-ad">
								<option value="2 adultes">2 adultes</option>
							</select>
						</div>
					</div>
					<p class="clear"></p>
					<div class="nbr">
						<p class="float-g">												
							<label for="nb-enf">Nb d'enfants :</label>
						</p>
						<div class="float-g">												
							<select id="nb-enf" name="nb-enf">
								<option value="Aucun">Aucun</option>
							</select>
						</div>
					</div>
					<button class="button" type="submit">Rechechez les disponibilites</button>
				</form>
			</div>
		</div>
		
		<div class="box-right">
			<h2 class="bloc-liste-h2"><xsl:value-of select="intitule"/></h2>
			<xsl:choose>
				<xsl:when test="not(criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite = '')">
					<img alt="">
						<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
						<xsl:attribute name="title">Cat&amp;eacute;gorie : <xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/></xsl:attribute>
					</img>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<ul class="ss-titre-bis">
				<li><xsl:value-of select="ville/intituleVille"/></li>
				<li class="last"><xsl:value-of select="criteres/critere[@id='400002787']/modalites/modalite[1]/intModalite"/></li>
			</ul>
			
			<p class="ss-titre">
				<xsl:choose>
					<xsl:when test="criteres/critere[@id='400003056']/modalites/modalite[@id='400003056000001']/valModalite">
						<span class="picto">A partir de <span><xsl:value-of select="criteres/critere[@id='400003056']/modalites/modalite[@id='400003056000001']/valModalite"/> &amp;euro;</span></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="criteres/critere[@id='400003056']/modalites/modalite[@id='400003056000003']/valModalite">
							<span class="picto">A partir de <span><xsl:value-of select="criteres/critere[@id='400003056']/modalites/modalite[@id='400003056000003']/valModalite"/> &amp;euro;</span></span>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</p>
			<p class="lien-bas">
				<a class="reserver" href="#">R&amp;eacute;server</a>
			</p>
			<p class="clear"></p>
			
			<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
				<p class="padd-t12px-b14px">
					<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="commentaires/commentaire1"/>
					<xsl:with-param name="replace" select="'\n'"/>
					<xsl:with-param name="by" select="'&lt;br/&gt;'"/>
					</xsl:call-template>
				</p>
			</xsl:if>
			
			<ul class="inline">
				<xsl:if test="not(criteres/critere[@id='400002616']/modalites/modalite[1]/logoModalite = '')">
					<li>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002616']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
							<xsl:attribute name="title">Cha&amp;icirc;nes d'h&amp;ocirc;tel : <xsl:value-of select="criteres/critere[@id='400002616']/modalites/modalite[1]/intModalite"/></xsl:attribute>
						</img>
					</li>
				</xsl:if>
				<xsl:if test="not(criteres/critere[@id='999000107']/modalites/modalite[1]/logoModalite = '')">
					<li>
						<img alt="">
							<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='999000107']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
							<xsl:attribute name="title">Cha&amp;icirc;nes d'h&amp;ocirc;tel : <xsl:value-of select="criteres/critere[@id='999000107']/modalites/modalite[1]/intModalite"/></xsl:attribute>
						</img>
					</li>
				</xsl:if>
			</ul>
			
			<p>
				<xsl:if test="not(adresses/adresse[@type='produit']/ligne1 = '')">
					<xsl:value-of select="adresses/adresse[@type='produit']/ligne1"/>
					<xsl:if test="not(adresses/adresse[@type='produit']/ligne2 = '')">
						<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne2"/>
						<xsl:if test="not(adresses/adresse[@type='produit']/ligne3 = '')">
							<br /><xsl:value-of select="adresses/adresse[@type='produit']/ligne3"/>
						</xsl:if>
					</xsl:if>
				</xsl:if>
				<xsl:if test="not(adresses/adresse[@type='produit']/cp = '')">
					<br /><xsl:value-of select="adresses/adresse[@type='produit']/cp"/>
				</xsl:if>
				<xsl:if test="not(adresses/adresse[@type='produit']/commune = '')">
					&amp;nbsp;<xsl:value-of select="adresses/adresse[@type='produit']/commune"/>
				</xsl:if>
				<xsl:if test="not(adresses/adresse[@type='produit']/paysMonde = '')">
					<br /><xsl:value-of select="adresses/adresse[@type='produit']/paysMonde"/>
				</xsl:if>
			</p>
			<xsl:if test="not(adresses/adresse[@type='produit']/tel1 = '')">
				<div>T&amp;eacute;l : <xsl:value-of select="adresses/adresse[@type='produit']/tel1"/></div>
				<xsl:if test="not(adresses/adresse[@type='produit']/tel2 = '')">
					<div>Autre t&amp;eacute; : <xsl:value-of select="adresses/adresse[@type='produit']/tel2"/></div>
				</xsl:if>
			</xsl:if>
			<xsl:if test="not(adresses/adresse[@type='produit']/fax = '')">
				<div>Fax : <xsl:value-of select="adresses/adresse[@type='produit']/fax"/></div>
			</xsl:if>
			<xsl:if test="not(adresses/adresse[@type='produit']/email = '')">
				<div>Email : <a><xsl:attribute name="href">mailto:<xsl:value-of select="adresses/adresse[@type='produit']/email"/></xsl:attribute>
								<xsl:value-of select="adresses/adresse[@type='produit']/email"/></a>
				</div>
			</xsl:if>
			<xsl:if test="not(adresses/adresse[@type='produit']/web = '')">
				<div>Site web : <a><xsl:attribute name="href"><xsl:value-of select="adresses/adresse[@type='produit']/web"/></xsl:attribute>
									<xsl:value-of select="adresses/adresse[@type='produit']/web"/></a>
				</div>
			</xsl:if>

			<div>
				<ul class="inline">
					<li class="actif">
						<a href="#">Descriptif</a>
						<div class="texte" style="display:none;">
							<xsl:call-template name="periodes-ouverture"/>
						</div>
					</li>
					<li>
						<a href="#">Tarifs</a>
						<div class="texte" style="display:none;">
							<xsl:if test="criteres/critere[@id='400003056']/modalites">
								<table cellspacing="0" width="100%">
									<xsl:for-each select="criteres/critere[@id='400003056']/modalites/modalite">
										<tr>
											<td>
												<xsl:attribute name="style">width:70%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">7A7368</xsl:if><xsl:if test="(position() mod 2) = 0">E0E0E0</xsl:if>;color:#<xsl:if test="(position() mod 2) = 1">FFFFFF</xsl:if><xsl:if test="(position() mod 2) = 0">353535</xsl:if></xsl:attribute>
												<xsl:value-of select="intModalite"/>
											</td>
											<td>
												<xsl:attribute name="style">text-align:center;width:30%;vertical-align:top;font-size:90%;padding:5px 10px;background-color:#<xsl:if test="(position() mod 2) = 1">E4E0DB</xsl:if><xsl:if test="(position() mod 2) = 0">EEEEEE</xsl:if>;color:#353535</xsl:attribute>
												<xsl:value-of select="valModalite"/> &amp;euro;
											</td>
										</tr>
									</xsl:for-each>
								</table>
							</xsl:if>
						</div>
					</li>
					<li>
						<a href="#">Caract&amp;eacute;ristiques</a>
						<div class="texte">
							<xsl:if test="count(criteres/critere[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0]) &gt; 0">
								<table cellspacing="0" width="100%">
									<xsl:for-each select="criteres/critere[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|')))) or count(modalites/modalite[$modeAffichageCriteres = 'afficher_tout' or ($modeAffichageCriteres = 'afficher' and contains($criteresAffiches, concat('|', @id, '|'))) or ($modeAffichageCriteres = 'pas_afficher' and not(contains($criteresNonAffiches, concat('|', @id, '|'))) and not(contains($criteresNonAffiches, concat('|', ../../@id, '|'))))]) &gt; 0]">
										<xsl:if test="count(modalites/modalite) &gt; 0">
											<xsl:variable name="idCritere" select="@id"/>
											<!-- etoile 400002615, type : 400002787, prix 400003056, chaine 400002616, label 999000107 -->
											<xsl:if test="not($idCritere = '400002615') and not($idCritere = '400002787') and not($idCritere = '400003056') and not($idCritere = '400002616') and not($idCritere = '999000107')">
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
										</xsl:if>
									</xsl:for-each>
								</table>
							</xsl:if>
						</div>
					</li>
					<li class="last">
						<a href="#">Avis</a>
						<div class="texte" style="display:none;">
							<p>
								
							</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		<p class="clear"></p>
		<p class="space"></p>
		
		<div class="float-d" style="margin-bottom:10px;">
			<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pubid=xa-4db82bbb1279e354"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>
			<!-- deja present dans le menu pied de page <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4db82bbb1279e354"></script> -->
		</div>
		
		<p class="clear"></p>
	</xsl:template>
</xsl:stylesheet>