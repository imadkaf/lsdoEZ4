{default attribute_base=ContentObjectAttribute}
{let class_content=$attribute.contentclass_attribute.content}

{switch match=$class_content.selection_type}

{* Browse. *}
{case match=0}
<div class="block" id="ezobjectrelation_browse_{$attribute.id}">

<table class="list{if $attribute.content|not} hide{/if}" cellspacing="0">
<thead>
<tr>
    <th>{'Name'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Type'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Section'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Published'|i18n( 'design/standard/content/datatype' )}</th>
</tr>
</thead>
<tbody>
<tr class="bglight">
{if $attribute.content}
    {* Name *}
    <td>{$attribute.content.name|wash()}</td>

    {* Type *}
    <td>{$attribute.content.class_name|wash()}</td>

    {* Section *}
    <td>{fetch( section, object, hash( section_id, $attribute.content.section_id ) ).name|wash}</td>

    {* Published. *}
    <td>{if $attribute.content.status|ne( 1 )}
            {'No'|i18n( 'design/standard/content/datatype' )}
        {else}
            {'Yes'|i18n( 'design/standard/content/datatype' )}
        {/if}
    </td>
{else}
    <td>--name--</td>
    <td>--class-name--</td>
    <td>--section-name--</td>
    <td>--published--</td>
{/if}
</tr>
</tbody>
</table>

{if $attribute.content|not}
    <p class="ezobject-relation-no-relation">{'There are no related object.'|i18n( 'design/standard/content/datatype' )}</p>
{/if}

<div class="block inline-block ezobject-relation-browse">
<div class="left">
{if $attribute.class_content.default_selection_node}
    <input type="hidden" name="{$attribute_base}_browse_for_object_start_node[{$attribute.id}]" value="{$attribute.class_content.default_selection_node|wash}" />
{/if}
{if $attribute.content}
    <input class="button ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_object]" value="{'Remove object'|i18n( 'design/standard/content/datatype' )}" />
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Add object'|i18n( 'design/standard/content/datatype' )}" />
{else}
    <input class="button-disabled ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_object]" value="{'Remove object'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Add object'|i18n( 'design/standard/content/datatype' )}" />
{/if}

<input type="hidden" name="{$attribute_base}_data_object_relation_id_{$attribute.id}" value="{$attribute.data_int}" />
</div>
<div class="right">
    <input type="text" class="halfbox hide ezobject-relation-search-text" />
    <input type="submit" class="button hide ezobject-relation-search-btn" name="CustomActionButton[{$attribute.id}_browse_object]" value="{'Find object'|i18n( 'design/standard/content/datatype' )}" />
</div>
<div class="break"></div>
<div class="block inline-block ezobject-relation-search-browse"></div>
</div>
{include uri='design:content/datatype/edit/ezobjectrelation_ajax_search.tpl'}
</div>
{/case}




{* Dropdown list. *}
{case match=1}
{let parent_node=fetch( content, node, hash( node_id, $class_content.default_selection_node ) )}

<select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_data_object_relation_id_{$attribute.id}">
{if $attribute.contentclass_attribute.is_required|not}
<option value="" {if eq( $attribute.data_int, '' )}selected="selected"{/if}>{'No relation'|i18n( 'design/standard/content/datatype' )}</option>
{/if}
{section var=Nodes loop=fetch( content, list, hash( parent_node_id, $parent_node.node_id, sort_by, $parent_node.sort_array ) )}
<option value="{$Nodes.item.contentobject_id}" {if eq( $attribute.data_int, $Nodes.item.contentobject_id )}selected="selected"{/if}>{$Nodes.item.name|wash}</option>
{/section}
</select>

{if $class_content.fuzzy_match}
<input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_fuzzy_match" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="text" name="{$attribute_base}_data_object_relation_fuzzy_match_{$attribute.id}" value="" />
{/if}

{/let}
{/case}


{* Dropdown tree. Not implemented yet, thus unavailable from class edit mode. *}
{case match=2}
{/case}

{case/}

{/switch}

{/let}
{/default}

{* Créer un lieu *} 
<script type="text/javascript">
	var lieux = '';
	{if $attribute.content}
		lieux = '{$attribute.content.data_map.commune.content.data_map.code_postal.content} {$attribute.content.name|wash()}';
	{/if}
</script>