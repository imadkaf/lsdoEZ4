<div class="popin-container">
	<div class="popin-top" style="margin-bottom: 10px;">
		<p><a href="#" class="popin-close" title="Fermer la popin"><span>Fermer</span></a><p>
	</div>
	<hr />
	<div class="popin-content">
		<div class="popin-content-bloc">
				
			<div id="side-container">
				<ul>
					<li class="dir-label">Départ :</li>
					<li><input id="from-input" type=text value="Les Sables d'Olonne"/></li>
					<br clear="both"/>
					<br />
					<li class="dir-label">Arrivée :</li>
					<li class="lieu-arrivee">{ezhttp( 'nom', 'get' )}</li>
					<br /><br />
				</ul>
				<div>
					<select onchange="Demo.getDirections();" id="travel-mode-input">
						<option value="driving" selected="selected">En voiture</option>
						<option value="bicycling">A vélo</option>
						<option value="walking">A pied</option>
					</select>
					<select onchange="Demo.getDirections();" id="unit-input">
						<option value="metric" selected="selected">Km</option>
						<option value="imperial">Miles</option>
					</select>
					<input onclick="Demo.getDirections();" type=button value="Itinéraire"/>
				</div>
				<br />
				<div id="dir-container"></div>
			</div>
			<div id="map-container"></div>
		</div>
	</div>
</div>
