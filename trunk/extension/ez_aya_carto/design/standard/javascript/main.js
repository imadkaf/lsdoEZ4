$(function(){
    $("#afficher-titre").click();
    $("#menu-droite>ul>li>.sous-menu>ul>li>a.type-2").click(function(){
        if(!$(this).parent().find(".container-affichage-date .affichage-date-rv-j .checkbox-date-rv-j").is(":checked")){
            $(this).parent().find(".container-affichage-date .affichage-date-rv-j").click();
        }
    });
    $("#recherche-titre").parent().find(".sous-menu:first").fadeIn();
});

