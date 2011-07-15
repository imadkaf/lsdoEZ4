<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&amp;key=ABQIAAAAOZJQqoDBwAknMtPNKR-dvRSi2OoyjRwg8X5jAJmNj4togrBv2xSClpdvpd4FJNt4C5i-i6aTtWzs-g"></script>

<div class="popin-container">
	<div class="popin-top">
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

			<script type="text/javascript">
				var Demo = {ldelim}
				  // HTML Nodes
				  mapContainer: document.getElementById('map-container'),
				  dirContainer: document.getElementById('dir-container'),
				  fromInput: document.getElementById('from-input'),
				  toInput:"{ezhttp( 'coord', 'get' )}",
				  travelModeInput: document.getElementById('travel-mode-input'),
				  unitInput: document.getElementById('unit-input'),
	
				  // API Objects
				  dirService: new google.maps.DirectionsService(),
				  dirRenderer: new google.maps.DirectionsRenderer(),
				  map: null,
	
				  showDirections: function(dirResult, dirStatus) {ldelim}
					if (dirStatus != google.maps.DirectionsStatus.OK) {ldelim}
					  alert('Directions failed: ' + dirStatus);
					  return;
					{rdelim}
	
					// Show directions
					Demo.dirRenderer.setMap(Demo.map);
					Demo.dirRenderer.setPanel(Demo.dirContainer);
					Demo.dirRenderer.setDirections(dirResult);
				  {rdelim},
	
				  getSelectedTravelMode: function() {ldelim}
					var value =
						Demo.travelModeInput.options[Demo.travelModeInput.selectedIndex].value;
					if (value == 'driving') {ldelim}
					  value = google.maps.DirectionsTravelMode.DRIVING;
					{rdelim} else if (value == 'bicycling') {ldelim}
					  value = google.maps.DirectionsTravelMode.BICYCLING;
					{rdelim} else if (value == 'walking') {ldelim}
					  value = google.maps.DirectionsTravelMode.WALKING;
					{rdelim} else {ldelim}
					  alert('Unsupported travel mode.');
					{rdelim}
					return value;
				  {rdelim},
	
				  getSelectedUnitSystem: function() {ldelim}
					return Demo.unitInput.options[Demo.unitInput.selectedIndex].value == 'metric' ?
						google.maps.DirectionsUnitSystem.METRIC :
						google.maps.DirectionsUnitSystem.IMPERIAL;
				  {rdelim},
	
				  getDirections: function() {ldelim}
					var fromStr = Demo.fromInput.value;
					var toStr = Demo.toInput;
					var dirRequest = {ldelim}
					  origin: fromStr,
					  destination: toStr,
					  travelMode: Demo.getSelectedTravelMode(),
					  unitSystem: Demo.getSelectedUnitSystem(),
					  provideRouteAlternatives: true
					{rdelim};
					Demo.dirService.route(dirRequest, Demo.showDirections);
				  {rdelim},
	
				  init: function() {ldelim}
					var latLng = new google.maps.LatLng(46.5, -1.7833);
					Demo.map = new google.maps.Map(Demo.mapContainer, {ldelim}
					  zoom: 13,
					  center: latLng,
					  mapTypeId: google.maps.MapTypeId.ROADMAP
					{rdelim});
	
					// Show directions onload
					Demo.getDirections();
				  {rdelim}
				{rdelim};
	
				// Onload handler to fire off the app.
				google.maps.event.addDomListener(window, 'load', Demo.init);
			</script>

		</div>
	</div>
</div>
