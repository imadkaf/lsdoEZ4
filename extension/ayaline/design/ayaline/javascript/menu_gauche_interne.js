$(document).ready(function() {
	//Menu left
	$("ul.menu-left > li").click(function(){
		$("ul.menu-left > li.actif").removeClass("actif");
		$(this).addClass("actif");
	});
});
