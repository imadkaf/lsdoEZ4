<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	{include uri="design:page_head.tpl"}
	
	<body>
		
		{*$module_result.content*}
		
		<div id="global-page">
		
			<div id="header">

				<div class="header-in">
					<h1>
						<span class="style-png">
							<a href="#"><img src="/extension/ayaline/design/ayaline/images/logo.png" alt="" /></a>
						</span>
					</h1>
					<div class="header-in-right">
						<ul class="list-top">
							<li>Mardi 15 F&eacute;vrier</li>
							<li class="meteo">15&deg;c</li>
							<li><a href="#">Webcam</a></li>
							<li class="langue">
								<label for="langue" class="none">Langue</label>
								<fieldset class="conteneurSelect" id="langue">
									<div class="inputsSelect">
										<p onclick="showHideSelect('listeSelect1')" class="selects"><span class="Flag_en"></span></p>
										<ul id="listeSelect1">
											<li><a onclick="validAndHide('DE', this, 'countryCode', 'p')" href="javascript:void(0)"><span class="Flag_en"></span></a></li>
										</ul>
									</div>
									<input type="hidden" name="countryCode" />
								</fieldset>
							</li>
							<li class="last">
								<ul>
									<li class="img1"><span class="style-png"><a href="#"><img src="/extension/ayaline/design/ayaline/images/img1.png" alt="" /></a></span></li>
									<li class="img2"><span class="style-png"><a href="#"><img src="/extension/ayaline/design/ayaline/images/img2.png" alt="" /></a></span></li>
									<li class="img3"><span class="style-png"><a href="#"><img src="/extension/ayaline/design/ayaline/images/img3.png" alt="" /></a></span></li>
									<li class="last img4"><span class="style-png"><a href="#"><img src="/extension/ayaline/design/ayaline/images/img4.png" alt="" /></a></span></li>
								</ul>
							</li>
						</ul>
						<div class="search">
							<form method="post" action="#">
								<label for="recherche" class="none">Votre recherche</label>
								<input type="text" name="recherche" onblur="if(this.value=='')this.value='Votre recherche'" onfocus="if(this.value=='Votre recherche')this.value=''" value="Votre recherche" id="recherche" />
								<button type="submit"><span class="none">OK</span></button>
							</form>
						</div>
						<div class="clear"></div>
						<div class="menu">
							<ul>
								<li class="rubrique1">
									<a href="#"><span></span></a>
								</li>
								<li class="rubrique2">
									<a href="#"><span></span></a>
								</li>
								<li class="rubrique3 last">
									<a href="#"><span></span></a>
								</li>
							</ul>
						</div>
					</div>					
				</div>
				
				{include uri='design:diaporama.tpl'}
				
			</div>
			
			<div class="clear"></div>
			
			<div class="content">
				<div class="bloc-left">
					<div class="bloc-left-in">
					
						<div class="bloc-type">
							<h2>
								<img src="/extension/ayaline/design/ayaline/images/semerveiller.png" alt="" />
							</h2>
							<p class="clear"></p>
							<h3 class="type1">
								<img src="/extension/ayaline/design/ayaline/images/je-decouvre.png" alt="" />
							</h3>
							<img class="spec" src="/extension/ayaline/design/ayaline/images/illustration1.png" alt="" />
							<h4>Les sorties en mer</h4>
							<p>
								Ex his quidam aeternitati se commendari posse per statuas aestimantes eas ardenter.
								Quas rontes ambiens amnis imosque pedes Cassii montis illius celsi praetermeans funditur. 
							</p>
							<p class="lien-bas">	
								<a class="type1" href="#">En savoir plus</a>
							</p>
						</div>
						
						<div class="bloc-type">
							<h2>
								<img src="/extension/ayaline/design/ayaline/images/idees-sejours.png" alt="" />
							</h2>
							<p class="clear"></p>
							<h3 class="type2">
								<img src="/extension/ayaline/design/ayaline/images/printemps-2011.png" alt="" />
							</h3>
							<img src="/extension/ayaline/design/ayaline/images/illustration2.png" alt="" />
							<h4>D&eacute;couvrez les meilleures offres printemps-Et&eacute; 2011</h4>
							<p>
								<strong>Forfaits week-ends, semaine, courts-s&eacute;jours...</strong> Profitez d'une 
								escapade iod&eacute;e sur la C&ocirc;te de Lumi&egrave;re aux Sables d'Olonne.
							</p>
							<p class="lien-bas">	
								<a class="type2" href="#">En savoir plus</a>
							</p>
						</div>
						
					</div>
					<div class="bloc-right-in">
					
						<div class="bloc-type">
							<h2>
								<img src="/extension/ayaline/design/ayaline/images/vivre.png" alt="" />
							</h2>
							<a href="#" class="float-d"><img src="/extension/ayaline/design/ayaline/images/rss.gif" alt="" /></a>
							<p class="clear"></p>
							<h3 class="type3">
								<img src="/extension/ayaline/design/ayaline/images/je-minforme.png" alt="" />
							</h3>
							<ul>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration3.png" alt="" /></a>
									<h4>
										<a href="#">3e Grand festival
										d&eacute;partemental de magie</a>
									</h4>
									<p class="l-spacing">
										<span class="display-block">Du 09/02/2011 au 20/02/2011</span>
										Rue du 8 mai 1945 - Le Havre d'Olonne
									</p>
								</li>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration4.png" alt="" /></a>
									<h4><a href="#">Spectacle de No&euml;l - fantaisie polaire</a></h4>
									<p class="l-spacing">
										<span class="display-block">Le 11/12/2010 &agrave; 11h et 14h</span>
										Biblioth&egrave;que Municipale - Les Sables d'Olonne 
									</p>
								</li>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration5.png" alt="" /></a>
									<h4><a href="#">Th&eacute;&acirc;tre Atlante</a></h4>
									<p class="l-spacing">										
										<span class="display-block">Le 14/12/2010</span>
										La M&eacute;daille- spectacle de Zabou Breitman<br />
										Les Sables d'Olonne
									</p>
								</li>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration6.png" alt="" /></a>
									<h4><a href="#">sortie d&eacute;couverte<br />du rivage</a></h4>
									<p class="l-spacing">Le 23 d&eacute;cembre 2010 - Paracou</p>
								</li>
							</ul>
							<p class="lien-bas">	
								<a class="type3" href="#">En savoir plus</a>
							</p>
						</div>
						
						<div class="bloc-type spec">
							<h2>
								<img src="/extension/ayaline/design/ayaline/images/mes-sables-dolonne.png" alt="" />
							</h2>
							<a href="#" class="float-d"><img src="/extension/ayaline/design/ayaline/images/rss.gif" alt="" /></a>
							<p class="clear"></p>
							<h3 class="type4">
								<img src="/extension/ayaline/design/ayaline/images/partagez-vos-emotions.png" alt="" />
							</h3>
							<ul>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration7.png" alt="" /></a>
									<h4>
										<a href="#">Nam quis hoc non sentit</a>
									</h4>
									<p>
										Patres conscripti, nos hoc tempore in provinciis decernendis perpetuae pacis habere oportere rationem. Nam quis hoc non sentit omnia alia esse...
									</p>
								</li>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration8.png" alt="" /></a>
									<h4><a href="#">Tempore in provinciis</a></h4>
									<p>
										Patres conscripti, nos hoc tempore in provinciis decernendis perpetuae pacis habere oportere rationem. Nam quis hoc non sentit omnia alia esse... 
									</p>
								</li>
								<li>
									<a href="#"><img src="/extension/ayaline/design/ayaline/images/illustration9.png" alt="" /></a>
									<h4><a href="#">Ego vero sic intellego</a></h4>
									<p>										
										Patres conscripti, nos hoc tempore in provinciis decernendis perpetuae pacis habere oportere rationem. Nam quis hoc non sentit omnia alia esse...
									</p>
								</li>
							</ul>
							<p class="lien-bas">	
								<a class="type4" href="#">En savoir plus</a>
							</p>
						</div>
						
					</div>
				</div>
				<div class="bloc-right">
				
					<div class="bloc-type">
						<h2>
							<img src="/extension/ayaline/design/ayaline/images/reserver.png" alt="" />
						</h2>
						<p class="clear"></p>
						<h3 class="type5">
							<img src="/extension/ayaline/design/ayaline/images/je-recherche.png" alt="" />
						</h3>
						<div class="form">
							<form method="post" action="#">
								<div>
									<label for="hôtels" class="none">H&ocirc;tels</label>
									<select name="hôtels" id="hôtels">
										<option value="Hôtels">H&ocirc;tels</option>
									</select>
								</div>
								<div class="date">
									<p>Date arriv&eacute;e :</p>
									<p class="agenda"><a href="#"><img src="/extension/ayaline/design/ayaline/images/agenda.gif" alt="" /></a></p>
									<label for="date-arrivee"></label>
									<select name="date-arrivee" id="date-arrivee" class="small">
										<option value="19">19</option>
									</select>

									<label for="mois" class="none">Mois</label>
									<select name="mois" id="mois" class="big">
										<option value="Février">F&eacute;vrier</option>
									</select>
									<label for="annee" class="none">Ann&eacute;e</label>
									<select name="annee" id="annee" class="middle">
										<option value="2011">2011</option>
									</select>
								</div>
								<div class="clear"></div>
								<div class="duree">
									<p class="float-g">Dur&eacute;e :</p>
									<div class="float-g">
										<p>
											<input type="radio" name="semaine" id="semaine" />
											<label for="semaine">Semaine</label>											
										</p>
										<p>
											<input type="radio" name="nuit" id="nuit" />
											<label for="nuit">Nuit</label>											
										</p>
									</div>
									<div class="float-g">
										<p>
											<label for="nbre-semaine" class="none">Semaine</label>
											<select name="nbre-semaine" id="nbre-semaine">
												<option value="">1 semaine</option>
											</select>
										</p>
										<p class="none">
											<label for="nbre-nuit" class="none">Nuit</label>
											<select name="nbre-nuit" id="nbre-nuit">
												<option value="">1 nuit</option>
											</select>
										</p>
									</div>
								</div>
								<div class="clear"></div>
								<div class="situation">
									<label for="situation"><strong>Situation :</strong></label>
									<select name="situation" id="situation">
										<option value="Indifférent">Indiff&eacute;rent</option>
									</select>								
								</div>
								<div class="clear"></div>
								<button type="submit" class="button">
									<div class="bt-bg-t">
										<div class="bt-bg-b">
											<div class="bt-bg-l">
												<div class="bt-bg-r">
													<div class="bt-bg-hl">
														<div class="bt-bg-hr">
															<div class="bt-bg-bl">
																<div class="bt-bg-br">
																	<span class="picto-bt">Rechercher les disponibilit&eacute;s</span>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</button>
								<ul class="liste-bottom">
									<li>
										<a href="#">Activit&eacute;, visite</a>
									</li>
									<li>
										<a href="#">Site touristique, festival</a>
									</li>
									<li>
										<a href="#">Id&eacute;es S&eacute;jours</a>
									</li>
									<li>
										<a href="#">Bons plans</a>
									</li>
									<li>
										<a href="#">Acc&egrave;s</a>
									</li>
								</ul>
							</form>
						</div>
					</div>
					
					<div class="bloc-type-bis">
						<div class="bg-a">
							<h2>Groupes/<br />affaires</h2>
							<p>
								D&eacute;couvrez nos offres 
								r&eacute;serv&eacute;es aux groupes 
								et aux entreprises
							</p>
						</div>
					</div>
					
					<div class="bloc-type-bis">
						<div class="bg-b">
							<h2>M&eacute;dias</h2>
							<ul class="list-inline">
								<li class="lien-a"><a href="#">Visite<br />virtuelle</a></li>
								<li class="lien-b"><a href="#">Phototh&egrave;que</a></li>
								<li class="lien-c"><a href="#">Webcams</a></li>
							</ul>
						</div>
					</div>
					
					<div class="bloc-type-bis">
						<div class="bg-c">
							<h2>Brochures</h2>
							<p>
								D&eacute;couvrez 
								tous les guides 2011
								des Sables d'Olonne
							</p>
							<p class="lien-bas">	
								<a href="#" class="type3">Toutes les brochures</a>
							</p>
						</div>
					</div>
					
				</div>
				
				{include uri="design:page_footer.tpl"}
				
			</div>
			
		</div>
		
	</body>
	
</html>
