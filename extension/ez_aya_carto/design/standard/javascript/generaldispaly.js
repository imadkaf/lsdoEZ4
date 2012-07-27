$(function(){
    $(".section-menu").click(function(){
        $(".section-menu").removeClass("active")
        $(this).addClass("active");
    });
	// Ou dormir
    $("#menu-droite>ul>li>.sous-menu>ul>li#item-0>a").hover(
	function(){
        var eThis=$(this);
        eThis.animate({"color":"#0cb4e3"});
    });
	// A voir A faire
	$("#menu-droite>ul>li>.sous-menu>ul>li#item-1>a").hover(
	function(){
        var eThis=$(this);
        eThis.animate({"color":"#ff67cb"});
    });
	// Se distraire
	$("#menu-droite>ul>li>.sous-menu>ul>li#item-2>a").hover(
	function(){
        var eThis=$(this);
        eThis.animate({"color":"#acbe15"});
    });
	// parking, urgence
	$("#menu-droite>ul>li>.sous-menu>ul>li#item-3>a").hover(
	function(){
        var eThis=$(this);
        eThis.animate({"color":"#ff7f00"});
    });
	$("#menu-droite>ul>li>.sous-menu>ul>li>a").hover(
    function(){
        var eThis=$(this);
        eThis.animate({
            "paddingLeft":"55px"
        });
    },function(){
        var eThis=$(this);
        if(!eThis.hasClass("active")){
            eThis.animate({
                "paddingLeft":"45px",
                "color":"#000"
            });
        }
    });
	
    $("#menu-droite>ul>li>.sous-menu>ul>li>a").click(function(){
        if(!$(this).hasClass("active")){
            $("#menu-droite>ul>li>.sous-menu>ul>li>a").removeClass("active");
            $(this).addClass("active");
            $("#menu-droite>ul>li>.sous-menu>ul>li>a").each(function(){
                if(!$(this).hasClass("active"))
                    $(this).animate({
                        "paddingLeft":"45px",
                        "color":"#000"
                    });
            });
        }else{
            $(this).animate({
                "paddingLeft":"45px",
                "color":"#000"
            });
            $(this).removeClass("active");
            
        }
        return false;
    });
    $(".display-table").each(function(){
        var eTable=$(this);
        eTable.css({
            "width":"100%"
        });
        var tableLength=eTable.find(".display-table-cell").length;
        eTable.find(".display-table-cell").css({
            "width": (parseInt(100 / tableLength)) + "%",
            "text-align":"center"
        });
    });
    
    $("#menu-droite .has-sub-menu").click(function(){
        var curElt=$(this);
        
        var curEltSousMenu=curElt.next();
        if(!curEltSousMenu.is(":visible")){
            curElt.parent().parent().find(".sous-menu").css({
                "display":"none"
            });
            curEltSousMenu.fadeIn(500);
            
        }else{
            curEltSousMenu.fadeOut(500);
        }
        return false;
    });
    $(".checkbox-categorie").change(function(){
        var eCategInput=$(this);
        if( eCategInput.is(":checked") ){
            $("#overlay-loading").css({
                "z-index":"9999",
                "display":"block"
            });
            $("#script-container").append("<div class='script-container'></div>");
            $("#script-container").find(".script-container:last").load("/layout/set/carto/carto/import_categories?idc="+eCategInput.attr("id"),function(){
                $("#overlay-loading").css({
                    "z-index":"-1",
                    "display":"none"
                });
                /* Adapter le zoom et la position de la carte */
                adaptZoomPosition();
            });
            eCategInput.parents("label").addClass("active");
        }else{
            var categIndex=eCategInput.attr("id");
            var cartoMarkersCateg=cartoMarkers[categIndex];
            for(var i in cartoMarkersCateg){
                cartoMarkersCateg[i].setMap(null);
            }
            eCategInput.parents("label").removeClass("active");
            /* Adapter la carte */
            adaptZoomPosition();
            
        }
        
    });
    $("#detail-produit .control .puce-close").click(function(){
        $("#detail-produit").fadeOut("fast");
        return false;
    });
    $( "#detail-produit" ).draggable({
        handle: ".control"
    });
    $("#valise-titre").click(function(){
        if(!$("#valise-container").is(":visible")){
            $("#valise-container").css({
                "display":"none"
            });
            $("#valise-container").fadeIn(500);
        }else{
            $("#valise-container").fadeOut(500);
        }
        return false;
    });
    $("#valise-affiche-pictos").click(function(){
        
        if($(this).find(".second").hasClass("cache")){
            showValiseMarkers();
            $(this).find(".first").addClass("cache");
            $(this).find(".second").removeClass("cache");
        }else{
            hideValiseMarkers();
            $(this).find(".second").addClass("cache");
            $(this).find(".first").removeClass("cache");
        }
        return false;
    });
    $("#valise-tracer-itineraire").click(function(){
        if($(this).find(".second").hasClass("cache")){
            if (valiseRoute.length > 1){
                showRouteValise();
                showItineraireValise();
                $(this).find(".first").addClass("cache");
                $(this).find(".second").removeClass("cache");
                
            }else{
                hideRouteValise();
            }
        }else{
            hideRouteValise();
            $(this).find(".second").addClass("cache");
            $(this).find(".first").removeClass("cache");
        }
        return false;
    });
    $('#detail-produit .centre-carte').click(function(){
        map_container.setCenter(detailMarker['marker'].getPosition());
        return false;
    });
    $('#detail-produit .ajout-valise').click(function(){
        addToValise(detailMarker['marker'],detailMarker['idProd'],detailMarker['blocValise']);
        if(valiseHasElement(detailMarker['idProd'])){
            $('#detail-produit .retirer-valise').removeClass('cache');   
            $('#detail-produit .ajout-valise').addClass('cache');   
        }else{
            $('#detail-produit .ajout-valise').removeClass('cache');   
            $('#detail-produit .retirer-valise').addClass('cache');
        }
        return false;
    });
    $('#detail-produit .retirer-valise').click(function(){
        removeFromValise(detailMarker['idProd']);
        if(valiseHasElement(detailMarker['idProd'])){
            $('#detail-produit .retirer-valise').removeClass('cache');   
            $('#detail-produit .ajout-valise').addClass('cache');   
        }else{
            $('#detail-produit .ajout-valise').removeClass('cache');
            $('#detail-produit .retirer-valise').addClass('cache');
        }
        return false;
    });
    $("#directions-details .control .puce-close").click(function(){
        $("#directions-details").fadeOut("fast");
        return false;
    });
    $( "#directions-details" ).draggable({
        handle: ".control"
    });
    $(".detail-street-view").live('click',function(){
        if(streetViewMarker != false && streetViewMarker.getVisible()==true){
            $(this).addClass("cache");
            $(".detail-close-street-view").removeClass("cache");
        }
    });
    $(".detail-close-street-view").live('click',function(){
        if(streetViewMarker == false || (streetViewMarker != false && streetViewMarker.getVisible()==false)){
            $(this).addClass("cache");
            $(".detail-street-view").removeClass("cache");
        }
    });
    $(".effacer-marqueurs-fiches").click(function(){
        var checkbox_categorie = $(this).parent().find(".checkbox-categorie");
        checkbox_categorie.each(function(){
            if($(this).is(":checked")){
                $(this).click();
            }
        });
        
        return false;
    });
    $(".reinitialiser-ma-recherche").click(function(){
        var checkbox_categorie = $(this).parent().find(".checkbox-categorie, .checkbox-date-rv-j, .checkbox-date-rv-s");
        checkbox_categorie.each(function(){
            if($(this).is(":checked")){
                $(this).click();
            }
        });
        
        return false;
    });
    $("#detail-produit .tracer-itineraire-ot").click(function(){
        
        if(directionsDisplayOTFiche.getMap() == null || markerOTFicheID == null || markerOTFicheID != detailMarker['idProd']){
            tracerTragetOTFiche(detailMarker['marker']);
            showTragetOTFiche();
            markerOT.setMap(map_container);
        }else{
            hideTragetOTFiche();
            markerOT.setMap(null);
        }
        return false;
    });
    $(".container-affichage-date .affichage-date-rollover:first").slideDown('fast');
    $(".container-affichage-date .affichage-date-name").click(function(){
        
        if($(".container-affichage-date").length > 1){
            $(".container-affichage-date .affichage-date-rollover:visible").slideUp('fast');
            var eBlocRollOver = $(this).parent().find(".affichage-date-rollover");
            if(!eBlocRollOver.is(":visible")){
                eBlocRollOver.slideDown('fast');
            }
        }
        return false;
    });
    /* Menu>Afficher>Les dates */
    $(".checkbox-date-rv-j").change(function(){
        var eDateRV_J=$(this);
        
        var categIndex="categ_"+eDateRV_J.val();
        var cartoMarkersCateg=cartoMarkers[categIndex];
        for(var i in cartoMarkersCateg){
            cartoMarkersCateg[i].setMap(null);
        }
        
        if( eDateRV_J.is(":checked") ){
            eDateRV_J.parents(".affichage-date-options").find(".checkbox-date-rv-s:checked").click();
            $("#overlay-loading").css({
                "z-index":"9999",
                "display":"block"
            });
            $("#script-container").append("<div class='script-container'></div>");
            $("#script-container").find(".script-container:last").load("/layout/set/carto/carto/import_categories?idc=categ_"+eDateRV_J.val()+"&ta=2"+"&filt=j",function(){
                $("#overlay-loading").css({
                    "z-index":"-1",
                    "display":"none"
                });
                /* Adapter le zoom et la position de la carte */
                adaptZoomPosition();
            });
            eDateRV_J.parents("label").addClass("active");
        }else{
            
            eDateRV_J.parents("label").removeClass("active");
            /* Adapter la carte */
            adaptZoomPosition();
            
        }
        
    });
    $(".checkbox-date-rv-s").change(function(){
        var eDateRV_S=$(this);
        var categIndex="categ_"+eDateRV_S.val();
        var cartoMarkersCateg=cartoMarkers[categIndex];
        for(var i in cartoMarkersCateg){
            cartoMarkersCateg[i].setMap(null);
        }
        
        if( eDateRV_S.is(":checked") ){
            eDateRV_S.parents(".affichage-date-options").find(".checkbox-date-rv-j:checked").click();
            $("#overlay-loading").css({
                "z-index":"9999",
                "display":"block"
            });
            $("#script-container").append("<div class='script-container'></div>");
            $("#script-container").find(".script-container:last").load("/layout/set/carto/carto/import_categories?idc=categ_"+eDateRV_S.val()+"&ta=2"+"&filt=s",function(){
                $("#overlay-loading").css({
                    "z-index":"-1",
                    "display":"none"
                });
                /* Adapter le zoom et la position de la carte */
                adaptZoomPosition();
            });
            eDateRV_S.parents("label").addClass("active");
        }else{
            
            eDateRV_S.parents("label").removeClass("active");
            /* Adapter la carte */
            adaptZoomPosition();
            
        }
        
    });
    $(".affichage-date-form").submit(function(){
        var eDateRV_DA_Form = $(this);
        var categID = $(this).find(".affichage-date-categ-id");
        var dateDu = $(this).find(".checkbox-date-rv-d");
        var dateAu = $(this).find(".checkbox-date-rv-a");
        if( dateDu.val() == '' || dateAu.val() == ''){
            alert("Veuillez remplir les deux champs Du, Au");
        }else{
            eDateRV_DA_Form.parents(".container-affichage-date").find(".checkbox-date-rv-s:checked").click();
            eDateRV_DA_Form.parents(".container-affichage-date").find(".checkbox-date-rv-j:checked").click();
            var categIndex="categ_"+categID.val();
            var cartoMarkersCateg = cartoMarkers[categIndex];
            for(var i in cartoMarkersCateg){
                cartoMarkersCateg[i].setMap(null);
            }

            $("#overlay-loading").css({
                "z-index":"9999",
                "display":"block"
            });
            $("#script-container").append("<div class='script-container'></div>");
            $("#script-container").find(".script-container:last").load("/layout/set/carto/carto/import_categories?idc="+categIndex+"&ta=2"+"&filt=da"+"&du="+dateDu.val()+"&au="+dateAu.val(),function(){
                $("#overlay-loading").css({
                    "z-index":"-1",
                    "display":"none"
                });
                /* Adapter le zoom et la position de la carte */
                adaptZoomPosition();
            });
        }
        return false;
    });
    $(".container-affichage-date").each(function(){
        var eInput_Du = $(this).find(".checkbox-date-rv-d");
        var eInput_Au = $(this).find(".checkbox-date-rv-a");
        var dates = $( "#" +eInput_Du.attr('id')+ ", #" +eInput_Au.attr('id')).datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            dateFormat: "yy-mm-dd",
            numberOfMonths: 1,
            onSelect: function( selectedDate ) {
                var option = this.id == eInput_Du.attr('id') ? "minDate" : "maxDate",
                instance = $( this ).data( "datepicker" ),
                date = $.datepicker.parseDate(
                instance.settings.dateFormat ||
                    $.datepicker._defaults.dateFormat,
                selectedDate, instance.settings );
                dates.not( this ).datepicker( "option", option, date );
            }
        }).datepicker( $.datepicker.regional[ "fr" ] );
    });
    /****************************** Recherche Fiche sit & tracer itinaire fiche => OT ******************************/
    $(".srch-fiche-itn-input").keyup(function(){
        var eThis = $(this);
        var valMotCle = $(this).val();
        valMotCle = valMotCle.replace(new RegExp(" ", "g"),"%20");
        var valOD='origin';
        if(eThis.is(".origin")){
            valOD = 'origin';
        }else{
            valOD = 'destination';
        }
        eThis.parents(".input-auto-com").find(".bloc-auto-complete").css({"width":eThis.css("width")});
        if(valMotCle.length >= 2){
            eThis.parents(".input-auto-com").find(".bloc-auto-complete").fadeIn(500);
            eThis.parents(".input-auto-com").find(".bloc-auto-complete").load("/layout/set/carto/carto/aucomplete_recherche?mc="+valMotCle+"&od="+valOD,function(){
                
            });
        }else{
            eThis.parents(".input-auto-com").find(".bloc-auto-complete").fadeOut(500);
        }
    });
    $(".srch-fiche-itn-input").blur(function(){
        if(!$(this).parents(".input-auto-com").find(".bloc-auto-complete").is(":hover")){
            $(this).parents(".input-auto-com").find(".bloc-auto-complete").fadeOut(500);
        }
    });
    $(".srch-fiche-itn-input").focus(function(){
        $(".bloc-auto-complete").fadeOut(100,function(){$(".bloc-auto-complete").html("");});
        $(this).parents(".input-auto-com").find(".bloc-auto-complete").fadeIn(100);
        if($(this).attr("id") == "srch-fiche-itn-ot-input"){
            rechercheItinFichMarkers['origin'] = markerOT;
        }
    });
    $("#srch-ot-itn-titre").blur(function(){
        if(rechercheItinFichMarkers['origin'] != null)
        rechercheItinFichMarkers['origin'].setMap(null);
    });
    $("#effacer-srch-itin-mrkrs").click(function(){
        rechercheItinFichMarkers['origin'].setMap(null);
        rechercheItinFichMarkers['destination'].setMap(null);
        rechercheItinFichMarkers['origin'] = null;
        rechercheItinFichMarkers['destination'] = null;
        directionsDisplayItinFich.setMap(null);
        $(".srch-fiche-itn-input").val("");
        $(".input-auto-com .bloc-auto-complete").hide();
        return false;
    });
   
