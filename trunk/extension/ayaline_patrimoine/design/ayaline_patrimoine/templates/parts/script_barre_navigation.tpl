 <script>  
 {literal}
$(function(){
    $(".afficher-map").click(function() {
        var hauteur = $("body").height() - $(".bloc-carte-google").height() - $(".pieds-page").height();
        $(".google-maps-desactif, .google-map-ferme-circuit ").css("display","none");
        $(".google-maps-actif, .google-map-actif-circuit").css("display","block");   
        $("#Header").css("display","none");
        $("#Main .contenu").css("display","none");
        $("#breadcrumbs").css("display","none");
        $(".recherche.accueil").css("display","none");
        $(".copyright").css("display","none");
        $(".bloc-carte-google .afficher-bloc").css("display","none");
        $(".bloc-carte-google .masquer-bloc").css("display","block");
        $(".pieds-page ul").css("max-width","180px");
        $("#map_canvas").css("height", hauteur+"px");
        loadScript();
        return false;
    });

    $(".masquer-map").click(function() {
        $(".google-maps-actif, .google-map-actif-circuit").css("display","none");
        $(".google-maps-desactif, .google-map-ferme-circuit").css("display","block");
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
    $(".supp-itiniraire").click(function(){
        cacherItineraireMaposition();
        $(this).addClass("cache").hide();
        return false;
    });
    $(".itiniraire-circuit").click(function() {
        cacherItineraireMaposition();
        $(this).addClass("cache").hide();
        return false;
    });
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