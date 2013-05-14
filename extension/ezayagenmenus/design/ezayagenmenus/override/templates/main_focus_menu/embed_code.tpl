{set-block variable=$_contentHtml}
    {if $node.data_map.code.has_content}
    {attribute_view_gui attribute = $node.data_map.code toFormat=false}
    {/if}
{/set-block}
{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{def $_content = ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $_contentHtml)}
{set $_content = ezayagenmenus_str_replace( 'href="/',concat('href="',$hostNamePrefix,'/') , $_content)}
{$_content}
{undef $hostNamePrefix $_content}