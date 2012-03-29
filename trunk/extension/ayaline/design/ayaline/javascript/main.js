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
});

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

$(document).ready(function(){
	$('li.rubrique2').first().mouseover(function(){
		$('li.rubrique2:first .ss-menu:first').css('display','block');
	});
	$('li.rubrique2').first().mouseout(function(){
		$('li.rubrique2:first .ss-menu:first').css('display','none');
	});
});

/* Criteres de recherche dans les listes SIT */
/*
$(document).ready(function(){
    $('.form-search-left .contour-choisissez .choisissez').click(function() {
		if(!$(this).hasClass('actif')){
			$(this).addClass('actif');
			$parentDiv = $(this).parent('.contour-choisissez');
			$parentDiv.children(".menu-choisissez").removeClass('none');
			$(this).css('background-image', 'url(../images/picto-on.png)');
		}
		else{
			$(this).removeClass('actif');
			$parentDiv = $(this).parent('.contour-choisissez');
			$parentDiv.children(".menu-choisissez").addClass('none');
			$(this).css('background-image', 'url(../images/fleche-r.png)');
		}
    });
    
    $('.memecategorie-choisissez li span').click(function() {
		if(!$(this).parent().hasClass('actif')){
			$(this).parent().addClass('actif');
			$(this).parent().children('ul.s-menu').removeClass('none');
		}
		else{
			$(this).parent().removeClass('actif');
			$(this).parent().children('ul.s-menu').addClass('none');
		}
    });
});
*/