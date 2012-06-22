function reinitialiser(){
    
    /* Réinitialiser les cases cochées */
    $(".checkbox-categorie").each(function(){
        if($(this).is(":checked")){
            $(this).click();
            var categIndex=$(this).attr("id");
            var cartoMarkersCateg=cartoMarkers[categIndex];
            for(var i in cartoMarkersCateg){
                cartoMarkersCateg[i].setMap(null);
            }
            $(this).parents("label").removeClass("active");
        }
    });
    
    /* Réinitialiser le trajet personalisé */
    for(var i=0; i<creerTrajetMarkers.length;i++){
        creerTrajetMarkers[i].setMap(null);
    }
    creerTrajetMarkers=new Array();
    creerTrajet(creerTrajetSelectedMode);
    
    /* Réinitialiser les markeurs Géolocaliser */
    for(var i=0;i<geoCodeMarkers.length;i++){
        geoCodeMarkers[i].setMap(null);
    }
    geoCodeMarkers=new Array();
    
    /* Réinitialiser la valise */
    hideRouteValise();
    hideValiseMarkers();
    hideAllElements(searchCartoMarkers);
    
    $("#valise-elements").html("");
    $("#directions-details").fadeOut();
    $("#detail-produit").fadeOut();
    
    /* Réinitialiser tous les champs de saisi */
    $("input[type='text']").val('');
    /* Réinitialiser l'affichage de début */
    $("#menu-droite .sous-menu").fadeOut();
    $("#valise-container").fadeOut();
    $("#afficher-titre").next(".sous-menu").fadeIn();
    
    /* Réinitialiser toutes les variables */
    cartoMarkers = new Array();
    searchCartoMarkers = new Array();
    geoCodeMarkers = new Array();
    valiseMarkers = new Array();
    detailMarker = false;
    valiseRoute = new Array();
    creerTrajetMarkers = new Array();
    creerTrajetSelectedMode = '0';
    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsService = new google.maps.DirectionsService();
    directionsDisplayTrajet = new google.maps.DirectionsRenderer();
    directionsServiceTrajet = new google.maps.DirectionsService();
    geocoder = new google.maps.Geocoder();
    map_container = new google.maps.Map(document.getElementById("google-map"), myOptions);
}
