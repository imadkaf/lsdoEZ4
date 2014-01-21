{default attribute_parameters=array()}
{if $object.main_node_id|null|not}
    {$object.data_map.code.content}
{else}
    {$object.name|wash}
{/if}
{/default}