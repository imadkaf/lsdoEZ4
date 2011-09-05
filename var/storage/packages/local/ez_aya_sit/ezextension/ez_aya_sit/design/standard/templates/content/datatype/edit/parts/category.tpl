<script type="text/javascript">
//<!--
var timerCategorySelection{$attribute.id} = null;
var timerCategorySelectionHide{$attribute.id} = null;

if (jQuery) {ldelim}
	jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').attr('autocomplete', "off");

	jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').live('keypress', function (event) {ldelim}
		if (event.keyCode == 13) {ldelim}

			return false;
		{rdelim}

	{rdelim});

	jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').live('keyup', function (event) {ldelim}
		if (event.keyCode == 13) {ldelim}

			return false;
		{rdelim}

		//if (jQuery(this).val().length >= 3) {ldelim}

			if (timerCategorySelection{$attribute.id}) {ldelim}

				clearTimeout(timerCategorySelection{$attribute.id});
			{rdelim}

			timerCategorySelection{$attribute.id} = setTimeout("getSearchOptions('"+jQuery(this).val().replace(/\'/, "\\'")+"', '{$attribute.contentclass_attribute.id}', 'ezcoa-{$attribute.class_content.categories.0.category_id}', '"+jQuery(this).attr('id')+"')", 500);
		//{rdelim}

	{rdelim});

	jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').live('blur', function () {ldelim}

		timerCategorySelectionHide{$attribute.id} = setTimeout("jQuery('ul', jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').next()).hide()", 2000);
	{rdelim});

	jQuery('ul.ezcategoryselection-found-options-{$attribute.contentclass_attribute.id}').live('mouseenter', function () {ldelim}
		if (timerCategorySelectionHide{$attribute.id}) {ldelim}

			clearTimeout(timerCategorySelectionHide{$attribute.id});
		{rdelim}

	{rdelim});

	jQuery('ul.ezcategoryselection-found-options-{$attribute.contentclass_attribute.id}').live('mouseleave', function () {ldelim}
		timerCategorySelectionHide{$attribute.id} = setTimeout("jQuery('ul', jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').next()).hide()", 500);
	{rdelim});

	jQuery('ul.ezcategoryselection-found-options-{$attribute.contentclass_attribute.id} a').live('click', function () {ldelim}
{if $attribute.class_content.is_multiselect}
		selectedOptionHiddenInput = jQuery('ul.ezcategoryselection-selected-options li input[value="'+jQuery(this).next().val()+'"]', jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').parent().next());
		if (selectedOptionHiddenInput.size() == 0 || selectedOptionHiddenInput.attr('disabled') == "disabled" || selectedOptionHiddenInput.attr('disabled') == true) {ldelim}

			if (selectedOptionHiddenInput.size() == 0) {ldelim}

				jQuery('ul.ezcategoryselection-selected-options', jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').parent().next()).append('<li style="padding:2px 0;margin:0;background-color:#'+(jQuery('ul.ezcategoryselection-selected-options li', jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').parent().next()).size() % 2 == 0 ? 'FFFFFF' : 'F5F5F5')+'"><span>'+jQuery(this).html()+'</span> <a href="#" class="ezcategoryselection-remove-option"><img src={'croix.png'|ezimage} alt="" style="margin-top:-2px" /></a><input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}[]" value="'+jQuery(this).next().val()+'" /></li>');
			{rdelim} else {ldelim}

				selectedOptionHiddenInput.attr('disabled', "");
				selectedOptionHiddenInput.parent().css('display', "block");
				selectedOptionHiddenInput.prevAll('span').html(jQuery(this).html());
			{rdelim}

		{rdelim}
{else}
		jQuery('ul.ezcategoryselection-selected-options', jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').parent().next()).html('<li style="padding:2px 0;margin:0;background-color:#FFFFFF"><span>'+jQuery(this).html()+'</span> <a href="#" class="ezcategoryselection-remove-option"><img src={'croix.png'|ezimage} alt="" style="margin-top:-2px" /></a><input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}[]" value="'+jQuery(this).next().val()+'" /></li>');
{/if}

		if (timerCategorySelectionHide{$attribute.id}) {ldelim}
			clearTimeout(timerCategorySelectionHide{$attribute.id});
		{rdelim}

		jQuery('#{$attribute_base}_ezselect_selected_search_{$attribute.id}').val('');

		return false;
	{rdelim});

{rdelim}

//-->
</script>
