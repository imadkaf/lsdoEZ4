function getSearchOptions(valueSearch, attributeId, categoryAttributeValue, thisInputId) {
	if (typeof jQuery != 'undefined') {
		jQuery.get(
			jQuery('.ezcategoryselection-search-url').val()+"?s="+encodeURI(valueSearch)+"&ai="+attributeId+"&cav="+jQuery('select[id^="'+categoryAttributeValue+'"] option:selected').val(),
			function (data) {
				jQuery('#'+thisInputId).next().html(data).css('min-width', jQuery('#'+thisInputId).width()+4);
			}
		);
	}
}

if (typeof jQuery != 'undefined') {
	jQuery('.ezcategoryselection-remove-option').live('click', function () {
		jQuery(this).nextAll().each(function (indexInArray, valueOfElement) {
			if (jQuery(valueOfElement).css('background-color') == "#FFFFFF") {
				jQuery(valueOfElement).css('background-color', "#F5F5F5");
			} else {
				jQuery(valueOfElement).css('background-color', "#FFFFFF");
			}
		});

		jQuery(this).parent().remove();
		return false;
	});
}