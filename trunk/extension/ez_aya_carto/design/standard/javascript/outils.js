
function creerTrajet(idTravelMode){
    var directionsPanel = $("#directions-details .directions-details-content");
    directionsPanel.html("");
    var googleTravelMode=[google.maps.DirectionsTravelMode.DRIVING,google.maps.DirectionsTravelMode.WALKING]
    directionsDisplayTrajet.setMap(null);
    if (creerTrajetMarkers.length > 1){
        
        var waypointsValise=new Array();
        var originValise=creerTrajetMarkers[0];
        var destinationValise=creerTrajetMarkers[creerTrajetMarkers.length - 1];
        if(creerTrajetMarkers.length > 2){
            for(var i=1;i<(creerTrajetMarkers.length - 1); i++){
                var wpt={
                    location:creerTrajetMarkers[i].getPosition(),
                    stopover:true
                };
                waypointsValise[i-1]=wpt;
            }
        }
        var request = {
            origin: originValise.getPosition(),
            destination: destinationValise.getPosition(),
            waypoints: waypointsValise,
            optimizeWaypoints: true,
            travelMode: googleTravelMode[idTravelMode]
        };
        directionsServiceTrajet.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplayTrajet.setDirections(response);
                var route = response.routes[0];
                
                // For each route, display summary information.
                for (var i = 0; i < route.legs.length; i++) {
                    var routeSegment = i+1;
                    directionsPanel.append("<div class=\"route-segment\" ></div>");
                    directionsPanel.find(".route-segment:last").append(
                        "<div class=\"route-segment-content\">"+
                        "<b>Route Segment: " + routeSegment + "</b><br />"+
                        route.legs[i].start_address + " to "+
                        route.legs[i].end_address + "<br />"+
                        "distance : "+route.legs[i].distance.text + "<br />"+
                        "Durée : "+route.legs[i].duration.text + "<br />"+
                        "<a id=\"show-route-instractions-"+i+"\" href=\"#\" class=\"show-route-instractions\" onClick=\"showRouteInstractions("+i+");return false;\">Afficher les instructions</a>"+
                        "<div class=\"clear-both\"></div>"+
                        "</div>"
                        
                        );
                    directionsPanel.find(".route-segment:last").append("<div class=\"route-segment-allsteps\"><ul></ul></div>");
                    var allStepsPan=directionsPanel.find(".route-segment:last .route-segment-allsteps ul");
                    for(var j=0;j<route.legs[i].steps.length;j++){
                        var step=route.legs[i].steps[j];
                        allStepsPan.append("<li class=\"route-segment-step\">"+step.instructions+
                            "<p><span><strong><i>Distance : </i></strong>"+step.distance.text+"&nbsp;&nbsp;</span>"+
                            "<span><strong><i>Durée : </i></strong>"+step.duration.text+"</span></p>"+
                            "</li>");
                    }
                    allStepsPan.find("li:last").addClass("no-border");
                }
            } else {
                alert("Google directions response : "+status);
            }
        });
        directionsDisplayTrajet.setMap(map_container);
    }
}
function showRouteInstractions(id){
        
    var allSteps=$("#show-route-instractions-"+id).parents(".route-segment").find(".route-segment-allsteps");
    if(!allSteps.is(":animated")){
        allSteps.slideToggle("slow");
    }
        
    return false;
}
function searchElementsInMap(searchText){
    var resultSearch=new Array();
    var objRegEx=new RegExp(searchText,'i');
    for(var i in cartoMarkers){
        for(var j in cartoMarkers[i]){
            var itMarker=cartoMarkers[i][j];
            
            if(objRegEx.test(itMarker.getTitle())){
                resultSearch[resultSearch.length]=itMarker;
            }
        }
    }
    return resultSearch;
}
function showSearchElements(resultSearchMarkers){
    for(var i in cartoMarkers){
        for(var j in cartoMarkers[i]){
            var itMarker=cartoMarkers[i][j];
            itMarker.setMap(null);
        }
    }
    for(var k in resultSearchMarkers){
        resultSearchMarkers[k].setMap(map_container);
    }
}
function showAllCheckedElements(resultSearchMarkers){
    for(var k in resultSearchMarkers){
        resultSearchMarkers[k].setMap(null);
    }
    for(var i in cartoMarkers){
        for(var j in cartoMarkers[i]){
            var itMarker=cartoMarkers[i][j];
            itMarker.setMap(map_container);
        }
    }
}
function hideSearchElements(resultSearchMarkers){
    for(var k in resultSearchMarkers){
        resultSearchMarkers[k].setMap(null);
    }
}
function hideAllElements(resultSearchMarkers){
    for(var k in resultSearchMarkers){
        resultSearchMarkers[k].setMap(null);
    }
    for(var i in cartoMarkers){
        for(var j in cartoMarkers[i]){
            var itMarker=cartoMarkers[i][j];
            itMarker.setMap(null);
        }
    }
}
/* End functions */
$(function(){
    $("#geocode-form").submit(function(){
        var address=$("#geocode-address").val();
        geocoder.geocode( {
            'address': address
        }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map_container.setCenter(results[0].geometry.location);
            
                console.log(results[0]);
            
                var contentInfoWindow="<div class=\"marker-geocode-infos\">";
                contentInfoWindow+="<strong class=\"geocode-titre\">"+results[0].formatted_address+"</strong>";
                contentInfoWindow+="<span class=\"display-block\">Département : "+results[0].address_components[1].long_name+"</span>";
                contentInfoWindow+="<span class=\"display-block\">Région : "+results[0].address_components[2].long_name+"</span>";
                contentInfoWindow+="<span class=\"display-block\">Pays : "+results[0].address_components[3].long_name+"</span>";
                contentInfoWindow+="<span class=\"display-block\">Latitude et Longitude : "+results[0].geometry.location+"</span>";

                contentInfoWindow+="</div>";
                var infowindow = new google.maps.InfoWindow({
                    content: contentInfoWindow
                });

                var marker = new google.maps.Marker({
                    map: map_container,
                    position: results[0].geometry.location
                });
            
                google.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map_container,marker);
                });
                infowindow.open(map_container,marker);
                geoCodeMarkers[geoCodeMarkers.length]=marker;
            } else {
                alert("Réponse google map: " + status);
            }
        });
        return false;
    });
    $("#delete-markers-geocode").click(function(){
        for(var i=0;i<geoCodeMarkers.length;i++){
            geoCodeMarkers[i].setMap(null);
        }
        geoCodeMarkers=new Array();
        return false;
    });
    $("#outils-creer-trajet").click(function(){
        google.maps.event.addListener(map_container, 'click', function(event) {
            creerTrajetMarkers[creerTrajetMarkers.length] = new google.maps.Marker({
                position: event.latLng,
                map: map_container
            });
            creerTrajet(creerTrajetSelectedMode);
        });
        return false;
    });
    $("#afficher-titre, #outils-recherche-perimetre, #outils-recherche, #outils-geocode, #valise-titre, #outils-titre").click(function(){
        google.maps.event.clearListeners(map_container, 'click');
        return false;
    });
    
    $(".creer-trajet-mode").click(function(){
        if($(this).val()== '0' || $(this).val()== '1'){
            creerTrajetSelectedMode=$(this).val();
            creerTrajet(creerTrajetSelectedMode);
        }
    });
    $("#creer-trajet-reset").click(function(){
        for(var i=0; i<creerTrajetMarkers.length;i++){
            creerTrajetMarkers[i].setMap(null);
        }
        creerTrajetMarkers=new Array();
        creerTrajet(creerTrajetSelectedMode);
        return false;
    });
    $("#creer-trajet-laststep").click(function(){
        if(creerTrajetMarkers.length > 0 ){
            creerTrajetMarkers[creerTrajetMarkers.length - 1].setMap(null);
            var tempcreerTrajetMarkers=new Array();
            for(var i=0; i<creerTrajetMarkers.length - 1;i++){
                tempcreerTrajetMarkers[i]=creerTrajetMarkers[i];
            }
            creerTrajetMarkers=tempcreerTrajetMarkers;
            creerTrajet(creerTrajetSelectedMode);
        }
        return false;
    });
    $("#creer-trajet-afficher-details").click(function(){
        $("#directions-details").fadeOut('fast', function(){
            $("#directions-details").fadeIn('slow');
        });
        return false;
    });
    
    /*outils-recherche-form*/
    
    $("#outils-recherche-form").submit(function(){
        var textRecherche=$("#outils-recherche-text").val();
        searchCartoMarkers=searchElementsInMap(textRecherche);
        showSearchElements(searchCartoMarkers);
        return false;
    });
    $("#outils-recherche-reset").click(function(){
        hideAllElements(searchCartoMarkers);
        return false;
    });
    $("#outils-recherche-lastsearch").click(function(){
        showSearchElements(searchCartoMarkers);
        return false;
    });
    $("#outils-recherche-showAll").click(function(){
        showAllCheckedElements(searchCartoMarkers);
        return false;
    });
    
});