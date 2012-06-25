function valiseHasElement(idProd){
    for(var itKey in valiseMarkers){
        if(itKey == 'valiseMarker_'+idProd){
            return true;
        }
    }
    return false;
}
function addToValise(merkerValise,idProd,htmlValise){
    valiseMarkers['valiseMarker_'+idProd]={
        'merkerValise':merkerValise,
        'htmlValise':htmlValise
    };
    
    $("#valise-elements").html("");
    valiseRoute=new Array();
    var idx=0;
    for(var itKey in valiseMarkers){
        $("#valise-elements").append(valiseMarkers[itKey]['htmlValise']);
        valiseRoute[idx]=valiseMarkers[itKey]['merkerValise'];
        idx++;
    }
    showRouteValise();
    
    return valiseMarkers;
}
function removeFromValise(idProd){
    var newValiseMarkers=new Array();
    for(var itKey in valiseMarkers){
        if(itKey!='valiseMarker_'+idProd){
            newValiseMarkers[itKey]=valiseMarkers[itKey];
        }
    }
    valiseMarkers=newValiseMarkers;
    valiseRoute=new Array();
    $("#valise-elements").html("");
    var idx=0;
    for(var iKey in valiseMarkers){
        $("#valise-elements").append(valiseMarkers[iKey]['htmlValise']);
        valiseRoute[idx]=valiseMarkers[iKey]['merkerValise'];
        idx++;
    }
    showRouteValise();
    return newValiseMarkers;
}
function showValiseMarkers(){
    
    for(var kCg in cartoMarkers){
        for(var kPt in cartoMarkers[kCg]){
            cartoMarkers[kCg][kPt].setMap(null);
        }
    }
    for(var kMr in valiseMarkers){
        valiseMarkers[kMr]['merkerValise'].setMap(map_container);
    }
}
function hideValiseMarkers(){
    for(var kMr in valiseMarkers){
        valiseMarkers[kMr]['merkerValise'].setMap(null);
    }
//    for(var kCg in cartoMarkers){
//        for(var kPt in cartoMarkers[kCg]){
//            cartoMarkers[kCg][kPt].setMap(map_container);
//        }
//    }
    
}
function showRouteValise() {
    var directionsPanel = $("#directions-details .directions-details-content");
    directionsPanel.html("");
    
                
    if (valiseRoute.length > 1){
        
        var waypointsValise=new Array();
        var originValise=valiseRoute[0];
        var destinationValise=valiseRoute[valiseRoute.length - 1];
        if(valiseRoute.length > 2){
            for(var i=1;i<(valiseRoute.length - 1); i++){
                var wpt={
                    location:valiseRoute[i].getPosition(),
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
            travelMode: google.maps.DirectionsTravelMode.DRIVING
        };
        directionsService.route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
                var route = response.routes[0];
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
                        "<a id=\"show-route-instractions-"+i+"\" href=\"#\" class=\"show-route-instractions\" onClick=\"showItineraireInstractions("+i+")\">Afficher les instructions</a>"+
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
    }else{
        hideRouteValise();
    }
}
function showItineraireValise(){
    directionsDisplay.setMap(map_container);
    $("#directions-details").fadeOut('fast',function(){
        $("#directions-details").fadeIn('slow');
    });
}
function hideRouteValise(){
    directionsDisplay.setMap(null);
    $("#directions-details").fadeOut('fast');
}
function showItineraireInstractions(id){
        
    var allSteps=$("#show-route-instractions-"+id).parents(".route-segment").find(".route-segment-allsteps");
    if(!allSteps.is(":animated")){
        allSteps.slideToggle("slow");
    }
        
    return false;
}