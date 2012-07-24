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
        $(".pieds-page ul li a.plus-image").css("display","none");
        $(".pieds-page ul li a.plus-info-pictos").css("display","none");
        $(".pieds-page ul li a.quizz-pictos").css("display","none");
        $(".pieds-page ul li a.lien-plus-info-ouvert").css("display","none");
        $(".pieds-page ul li a.plus-image-ouvert").css("display","none");
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
        $(".pieds-page ul.normal").css("display","block");
        $(".pieds-page ul li a.plus-image").css("display","block");
        $(".pieds-page ul li a.plus-info-pictos").css("display","block");
        $(".pieds-page ul li a.quizz-pictos").css("display","block");
        {/literal}
        	{if eq($cNode.class_identifier,'smp_point_interet')}
        	$(".pieds-page ul").css("max-width","280px");
        	{else}
        	$(".pieds-page ul").css("max-width","120px");
        	{/if}
        {literal}
        
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

    {/literal}
</script>