//    $(".input-auto-com .bloc-auto-complete ul li a").click(function(){
//        
//        return false;
//    });
    
});
/* rechercher produit sit */
function rechercheItinFiche(categID,prodID,orgDest,idacFiche){
    
    var inputSrch = $("#"+idacFiche).parents(".input-auto-com").find(".srch-fiche-itn-input");
    inputSrch.val($("#"+idacFiche).html());
    for(var i in cartoMarkers){
        for(var j in cartoMarkers[i]){
            cartoMarkers[i][j].setMap(null);
        }
    }
    $(".reinitialiser-ma-recherche").click();
    
    $("#overlay-loading").css({
        "z-index":"9999",
        "display":"block"
    });
    $("#script-container").append("<div class='script-container'></div>");
    $("#script-container").find(".script-container:last").load("/layout/set/carto/carto/rechercher_produit?idc=categ_"+categID+"&idp="+prodID+"&od="+orgDest,function(){
        $("#overlay-loading").css({
            "z-index":"-1",
            "display":"none"
        });
        /* Adapter la carte  zoom + position*/
        var latlngbounds = new google.maps.LatLngBounds( );
        var readaptMap=false;
        for ( var k in rechercheItinFichMarkers ){
            if(rechercheItinFichMarkers[k].getMap() != null){
                latlngbounds.extend( rechercheItinFichMarkers[k].getPosition());
                readaptMap = true;
            }
        }
        if(readaptMap){
            map_container.fitBounds(latlngbounds);
        }
        
        if(rechercheItinFichMarkers['origin'] != null && rechercheItinFichMarkers['destination'] != null){
           
            var waypointsValise=new Array();
            var request = {
                origin: rechercheItinFichMarkers['origin'].getPosition(),
                destination: rechercheItinFichMarkers['destination'].getPosition(),
                waypoints: waypointsValise,
                optimizeWaypoints: true,
                travelMode: google.maps.DirectionsTravelMode.DRIVING
            };
            directionsServiceItinFich.route(request, function(response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplayItinFich.setDirections(response);
                    directionsDisplayItinFich.setMap(map_container);
                    
                    rechercheItinFichMarkers['origin'].setMap(map_container);
                    rechercheItinFichMarkers['destination'].setMap(map_container);
                } else {
                    alert("Google directions response : "+status);
                }
            });
        }
    });
    $(".bloc-auto-complete").fadeOut(200);
}



