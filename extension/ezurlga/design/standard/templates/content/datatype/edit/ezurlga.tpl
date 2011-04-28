{default attribute_base=ContentObjectAttribute}
{if ne( $attribute_base, 'ContentObjectAttribute' )}
    {def $id_base = concat( 'ezcoa-', $attribute_base, '-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{else}
    {def $id_base = concat( 'ezcoa-', $attribute.contentclassattribute_id, '_', $attribute.contentclass_attribute_identifier )}
{/if}

{* URL. *}
<div class="block">
    <label for="{$id_base}_url">{'URL'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_url" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurlga_url_{$attribute.id}" value="{$attribute.content[0]|wash( xhtml )}" />
</div>

{* Text. *}
<div class="block">
    <label for="{$id_base}_text">{'Text'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_text" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurlga_text_{$attribute.id}" value="{$attribute.content[1]|wash( xhtml )}" />
</div>

{* Google tag. *}
<div class="block">
    <label for="{$id_base}_cat">{'Category'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_cat" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurlga_category_{$attribute.id}" value="{$attribute.content[2]|wash( xhtml )}" />
    <br />
    <label for="{$id_base}_act">{'Action'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_act" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurlga_action_{$attribute.id}" value="{$attribute.content[3]|wash( xhtml )}" />
    <br />
    <label for="{$id_base}_lab">{'Label'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_lab" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ezurlga_label_{$attribute.id}" value="{$attribute.content[4]|wash( xhtml )}" />
    <br />
</div>

{/default}