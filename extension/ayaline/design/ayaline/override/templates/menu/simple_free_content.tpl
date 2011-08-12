{if is_set($nomSousMenu)}<a href={$node.url_alias|ezurl}>{$nomSousMenu|wash}</a>
{else}{attribute_view_gui attribute = $node.data_map.description}
{/if}