/* Adapter la hauteur des sous menu */
function adaptHeightSousMenu(){
        
    var firstMenuheight=$("#menu-droite>ul>li>.sous-menu").height();
    $("#menu-droite>ul>li>.sous-menu .sous-menu").each(function(){
        var itemSubMenuHeight = $(this).height();
        if(itemSubMenuHeight < firstMenuheight){
            $(this).css({
                "height":firstMenuheight
            });
        }
    });
    //alert(firstMenuheight);
}
    
function adaptZoomPosition(){
    var latlngbounds = new google.maps.LatLngBounds( );
    var readaptMap=false;
    for ( var k in cartoMarkers ){
        for ( var j in cartoMarkers[k] ){
            if(cartoMarkers[k][j].getMap() != null){
                latlngbounds.extend( cartoMarkers[k][j].getPosition());
                readaptMap=true;
            }
        }
    }
    if(readaptMap){
        map_container.fitBounds(latlngbounds);
    }
}
function tracerTragetOTFiche(markerFiche) {
    
    var directionsPanel = $("#directions-details .directions-details-content");
    directionsPanel.html("");
    
    var waypointsValise=new Array();
    var originMarker = markerOT;
    var destinationMarker = markerFiche;
    
    var request = {
        origin: originMarker.getPosition(),
        destination: destinationMarker.getPosition(),
        waypoints: waypointsValise,
        optimizeWaypoints: true,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
    directionsServiceOTFiche.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplayOTFiche.setDirections(response);
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
}

function showTragetOTFiche(){
    directionsDisplayOTFiche.setMap(map_container);
    $("#directions-details").fadeOut('fast',function(){
        $("#directions-details").fadeIn('slow');
    });
    markerOTFicheID = detailMarker['idProd'];
}
function hideTragetOTFiche(){
    directionsDisplayOTFiche.setMap(null);
    $("#directions-details").fadeOut('fast');
    markerOTFicheID = null;
}
    
