function setSreetViewAt(lat,lng,address){
    var latlngPosition = new google.maps.LatLng(lat,lng);
    var panorama = map_container.getStreetView();
    var sv = new google.maps.StreetViewService();

    sv.getPanoramaByLocation(latlngPosition, svProximite, function(data, status) {
        if (status == google.maps.StreetViewStatus.OK) {
                if(streetViewMarker!=false){
                    streetViewMarker.setMap(null);
                }
                streetViewMarker = new google.maps.Marker({
                position: data.location.latLng,
                map: map_container,
                title: data.location.description,
                icon : '/extension/ez_aya_carto/design/standard/images/pictos/map/sreet_view_picto.png',
                shadow : '/extension/ez_aya_carto/design/standard/images/pictos/map/sreet_view_shadow.png'
            });
      
            panorama.setPano(data.location.pano);
            panorama.setPov({
                heading: 270,
                pitch: 0,
                zoom: 1
            });
            panorama.setVisible(true);
      
            google.maps.event.addListener(streetViewMarker, 'click', function() {
      
                var markerPanoID = data.location.pano;
                // Set the Pano to use the passed panoID
                panorama.setPano(markerPanoID);
                panorama.setPov({
                    heading: 270,
                    pitch: 0,
                    zoom: 1
                });
                panorama.setVisible(true);
            });
        } else {
            
            
            geocoder.geocode( {
                'address': address
            }, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    latlngPosition = new google.maps.LatLng(results[0].geometry.location.$a, results[0].geometry.location.ab);
                    panorama.setPosition(latlngPosition);
                    panorama.setPov({
                        heading: 265,
                        zoom:1,
                        pitch:0
                    });
                panorama.setVisible(true);

                } else {
                    alert("Street View data not found for this location.");
                }
            });
            
        }
    });
    
}