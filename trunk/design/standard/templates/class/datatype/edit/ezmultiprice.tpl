{* DO NOT EDIT THIS FILE! Use an override template instead. *}

<div class="block">
<label>{'Default currency'|i18n( 'design/standard/class/datatype' )}:</label>
<select name="ContentClass_ezmultiprice_currency_code_{$class_attribute.id}">
{section name=CurrencyList loop=$class_attribute.content.currency_list}
<option value="{$CurrencyList:item.code}" {if eq( $CurrencyList:item.code, $class_attribute.data_text1 )}selected="selected"{/if}>{$CurrencyList:item.code|wash}</option>
{/section}
</select>
</div>

<div class="block">
<label>{'Default VAT'|i18n( 'design/standard/class/datatype' )}:</label>
<select name="ContentClass_ezmultiprice_include_vat_{$class_attribute.id}">
<option value="1" {if eq( $class_attribute.data_int1, 1 )}selected="selected"{/if}>{'Price inc. VAT'|i18n( 'design/standard/class/datatype' )}</option>
<option value="2" {if eq( $class_attribute.data_int1, 2 )}selected="selected"{/if}>{'Price ex. VAT'|i18n( 'design/standard/class/datatype' )}</option>
</select>
</div>

<div class="block">
<label>{'Default VAT type'|i18n( 'design/standard/class/datatype' )}:</label>
{include uri='design:shop/vattype/edit.tpl'
         select_name=concat( "ContentClass_ezmultiprice_vat_id_", $class_attribute.id )
         vat_types=$class_attribute.content.vat_type
         current_val=$class_attribute.data_float1}
</div>