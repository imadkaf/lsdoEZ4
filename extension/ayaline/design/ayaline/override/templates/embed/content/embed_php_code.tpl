<div class="ez-oe-embed">
<div {if is_set($object_parameters.align)}class="{concat('embed-align-',$object_parameters.align)}{/if}">
{default attribute_parameters=array()}
{if $object.main_node_id|null|not}
    {$object.data_map.code.content|evalphpcode}
{else}
    {$object.name|wash}
{/if}
{/default}
</div>
<div class="clear_both"></div>
</div>