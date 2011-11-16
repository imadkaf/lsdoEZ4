function initializeListe(latlngParam, markersParam, infobullesParam) {
	$('.map-js-container').removeClass('map-js-container').get(0).innerHTML = '<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true&amp;key=ABQIAAAAOZJQqoDBwAknMtPNKR-dvRSi2OoyjRwg8X5jAJmNj4togrBv2xSClpdvpd4FJNt4C5i-i6aTtWzs-g"></' + 'script>';

	//Les coordonnees du centre des Sables d'Olonne
	var latlngCentre = new google.maps.LatLng(46.5, -1.7833);
	
	var myOptions = {
	  zoom: 13,
	  center: latlngCentre,
	  scrollwheel: false,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	
	var map = new google.maps.Map($('.mapContainerListe').removeClass('mapContainerListe').get(0), myOptions);
	
	//Ajout des marqueurs
	for(var i=0; i<markersParam.length; i++){
		markersParam[i].setMap(map);
		
		markersParam[i]._infowindow = infobullesParam[i];
		
		google.maps.event.addListener(markersParam[i], 'click', function() {
			this._infowindow.open(map, this);
		});
	}
	
	//Pour centrer et zoomer correctement la map
	if (latlngParam.length > 0) {
		console.log('passe 3');
		var latlngbounds = new google.maps.LatLngBounds( );
		for ( var i = 0; i < latlngParam.length; i++ )
		{
		  latlngbounds.extend( latlngParam[ i ] );
		}
		map.fitBounds(latlngbounds);
	}
}
