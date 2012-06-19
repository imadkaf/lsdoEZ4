function addMarker(markerName,lat,lng){
    cartoMarkers[markerName] = new google.maps.Marker({
        position: new google.maps.LatLng(lat, lng),
        map: map_container,
        title: 'Click to zoom'
    });
    
}
function removeMarker(markerName){
    cartoMarkers[markerName].setMap(null); 
}


