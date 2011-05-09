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