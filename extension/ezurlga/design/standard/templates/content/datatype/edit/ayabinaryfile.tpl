{default attribute_base=ContentObjectAttribute}
{def $defaultCategory = ezini('TagsGA','defaultCategory','brochure.ini')}
{def $defaultAction = ezini('TagsGA','defaultAction','brochure.ini')}

{* Current file. *}
<div class="block">
<label>{'Current file'|i18n( 'design/standard/content/datatype' )}:</label>
{if $attribute.content}
<table class="list" cellspacing="0">
<tr>
<th>{'Filename'|i18n( 'design/standard/content/datatype' )}</th>
<th>{'MIME type'|i18n( 'design/standard/content/datatype' )}</th>
<th>{'Size'|i18n( 'design/standard/content/datatype' )}</th>
</tr>
<tr>
<td>{$attribute.content.original_filename|wash( xhtml )}</td>
<td>{$attribute.content.mime_type|wash( xhtml )}</td>
<td>{$attribute.content.filesize|si( byte )}</td>
</tr>
</table>
{else}
<p>{'There is no file.'|i18n( 'design/standard/content/datatype' )}</p>
{/if}

{if $attribute.content}
<input class="button" type="submit" name="CustomActionButton[{$attribute.id}_delete_binary]" value="{'Remove'|i18n( 'design/standard/content/datatype' )}" title="{'Remove the file from this draft.'|i18n( 'design/standard/content/datatype' )}" />
{else}
<input class="button-disabled" type="submit" name="CustomActionButton[{$attribute.id}_delete_binary]" value="{'Remove'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
{/if}
</div>

{* New file. *}
<div class="block">
<label for="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}">{'New file for upload'|i18n( 'design/standard/content/datatype' )}:</label>
<input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1}000000"/>
<input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_data_binaryfilename_{$attribute.id}" type="file" />
</div>

{* Google tag. *}
<div class="block">
	{def $gTags=$attribute.data_text|explode(';')}
	{def $defaultLabel = $gTags[2]}
	
	{* value for category tag *}
	{if ne($gTags[0],'')} 
		{set $defaultCategory=$gTags[0]|wash( xhtml )}  
	{/if}
	
	{* value for action tag *}
	{if ne($gTags[1],'')} 
		{set $defaultAction=$gTags[1]|wash( xhtml )} 
	{/if}
	
	{* value for label tag *}
	{if eq($gTags[2],'')}
		{set $defaultLabel=$attribute.object.name}
	{/if}
	
    <label for="{$id_base}_cat">{'Category'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_cat" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ayabinaryfile_category_{$attribute.id}" value="{$defaultCategory}" />
    <br />
    <label for="{$id_base}_act">{'Action'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_act" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ayabinaryfile_action_{$attribute.id}" value="{$defaultAction}" />
    <br />
    <label for="{$id_base}_lab">{'Label'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="{$id_base}_lab" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" size="70" name="{$attribute_base}_ayabinaryfile_label_{$attribute.id}" value="{$defaultLabel}" />
    <br />
</div>

{undef $defaultCategory}
{undef $defaultAction}
{undef $defaultLabel}

{/default}