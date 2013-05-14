{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{set-block variable=$_contentHtml}
{if is_set($nomSousMenu)}
    <a href="{concat($hostNamePrefix, $node.url_alias|ezurl('no'))}">{$nomSousMenu|wash}</a>
{else}
    {attribute_view_gui attribute = $node.data_map.description}
{/if}
{/set-block}
{def $_content = ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $_contentHtml)}
{set $_content = ezayagenmenus_str_replace( 'href="/',concat('href="',$hostNamePrefix,'/') , $_content)}
{$_content}
{undef $hostNamePrefix $_content}