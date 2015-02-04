{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{default attribute_base=ContentObjectAttribute}
{let selected_id_array=$attribute.content}
{* Always set the .._selected_array_.. variable, this circumvents the problem when nothing is selected. *} 
<input type="hidden" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}" value="" />
<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_ezselect_selected_array_{$attribute.id}[]"{section show=$attribute.class_content.is_multiselect} multiple="multiple" size="10"{/section}>
{section var=Options loop=$attribute.class_content.options}
<option value="{$Options.item.id}"{section show=$selected_id_array|contains( $Options.item.id )} selected="selected"{/section}>{$Options.item.name|wash( xhtml )}</option>
{/section}
</select>
<script type="text/javascript">
//<!--
jQuery(document).on('change', '.ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}', function () {ldelim}

	jQuery('.ezcategoryselection-selected-options-{$attribute.contentclassattribute_id} li a').each(function (indexInArray, valueOfElement) {ldelim}
		var ezccaCategories = jQuery('.ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}').val();

		if (jQuery(valueOfElement).attr('rel').match(new RegExp("-("+ezccaCategories.join("|")+")-"))) {ldelim}

			jQuery(valueOfElement).next().removeAttr('disabled');
			jQuery(valueOfElement).parent().css('display', '');
		{rdelim} else {ldelim}

			jQuery(valueOfElement).next().attr('disabled', 'disabled');
			jQuery(valueOfElement).parent().css('display', 'none');
		{rdelim}

	{rdelim});

{rdelim});

//-->
</script>
{/let}
{/default}
