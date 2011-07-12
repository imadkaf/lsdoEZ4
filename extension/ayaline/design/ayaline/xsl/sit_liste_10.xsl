<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="amp">&amp;</xsl:variable>
	<xsl:variable name="espace" select="' '"/>

	<xsl:include href="inc/string_replace_all.xsl"/>
	<xsl:include href="inc/enhanced_substring.xsl"/>

	<xsl:variable name="nbPagesMax" select="3"/>
	<xsl:include href="inc/pagination.xsl"/>

	<xsl:include href="inc/periodes_ouverture.xsl"/>

	<xsl:template match="/">
	
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"><![CDATA[ ]]></script>
		<script type="text/javascript">
			<![CDATA[
				function initialize() {
					//Mettre les coordonnees du centre des Sables d'Olonne
					var latlng = new google.maps.LatLng(46.1667, -1.15);
					
					var myOptions = {
						zoom: 13,
						center: latlng,
						scrollwheel: false,
						mapTypeId: google.maps.MapTypeId.ROADMAP
					};
					
					var map = new google.maps.Map(document.getElementById("mapContainerListe"), myOptions);

					]]>
					<xsl:if test="count(resultats/produit) &gt; 0">
						<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)]">
							<xsl:if test="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite != '' and criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite != ''">
								<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(translate(translate(intitule, concat('/-?_.', $apos, $amp), '       '), $caracteresKo, $caracteresOk), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
								<![CDATA[
									var contentString = '<div class="moninfobulle">'+
											'<div class="titre"><h3>]]><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="intitule"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><![CDATA[</h3>'+
											']]><xsl:choose>
													<xsl:when test="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite != ''">
														<img alt="" class="etoile">
															<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
															<xsl:attribute name="title"><![CDATA[Cat&eacute;gorie : ]]><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/></xsl:attribute>
														</img>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/>
													</xsl:otherwise>
												</xsl:choose><![CDATA[</div>'+
											']]><xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
													<img class="float-g photo" alt="">
														<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/><xsl:value-of select="newPhotos/newPhoto"/></xsl:attribute>
													</img>
												</xsl:if><![CDATA['+
											'<span class="float-d">]]><xsl:value-of select="ville/intituleVille"/><![CDATA[</span><br />'+
											']]><xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
													<xsl:variable name="commentaire1Nettoye">
														<xsl:call-template name="string-replace-all">
															<xsl:with-param name="text" select="commentaires/commentaire1"/>
															<xsl:with-param name="replace" select="'\n'"/>
															<xsl:with-param name="by" select="' '"/>
														</xsl:call-template>
													</xsl:variable>
													<xsl:variable name="commentaire1NettoyeCoupe">
														<xsl:if test="string-length($commentaire1Nettoye) &lt;= 200">
															<xsl:value-of select="$commentaire1Nettoye"/>
														</xsl:if>
														<xsl:if test="string-length($commentaire1Nettoye) &gt; 200">
															<xsl:call-template name="enhanced-substring">
																<xsl:with-param name="text" select="$commentaire1Nettoye"/>
																<xsl:with-param name="currentSize" select="0"/>
																<xsl:with-param name="totalSize" select="200"/>
																<xsl:with-param name="delimiter" select="' '"/>
															</xsl:call-template>
														</xsl:if>
													</xsl:variable>
													<p class="commentaire">
														<xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="$commentaire1NettoyeCoupe"/><xsl:with-param name="replace" select="$apos"/><xsl:with-param name="by" select="'&amp;apos;'"/></xsl:call-template><xsl:if test="string-length($commentaire1Nettoye) &gt; 200">&amp;hellip;</xsl:if>
													</p>
												</xsl:if><![CDATA[<div class="clear"></div>'+
											'<p class="lien">]]>
												<a class="float-g">
													<xsl:attribute name="href">#</xsl:attribute>
													<![CDATA[<b>>> Itin&eacute;raire</b>]]>
												</a>
												<a class="float-d">
													<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
													<![CDATA[<b>>> En savoir plus / R&eacute;server</b>]]>
												</a>
											<![CDATA[</p>'+
										'</div>';

									var infowindow = new google.maps.InfoWindow({
										content: contentString,
										maxWidth: 300
									});

									var marker = new google.maps.Marker({
										position: new google.maps.LatLng(]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000001']/valModalite"/><![CDATA[,]]><xsl:value-of select="criteres/critere[@id='999000149']/modalites/modalite[@id='999000149000002']/valModalite"/><![CDATA[),
										map: map,
										icon: '/extension/ayaline/design/ayaline/images/picto-hotel.png',
										title:"]]><xsl:value-of select="intitule"/><![CDATA["
									});
									
									marker._infowindow = infowindow;
									
									google.maps.event.addListener(marker, 'click', function() {
										this._infowindow.open(map, this);
									});
								]]>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
			<![CDATA[
				}
			]]>
		</script>
		<div id="mapContainerListe" style="width:635px;height:400px;margin-bottom:10px;border: 1px solid #E9E3DE;"><![CDATA[ ]]></div>
		<script type="text/javascript">
			<![CDATA[
				initialize();
			]]>
		</script>
		
		<span class="picto-hotel">H&amp;ocirc;tels</span>

		<xsl:call-template name="nb-produits"/>
		<xsl:if test="count(resultats/produit) &gt; 0">
			<ul class="list-inline-bis">
				<xsl:for-each select="resultats/details/detail[position() &gt;= 1 and position() &lt;= 2]">
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(translate(translate(intitule, concat('/-?_.', $apos, $amp), '       '), $caracteresKo, $caracteresOk), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<xsl:if test="position() = 1">
							<xsl:attribute name="class">first</xsl:attribute>
						</xsl:if>
						<a><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
						<h3 class="titre-top2">
							<a class="top2"><xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute><xsl:value-of select="intitule"/></a>
							<xsl:choose>
								<xsl:when test="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite != ''">
									<img alt="" class="float-g">
										<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
										<xsl:attribute name="title">Cat&amp;eacute;gorie : <xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/></xsl:attribute>
									</img>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/>
								</xsl:otherwise>
							</xsl:choose>
						</h3>
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
						
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img alt="">
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=280</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(newPhotos/newPhoto) = 0">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						
						<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0]) &gt; 0">
							<ul class="criteres liste-hotel">
								<xsl:for-each select="criteres/critere">
									<xsl:variable name="idCritere" select="@id"/>
									<xsl:variable name="intituleCritere" select="intCritere"/>
									<xsl:if test="$idCritere != '400002615' and $idCritere != '400002787' and $idCritere != '400003056' and $idCritere != '999000149'">
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
																<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="intModalite"/></strong>
															</xsl:if>
														</xsl:if>
														<xsl:if test="string-length(valModalite) &gt; 0">
															<xsl:if test="string-length(intModalite) &gt; 0">&amp;bull;&amp;nbsp;<xsl:value-of select="intModalite"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="valModalite"/></strong>
														</xsl:if>
														<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 1 or count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) &gt; 0">
															<xsl:if test="position() &lt; count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))])">, <xsl:if test="string-length(valModalite) &gt; 0"><br/></xsl:if></xsl:if>
														</xsl:if>
													</xsl:for-each>
												</div>
											</li>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</ul>
						</xsl:if>
						
						<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
							<xsl:variable name="commentaire1Nettoye">
								<xsl:call-template name="string-replace-all">
									<xsl:with-param name="text" select="commentaires/commentaire1"/>
									<xsl:with-param name="replace" select="'\n'"/>
									<xsl:with-param name="by" select="' '"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="commentaire1NettoyeCoupe">
								<xsl:if test="string-length($commentaire1Nettoye) &lt;= 200">
									<xsl:value-of select="$commentaire1Nettoye"/>
								</xsl:if>
								<xsl:if test="string-length($commentaire1Nettoye) &gt; 200">
									<xsl:call-template name="enhanced-substring">
										<xsl:with-param name="text" select="$commentaire1Nettoye"/>
										<xsl:with-param name="currentSize" select="0"/>
										<xsl:with-param name="totalSize" select="200"/>
										<xsl:with-param name="delimiter" select="' '"/>
									</xsl:call-template>
								</xsl:if>
							</xsl:variable>
							<p class="text" style="padding-top:5px;">
								<xsl:value-of select="$commentaire1NettoyeCoupe"/><xsl:if test="string-length($commentaire1Nettoye) &gt; 200">&amp;hellip;</xsl:if>
							</p>
						</xsl:if>
						
						<p class="lien-bas">
							<a class="picto3">
								<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
								En savoir plus
							</a>
							<a class="reserver" href="#">R&amp;eacute;server</a>
						</p>
					</li>
				</xsl:for-each>
			</ul>


			<ul class="list-block-bis">
				<xsl:for-each select="resultats/details/detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage) and position() &gt;= 3]">
					<xsl:variable name="ficheLien"><xsl:value-of select="$cheminRacineSite"/>/Fiche/Detail/<xsl:value-of select="@id"/>/<xsl:value-of select="$sitListeUrlAlias"/>/<xsl:value-of select="translate(normalize-space(translate(translate(translate(intitule, concat('/-?_.', $apos, $amp), '       '), $caracteresKo, $caracteresOk), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')), ' ', '-')"/><xsl:if test="$rechercheEnCours = 'oui'">/(recherche)/oui</xsl:if><xsl:if test="string-length($triEnCours) &gt; 0">/(tri)/<xsl:value-of select="$triEnCours"/></xsl:if><xsl:if test="string-length($pageCourante) &gt; 0 and $pageCourante &gt; 1">/(page)/<xsl:value-of select="$pageCourante"/></xsl:if></xsl:variable>
					<li>
						<xsl:attribute name="style"><xsl:if test="position() &lt; count(../detail[position() &gt;= ((($pageCourante - 1)*$nbItemsParPage) + 1) and position() &lt;= ($pageCourante * $nbItemsParPage)])"></xsl:if></xsl:attribute>
						<a><xsl:attribute name="id">fiche-<xsl:value-of select="@id"/></xsl:attribute><![CDATA[ ]]></a>
						<a>
							<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
							<img alt="">
								<xsl:if test="count(newPhotos/newPhoto) &gt;= 1">
									<xsl:attribute name="src"><xsl:value-of select="$cheminRacineSite"/>/Image/Resize?img=<xsl:value-of select="newPhotos/newPhoto"/>&amp;amp;w=150</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(newPhotos/newPhoto) = 0">
									<xsl:attribute name="src"><xsl:value-of select="$cheminImages"/>image_fiche_defaut_moyenne.jpg</xsl:attribute>
								</xsl:if>
							</img>
						</a>
						<div style="margin-left:160px; float:none;">
							<div class="titre-container">
								<xsl:if test="criteres/critere[@id='400002616']/modalites/modalite[1]/logoModalite != ''">
									<p>
										<img alt="">
											<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002616']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
											<xsl:attribute name="title">Cha&amp;icirc;nes d'h&amp;ocirc;tel : <xsl:value-of select="criteres/critere[@id='400002616']/modalites/modalite[1]/intModalite"/></xsl:attribute>
										</img>
									</p>
								</xsl:if>
								<h3>
									<a>
										<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
										<span class="float-g nom"><xsl:value-of select="intitule"/></span>
									</a>
									<xsl:choose>
	 											<xsl:when test="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite != ''">
											<img alt="">
												<xsl:attribute name="src"><xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/logoModalite"/></xsl:attribute>
												<xsl:attribute name="title">Cat&amp;eacute;gorie : <xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/></xsl:attribute>
											</img>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="criteres/critere[@id='400002615']/modalites/modalite[1]/intModalite"/>
										</xsl:otherwise>
									</xsl:choose>
								</h3>
								<ul class="ss-titre-bis">
									<li><xsl:value-of select="ville/intituleVille"/></li>
									<li class="last"><xsl:value-of select="criteres/critere[@id='400002787']/modalites/modalite[1]/intModalite"/></li>
								</ul>
							</div>
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
							
							<xsl:if test="count(criteres/critere[count(modalites/modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', ../../@id, '|'))]) &gt; 0]) &gt; 0">
								<ul class="criteres">
									<xsl:for-each select="criteres/critere">
										<xsl:variable name="idCritere" select="@id"/>
										<xsl:variable name="intituleCritere" select="intCritere"/>
										<xsl:if test="$idCritere != '400002616' and $idCritere != '400002615' and $idCritere != '400002787' and $idCritere != '400003056' and $idCritere != '999000149'">
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
																	<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) = 1 and count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) = 0"><xsl:value-of select="$intituleCritere"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="intModalite"/></strong>
																</xsl:if>
															</xsl:if>
															<xsl:if test="string-length(valModalite) &gt; 0">
																<xsl:if test="string-length(intModalite) &gt; 0">&amp;bull;&amp;nbsp;<xsl:value-of select="intModalite"/>&amp;nbsp;: </xsl:if><strong><xsl:value-of select="valModalite"/></strong>
															</xsl:if>
															<xsl:if test="count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))]) &gt; 1 or count(../modalite[(contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))) and string-length(valModalite) &gt; 0]) &gt; 0">
																<xsl:if test="position() &lt; count(../modalite[contains($criteresAffiches, concat('|', @id, '|')) or contains($criteresAffiches, concat('|', $idCritere, '|'))])">, <xsl:if test="string-length(valModalite) &gt; 0"><br/></xsl:if></xsl:if>
															</xsl:if>
														</xsl:for-each>
													</div>
												</li>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
								</ul>
							</xsl:if>
							
							<xsl:if test="string-length(commentaires/commentaire1) &gt; 0">
								<xsl:variable name="commentaire1Nettoye">
									<xsl:call-template name="string-replace-all">
										<xsl:with-param name="text" select="commentaires/commentaire1"/>
										<xsl:with-param name="replace" select="'\n'"/>
										<xsl:with-param name="by" select="' '"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:variable name="commentaire1NettoyeCoupe">
									<xsl:if test="string-length($commentaire1Nettoye) &lt;= 200">
										<xsl:value-of select="$commentaire1Nettoye"/>
									</xsl:if>
									<xsl:if test="string-length($commentaire1Nettoye) &gt; 200">
										<xsl:call-template name="enhanced-substring">
											<xsl:with-param name="text" select="$commentaire1Nettoye"/>
											<xsl:with-param name="currentSize" select="0"/>
											<xsl:with-param name="totalSize" select="200"/>
											<xsl:with-param name="delimiter" select="' '"/>
										</xsl:call-template>
									</xsl:if>
								</xsl:variable>
								<p class="text">
									<xsl:value-of select="$commentaire1NettoyeCoupe"/><xsl:if test="string-length($commentaire1Nettoye) &gt; 100">&amp;hellip;</xsl:if>
								</p>
							</xsl:if>
							
							<p class="lien-bas align-l">
								<a class="picto3">
									<xsl:attribute name="href"><xsl:value-of select="$ficheLien"/></xsl:attribute>
									En savoir plus
								</a>
								<a class="reserver" href="#">R&amp;eacute;server</a>
							</p>
						</div>
						<div style="clear:both"><span style="display:none">&amp;nbsp;</span></div>
					</li>
				</xsl:for-each>
			</ul>
			<xsl:call-template name="toute-pagination"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
