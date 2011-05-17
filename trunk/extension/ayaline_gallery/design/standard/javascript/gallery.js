function ajax_display(strURL) {
	if (jQuery.browser.msie && navigator.userAgent.indexOf("MSIE 7") == -1 && navigator.userAgent.indexOf("MSIE 8") == -1) {
		jQuery('html, body').animate({scrollTop: 0}, 500);
	}
 
	var xmlHttpReq = false;
 
	jQuery('.cache-popin').css('height', jQuery('body').height()+"px");
	jQuery('.popin-loader').fadeIn(500);
 
	new Ajax.Request(strURL, {
		method: 'get',
		onComplete: function(transport) {
			ajax_updatecart();
			jQuery('.popin-loader').hide();
			jQuery('.popin-panier').show();
							}
						});
 
	return false;
}