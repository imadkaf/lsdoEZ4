{if is_set($nomHorizSubMenu)}<a href={$node.url_alias|ezurl}>{$nomHorizSubMenu|wash}</a>
{else}{attribute_view_gui attribute = $node.data_map.description}
{/if}