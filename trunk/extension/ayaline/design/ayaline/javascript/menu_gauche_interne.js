$(document).ready(function() {
	//Menu left
	$("menu-gauche-normal > ul.menu-left > li > span").click(function(){
		$("ul.menu-left > li.actif").removeClass("actif");
		$(this).parent().addClass("actif");
	});
});
