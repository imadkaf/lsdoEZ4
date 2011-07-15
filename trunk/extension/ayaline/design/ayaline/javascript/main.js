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
	} );
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
