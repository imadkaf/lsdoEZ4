{*
	Noeud courant :
		Cette variable est accessible dans toutes les templates de l'application et doit être réutilisé
*}
{def $cNode = fetch(content, node, hash(node_id, $module_result.node_id))}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
{include uri="design:page_head.tpl"}
	<body>
		<div id="global-page">
			<div id="header">
				{include uri='design:full/diaporama.tpl'}
				<div class="header-in">
					<h1>
						<span class="style-png">
							<a href="#"><img src={"logo.png"|ezimage} alt="" /></a>
						</span>
					</h1>
					<div class="header-in-right">
						<ul class="list-top">
							<li>Mardi 15 Février</li>
							<li class="meteo">15°c</li>
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
									<li class="img1"><span class="style-png"><a href="#"><img src={"img1.png"|ezimage} alt="" /></a></span></li>
									<li class="img2"><span class="style-png"><a href="#"><img src={"img2.png"|ezimage} alt="" /></a></span></li>
									<li class="img3"><span class="style-png"><a href="#"><img src={"img3.png"|ezimage} alt="" /></a></span></li>
									<li class="last img4"><span class="style-png"><a href="#"><img src={"img4.png"|ezimage} alt="" /></a></span></li>
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
				<!-- Slideshow controls -->
				<div id="headernav-outer">						
					<div class="btns-carres" id="headernav">
						<a class="btn" id="back" href="#"><span></span></a>
						<a class="btn" id="control" href="#"><span></span></a>
						<a class="btn" id="next" href="#"><span></span></a>
					</div>
				</div>
				<!-- jQuery handles for the text displayed on top of the images -->
				<div id="headertxt">
					<p class="caption">
						<span id="firstline"></span>
						<a href="#" id="secondline" target="_top"></a>
					</p>
				</div>
			</div>
			<div class="clear"></div>
			<div class="content">
				<div class="bloc-left">
					<div class="bloc-left-in">
						<div class="bloc-type">
							<h2>
								<img src={"semerveiller.png"|ezimage} alt="" />
							</h2>
							<p class="clear"></p>
							<h3 class="type1">
								<img src={"je-decouvre.png"|ezimage} alt="" />
							</h3>
							<img class="spec" src={"illustration1.png"|ezimage} alt="" />
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
								<img src={"idees-sejours.png"|ezimage} alt="" />
							</h2>
							<p class="clear"></p>
							<h3 class="type2">
								<img src={"printemps-2011.png"|ezimage} alt="" />
							</h3>
							<img src={"illustration2.png"|ezimage} alt="" />
							<h4>Découvrez les meilleures offres printemps-Eté 2011</h4>
							<p>
								<strong>Forfaits week-ends, semaine, courts-séjours...</strong> Profitez d'une 
								escapade iodée sur la Côte de Lumière aux Sables d'Olonne.
							</p>
							<p class="lien-bas">	
								<a class="type2" href="#">En savoir plus</a>
							</p>
						</div>
					</div>
					<div class="bloc-right-in">
						<div class="bloc-type">
							<h2>
								<img src={"vivre.png"|ezimage} alt="" />
							</h2>
							<a href="#" class="float-d"><img src={"rss.gif"|ezimage} alt="" /></a>
							<p class="clear"></p>
							<h3 class="type3">
								<img src={"je-minforme.png"|ezimage} alt="" />
							</h3>
							<ul>
								<li>
									<a href="#"><img src={"illustration3.png"|ezimage} alt="" /></a>
									<h4>
										<a href="#">3e Grand festival
										départemental de magie</a>
									</h4>
									<p class="l-spacing">
										<span class="display-block">Du 09/02/2011 au 20/02/2011</span>
										Rue du 8 mai 1945 - Le Havre d'Olonne
									</p>
								</li>
								<li>
									<a href="#"><img src={"illustration4.png"|ezimage} alt="" /></a>
									<h4><a href="#">Spectacle de Noël - fantaisie polaire</a></h4>
									<p class="l-spacing">
										<span class="display-block">Le 11/12/2010 à 11h et 14h</span>
										Bibliothèque Municipale - Les Sables d'Olonne 
									</p>
								</li>
								<li>
									<a href="#"><img src={"illustration5.png"|ezimage} alt="" /></a>
									<h4><a href="#">Théâtre Atlante</a></h4>
									<p class="l-spacing">										
										<span class="display-block">Le 14/12/2010</span>
										La Médaille- spectacle de Zabou Breitman<br />
										Les Sables d'Olonne
									</p>
								</li>
								<li>
									<a href="#"><img src={"illustration6.png"|ezimage} alt="" /></a>
									<h4><a href="#">sortie découverte<br />du rivage</a></h4>
									<p class="l-spacing">Le 23 décembre 2010 - Paracou</p>
								</li>
							</ul>
							<p class="lien-bas">	
								<a class="type3" href="#">En savoir plus</a>
							</p>
						</div>
						<div class="bloc-type spec">
							<h2>
								<img src={"mes-sables-dolonne.png"|ezimage} alt="" />
							</h2>
							<a href="#" class="float-d"><img src={"rss.gif"|ezimage} alt="" /></a>
							<p class="clear"></p>
							<h3 class="type4">
								<img src={"partagez-vos-emotions.png"|ezimage} alt="" />
							</h3>
							<ul>
								<li>
									<a href="#"><img src={"illustration7.png"|ezimage} alt="" /></a>
									<h4>
										<a href="#">Nam quis hoc non sentit</a>
									</h4>
									<p>
										Patres conscripti, nos hoc tempore in provinciis decernendis perpetuae pacis habere oportere rationem. Nam quis hoc non sentit omnia alia esse...
									</p>
								</li>
								<li>
									<a href="#"><img src={"illustration8.png"|ezimage} alt="" /></a>
									<h4><a href="#">Tempore in provinciis</a></h4>
									<p>
										Patres conscripti, nos hoc tempore in provinciis decernendis perpetuae pacis habere oportere rationem. Nam quis hoc non sentit omnia alia esse... 
									</p>
								</li>
								<li>
									<a href="#"><img src={"illustration9.png"|ezimage} alt="" /></a>
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
							<img src={"reserver.png"|ezimage} alt="" />
						</h2>
						<p class="clear"></p>
						<h3 class="type5">
							<img src={"je-recherche.png"|ezimage} alt="" />
						</h3>
						<div class="form">
							<form method="post" action="#">
								<div>
									<label for="hôtels" class="none">Hôtels</label>
									<select name="hôtels" id="hôtels">
										<option value="Hôtels">Hôtels</option>
									</select>
								</div>
								<div class="date">
									<p>Date arrivée :</p>
									<p class="agenda"><a href="#"><img src={"agenda.gif"|ezimage} alt="" /></a></p>
									<label for="date-arrivee"></label>
									<select name="date-arrivee" id="date-arrivee" class="small">
										<option value="19">19</option>
									</select>
									<label for="mois" class="none">Mois</label>
									<select name="mois" id="mois" class="big">
										<option value="Février">Février</option>
									</select>
									<label for="annee" class="none">Année</label>
									<select name="annee" id="annee" class="middle">
										<option value="2011">2011</option>
									</select>
								</div>
								<div class="clear"></div>
								<div class="duree">
									<p class="float-g">Durée :</p>
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
										<option value="Indifférent">Indifférent</option>
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
																	<span class="picto-bt">Rechercher les disponibilités</span>
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
										<a href="#">Activité, visite</a>
									</li>
									<li>
										<a href="#">Site touristique, festival</a>
									</li>
									<li>
										<a href="#">Idées Séjours</a>
									</li>
									<li>
										<a href="#">Bons plans</a>
									</li>
									<li>
										<a href="#">Accès</a>
									</li>
								</ul>
							</form>
						</div>
					</div>
					<div class="bloc-type-bis">
						<div class="bg-a">
							<h2>Groupes/<br />affaires</h2>
							<p>
								Découvrez nos offres 
								réservées aux groupes 
								et aux entreprises
							</p>
						</div>
					</div>
					<div class="bloc-type-bis">
						<div class="bg-b">
							<h2>Médias</h2>
							<ul class="list-inline">
								<li class="lien-a"><a href="#">Visite<br />virtuelle</a></li>
								<li class="lien-b"><a href="#">Photothèque</a></li>
								<li class="lien-c"><a href="#">Webcams</a></li>
							</ul>
						</div>
					</div>
					<div class="bloc-type-bis">
						<div class="bg-c">
							<h2>Brochures</h2>
							<p>
								Découvrez 
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
{undef $cNode}