function equilibrerHauteursBlocs() {
	$('.liste > li').each(function (indexOfArray, elementOfArray) {
		$(elementOfArray).css('min-height', $(elementOfArray).parent().height()-34-15-2);
	});
	
	$('.bloc-left-home > .bloc-type').each(function (indexOfArray, elementOfArray) {
		$(elementOfArray).css('min-height', $(elementOfArray).parent().height()-15-24-2);
	});
	
	$('.list > li').each(function (indexOfArray, elementOfArray) {
		$(elementOfArray).css('min-height', $(elementOfArray).parent().height()-34-18-2);
	});
	
	$('.list-inline-bis > li').each(function (indexOfArray, elementOfArray) {
		$(elementOfArray).css('min-height', $(elementOfArray).parent().height()-22-2);
	});
	
	$('.ulhauteurjs li .cadre-br').each(function (indexOfArray, elementOfArray) {
		$(elementOfArray).css('min-height', $(elementOfArray).parent().height()-37);
	});
}

function fixH(event) {
	if ($(event.data.one).size() == 1 && $(event.data.two).size() == 1) {
		$(event.data.one+", "+event.data.two).css('min-height', Math.max($(event.data.one).height(), $(event.data.two).height())-15-9-15-2);
	}
}

function fixH2(one, two) {
	if ($(one).size() == 1 && $(two).size() == 1) {
		var maxHeight = Math.max($(one).height(), $(two).height()+15+9+15+2);
		$(one).css('min-height', maxHeight);
		$(two).css('min-height', maxHeight-15-9-15-2);
	}
}

/* Popup d'aide des saisons */
function popupAide(){	
	$( "#dialog" ).removeClass('none');
	$( "#dialog" ).dialog({
		position : [500,500],
		modal: true,
		hide: { effect: 'transfer', to: '.icone-aide-saison', duration: 500 },
		close: function() {
			$( ".ui-dialog" ).hide();
			$( "#dialog" ).addClass('none');
		}
	});
}



/****POPIN****/
$(function() {
	$(".link-popin").popin ({
		width:621,
		height:450,
		opacity:.6,
		className:'searchPopin',
		onComplete: function(){
			$(".popin-content-bloc").css('height', "414px");
		}
	});

	$('li.rubrique2').first().mouseover(function(){
		$('li.rubrique2:first .ss-menu:first').css('display','block');
	});
	$('li.rubrique2').first().mouseout(function(){
		$('li.rubrique2:first .ss-menu:first').css('display','none');
	});

	
	
	/* Criteres de recherche dans les listes SIT */
    $('.form-search-left .contour-choisissez .choisissez').click(function(event) {
    	$parentDiv = $(this).parent('.contour-choisissez');
    	if(!$(this).hasClass('actif')){
			$(this).addClass('actif');
			$(".menu-choisissez", $parentDiv).removeClass('none');
			$(this).addClass('new-image-fleche');
		}
		else{
			$(this).removeClass('actif');
			$(".menu-choisissez", $parentDiv).addClass('none');
			$(this).removeClass('new-image-fleche');
		}
    });
    $('.memecategorie-choisissez li span').click(function(event) {
    	$parentLi = $(this).parent();
		if(!$parentLi.hasClass('actif')){
			$parentLi.addClass('actif');
			$('ul.s-menu', $parentLi).removeClass('none');
		}
		else{
			$parentLi.removeClass('actif');
			$('ul.s-menu', $parentLi).addClass('none');
		}
    });
    
    
    
    /* Ouverture popup d'aide des saisons */
    $('.icone-aide-saison > img').click(function() {
    	popupAide();
    });
});
