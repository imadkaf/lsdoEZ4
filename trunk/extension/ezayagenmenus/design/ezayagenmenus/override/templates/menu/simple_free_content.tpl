{def $hostname = ezayagenmenus_get_hostname()}
{if is_set($nomSousMenu)}<a href="{concat($hostname, $node.url_alias|ezurl('no'))}">{$nomSousMenu|wash}</a>
{else}{attribute_view_gui attribute = $node.data_map.description}
{/if}
{undef $hostname}