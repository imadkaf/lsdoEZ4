<script>
 {literal}
$(function(){
    $(".afficher-map").click(function() {
        var hauteur = $("body").height() - $(".bloc-carte-google").height() - $(".pieds-page").height();
        $(".google-maps-desactif-pieds-page, .google-map-ferme-circuit-pieds-page ").css("display","none");
        $(".google-maps-actif-pieds-page, .google-map-actif-circuit-pieds-page").css("display","block");
        $("#Header").css("display","none");
        $("#Main .contenu").css("display","none");
        $("#breadcrumbs").css("display","none");
        $(".recherche.accueil").css("display","none");
        $(".copyright").css("display","none");
        $(".bloc-carte-google .afficher-bloc").css("display","none");
        $(".bloc-carte-google .masquer-bloc").css("display","block");
    	$(".pieds-page ul").css("max-width","180px");
        $(".pieds-page ul li a.plus-image-pieds-page").css("display","none");
        $(".pieds-page ul li a.plus-info-pictos-pieds-page").css("display","none");
        $(".pieds-page ul li a.quizz-pictos-pieds-page").css("display","none");
        $(".pieds-page ul li a.lien-plus-info-ouvert-pieds-page").css("display","none");
        $(".pieds-page ul li a.plus-image-ouvert-pieds-page").css("display","none");
		if($('.itiniraire-circuit'))
        	$(".itiniraire-circuit").css("display","block");
        $(".pieds-page ul").css("max-width","201px");
        if($('.supp-itiniraire'))
    		$(".supp-itiniraire").css("display","block");
        $("#map_canvas").css("height", hauteur+"px");
        if($('.tirage-au-sort'))
	        $(".tirage-au-sort").css("display","none");
	    if($('.instant-gagnant'))
			$(".instant-gagnant").css("display","none");
        if($('.agenda'))
	        $(".agenda").css("display","none");
	    if($('.suggestions'))
			$(".suggestions").css("display","none");
	    if($('.texte-libre'))
			$(".texte-libre").css("display","none");
        loadScript();
        return false;
    });

    $(".masquer-map").click(function() {
        $(".google-maps-actif-pieds-page, .google-map-actif-circuit-pieds-page").css("display","none");
        $(".google-maps-desactif-pieds-page, .google-map-ferme-circuit-pieds-page").css("display","block");
        $("#Header").css("display","block");
        $("#Main .contenu").css("display","block");
        $("#breadcrumbs").css("display","block");
        $(".recherche.accueil").css("display","block");
        $(".copyright").css("display","block");
        $(".bloc-carte-google .afficher-bloc").css("display","block");
        $(".bloc-carte-google .masquer-bloc").css("display","none");
        $(".pieds-page ul.normal").css("display","block");
        $(".pieds-page ul li a.plus-image-pieds-page").css("display","block");
        $(".pieds-page ul li a.plus-info-pictos-pieds-page").css("display","block");
        $(".pieds-page ul li a.quizz-pictos-pieds-page").css("display","block");
   		if($('.itiniraire-circuit'))
        	$(".itiniraire-circuit").css("display","none");
        $(".pieds-page ul").css("max-width","201px");
        if($('.supp-itiniraire'))
    		$(".supp-itiniraire").css("display","none");
        {/literal}
        	{if eq($cNode.class_identifier,'smp_point_interet')}
        	if($('.plus-image-pieds-page').length > 0)
        		$(".pieds-page ul").css("max-width","310px");
        	else
        		$(".pieds-page ul").css("max-width","250px");
        	{else}
        	$(".pieds-page ul").css("max-width","138px");
        	{/if}
        {literal}
        if($('.tirage-au-sort'))
	        $(".tirage-au-sort").css("display","block");
	    if($('.instant-gagnant'))
			$(".instant-gagnant").css("display","block");
		if($('.agenda'))
    		$(".agenda").css("display","block");
    	if($('.suggestions'))
    		$(".suggestions").css("display","block");
	    if($('.texte-libre'))
			$(".texte-libre").css("display","block");

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

    $(".afficher-media").click(function(){
        var hauteur = $("body").height() - $(".pieds-page").height();
        $(".google-maps-desactif, .google-map-ferme-circuit ").css("display","none");
        $(".google-maps-actif, .google-map-actif-circuit").css("display","none");
        $("#Header").css("display","none");
        $("#Main .contenu").css("display","none");
        $("#breadcrumbs").css("display","none");
        $(".recherche.accueil").css("display","none");
        $(".copyright").css("display","none");
        $(".bloc-carte-google").css("display","none");
        $(".ferme-media").css("display","block");
        $(".retour-spec").css("display","none");
        $(".pieds-page ul").css("max-width","50px");
        $(".pieds-page ul li a.plus-image").css("display","none");
        $(".pieds-page ul li a.plus-info-pictos").css("display","none");
        $(".pieds-page ul li a.quizz-pictos").css("display","none");
        $(".pieds-page ul li a.lien-plus-info-ouvert").css("display","none");
        $(".pieds-page ul li a.plus-image-ouvert").css("display","none");
        var name = $(this).attr("name");
        var div = '#'+name;
        $(".masquer-media").attr('name', div);
        //alert(div);
        	$(div).css("display","block");
    	    $(div).css("height", hauteur+"px");



        return false;
    });

    $(".masquer-media").click(function() {
        $(".google-maps-actif, .google-map-actif-circuit").css("display","none");
        $(".google-maps-desactif, .google-map-ferme-circuit").css("display","block");
        $("#Header").css("display","block");
        $("#Main .contenu").css("display","block");
        $("#breadcrumbs").css("display","block");
        $(".recherche.accueil").css("display","block");
        $(".copyright").css("display","block");
        $(".bloc-carte-google").css("display","block");
        $(".bloc-carte-google .afficher-bloc").css("display","block");
        $(".bloc-carte-google .masquer-bloc").css("display","none");
        $(".ferme-media").css("display","none");
        $(".retour-spec").css("display","block");
        $(".pieds-page ul.normal").css("display","block");
        $(".pieds-page ul li a.plus-image").css("display","block");
        $(".pieds-page ul li a.plus-info-pictos").css("display","block");
        $(".pieds-page ul li a.quizz-pictos").css("display","block");
        $(".supp-itiniraire").css("display","none");
        {/literal}
        	{if eq($cNode.class_identifier,'smp_point_interet')}
        	$(".pieds-page ul").css("max-width","280px");
        	{else}
        	$(".pieds-page ul").css("max-width","120px");
        	{/if}


        {literal}
        var name = $(this).attr("name");
        	$(name).css("display","none");
            $(name).css("height", "0");

        return false;
    });
});
{/literal}
</script>