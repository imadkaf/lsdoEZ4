$(function(){
    $(".section-menu").click(function(){
        $(".section-menu").removeClass("active")
        $(this).addClass("active");
    });
    $("#menu-droite>ul>li>.sous-menu>ul>li>a").hover(
        function(){
            var eThis=$(this);
            eThis.animate({
                "paddingLeft":"65px",
                "color":"#ffa405"
            });
        },function(){
            var eThis=$(this);
            if(!eThis.hasClass("active")){
                eThis.animate({
                    "paddingLeft":"55px",
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
                        "paddingLeft":"55px",
                        "color":"#000"
                    });
            });
        }else{
            $(this).animate({
                "paddingLeft":"55px",
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
        var checkbox_categorie = $(this).parent().find(".checkbox-categorie");
        checkbox_categorie.each(function(){
            if($(this).is(":checked")){
                $(this).click();
            }
        });
        
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
        var eDateRV_DA = $(this);
        var categID = $(this).find(".affichage-date-categ-id");
        var dateDu = $(this).find(".checkbox-date-rv-d");
        var dateAu = $(this).find(".checkbox-date-rv-a");
        if( dateDu.val() == '' || dateAu.val() == ''){
            alert("Veuillez remplir les deux champs Du, Au");
        }else{
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
    
});
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
    
