 <script>  
 {literal}                                                       
var rendererOptions = {
  draggable: true
};
var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
var directionsService = new google.maps.DirectionsService();
var map;


function initialize(idMap, zoomMap,longitude,latitude,origin,destination,points,locationMiseEnAvant,locationSimple,couleuritineraire) {
var latlng = new google.maps.LatLng(longitude, latitude);
  var myOptions = {
    zoom: zoomMap,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    center: latlng
  };
  map = new google.maps.Map(document.getElementById(idMap), myOptions);
  setMarkers(map, locationMiseEnAvant,locationSimple);
  

  calcRoute(origin,destination,points,couleuritineraire);
 
  
}

function setMarkers(map, locationMiseEnAvant,locationSimple) {
 
                                var tableau_icones = new Array("goutte-mise-en-avant","goutte-pt-interet");
                                for (var i = 0; i < locationMiseEnAvant.length; i++) {
                                    var beach = locationMiseEnAvant[i];
                                    var myLatLng = new google.maps.LatLng(beach[1], beach[2]);
                                    var location = locationMiseEnAvant[i];
                                    var marker = new google.maps.Marker({
                                        position: myLatLng,
                                        map: map,
                                        title: location[0],
                                        icon: 'images/' + tableau_icones[0] + '.png'
                                    });
                                }
                                
                                for (var i = 0; i < locationSimple.length; i++) {
                                    var beach = locationSimple[i];
                                    var myLatLng = new google.maps.LatLng(beach[1], beach[2]);
                                    var location = locationSimple[i];
                                    var marker = new google.maps.Marker({
                                        position: myLatLng,
                                        map: map,
                                        title: location[0],
                                        icon: 'images/' + tableau_icones[1] + '.png'
                                    });
                                }
                            }

function calcRoute(origin,destination,points,couleuritineraire) {
                 
  var request = {
    origin: origin,
    destination: destination,
    waypoints:points,
    travelMode: google.maps.TravelMode.WALKING
  };
   var polylineOp = {
      strokeColor:couleuritineraire  // la couleur de la route : rouge
    };
    var renderOptions = {
      polylineOptions : polylineOp
    }; 
 directionsDisplay = new google.maps.DirectionsRenderer(renderOptions);
 
    directionsDisplay.setMap(map);
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      showSteps(response);
    }
  });
  clearMarkers();
    directionsVisible = true;
}


//initialize('map_canvas', 8 ,-25.274398, 133.775136,"Sydney, NSW","Broken Hill, NSW",[{location: "Bourke, NSW"}, {location: "Broken Hill, NSW"}], [{location: "Bourke, NSW"}, {location: "Broken Hill, NSW"}, {location: "Sydney, NSW"}]);
$(".afficher-map").click(function() {
   var hauteur = $("body").height() - $(".bloc-carte-google").height() - $(".pieds-page").height();
    $(".google-maps-desactif").css("display","none");
    $(".google-maps-actif").css("display","block");   
    $("#Header").css("display","none");
    $("#Main .contenu").css("display","none");
    $("#breadcrumbs").css("display","none");
    $(".recherche.accueil").css("display","none");
    $(".copyright").css("display","none");
    $(".bloc-carte-google .afficher-bloc").css("display","none");
    $(".bloc-carte-google .masquer-bloc").css("display","block");
    $(".pieds-page ul").css("max-width","180px")
    $(".supp-itiniraire").css("display","block");
    $("#map_canvas").css("height", hauteur+"px");
    initialize('map_canvas', 8 , 47.26804770458176, -0.032958984375,"Nante, France","La roche sur Yon, France",  [{location: "Nantes, France"}, {location: "Angers, France"},{location: "La Roche-sur-Yon, France"},{location: "Le Mans, France"}] ,[['Angers', 47.436448065837205, -0.591888427734375, 3],['Manly Beach', 47.79655164755933, -0.33233642578125, 2],['le Mans', 48.007180450057604, 0.19994258880615234, 1]],[['Nante', 47.60616304386874, 0.17578125, 4],['La roche sur Yon', 46.60605412713272, -1.4996337890625, 5]],'#98e2cc');
    return false;
});

    $(".masquer-map").click(function() {
    $(".google-maps-actif").css("display","none");
    $(".google-maps-desactif").css("display","block");
    $("#Header").css("display","block");
    $("#Main .contenu").css("display","block");
    $("#breadcrumbs").css("display","block");
    $(".recherche.accueil").css("display","block");
    $(".copyright").css("display","block");
    $(".bloc-carte-google .afficher-bloc").css("display","block");
    $(".bloc-carte-google .masquer-bloc").css("display","none");
    $(".pieds-page ul").css("max-width","120px")
    $(".supp-itiniraire").css("display","none");
    $("#map_canvas").css("height", "0");    
    return false;
});

$(".supp-itiniraire").click(function() {
directionsDisplay.setMap(null);
return false;

});

var list_length=$(".pieds-page ul li").length;
  
    for(var i=0 ; i<$(".pieds-page ul li").length;i++){
        if($(".pieds-page ul li:eq("+i+") a").css('display') == 'none' ){
            list_length=list_length-1;
        }
    }
    $(".pieds-page ul").css("max-width",list_length*60+'px');
    {/literal}
</script>