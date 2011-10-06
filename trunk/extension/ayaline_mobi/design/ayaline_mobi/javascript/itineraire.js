var pos;
var map;
var dirService;
var dirRenderer;

function initialize() {
	$('.map-js-container').removeClass('map-js-container').get(0).innerHTML = '<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true&amp;key=ABQIAAAAPzlBh0JjFUPqZKi3n0L3LxRNhXKcoHc6ILCDtHOsJEw_kWBWgBR1kXeQdewQ9aUBq3FH6LbXaDfhmw"></' + 'script>';
	var latlng = new google.maps.LatLng(46.5, -1.7833);
	
	var myOptions = {
	  zoom: 13,
	  center: latlng,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	
	map = new google.maps.Map($('.map-container').removeClass('map-container').get(0), myOptions);
	
	dirService = new google.maps.DirectionsService();
	dirRenderer = new google.maps.DirectionsRenderer();
}

function showDirections(dirResult, dirStatus) {
	if (dirStatus != google.maps.DirectionsStatus.OK) {
	  alert('Aucun itineraire trouve : ' + dirStatus);
	  return;
	}

	// Show directions
	dirRenderer.setMap(map);
	dirRenderer.setDirections(dirResult);
}

function getDirections(dest) {
	var dirRequest = {
	  origin: pos,
	  destination: dest,
	  travelMode: google.maps.DirectionsTravelMode.DRIVING
	};
	
	dirService.route(dirRequest, showDirections);
}
