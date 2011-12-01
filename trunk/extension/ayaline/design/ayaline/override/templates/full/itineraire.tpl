<div class="popin-container">
	<div class="popin-top" style="margin-bottom: 10px;">
		<p><a href="#" class="popin-close" title="Fermer la popin"><span>{"Close"|i18n("ayaline")}</span></a><p>
	</div>
	<hr />
	<div class="popin-content">
		<div class="popin-content-bloc">
				
			<div id="side-container">
				<ul>
					<li class="dir-label">{"Start"|i18n("ayaline")}Départ :</li>
					<li><input id="from-input" type=text value="Office de tourisme des Sables d'Olonne, 1, promenade Joffre, 85100 Les Sables d'Olonne"/></li>
					<br clear="both"/>
					<br />
					<li class="dir-label">{"Finish"|i18n("ayaline")}Arrivée :</li>
					<li class="lieu-arrivee">{ezhttp( 'nom', 'get' )}</li>
					<br /><br />
				</ul>
				<div>
					<select onchange="Demo.getDirections();" id="travel-mode-input">
						<option value="driving" selected="selected">{"By car"|i18n("ayaline")}</option>
						<option value="bicycling">{"By bike"|i18n("ayaline")}</option>
						<option value="walking">{"On foot"|i18n("ayaline")}A pied</option>
					</select>
					<select onchange="Demo.getDirections();" id="unit-input">
						<option value="metric" selected="selected">Km</option>
						<option value="imperial">Miles</option>
					</select>
					<input onclick="Demo.getDirections();" type=button value="{'Route'|i18n('ayaline')}"/>
				</div>
				<br />
				<div id="dir-container"></div>
			</div>
			<div id="map-container"></div>
		</div>
	</div>
</div>
