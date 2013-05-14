{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{def $_content = ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $node.data_map.code.content )}
{set $_content = ezayagenmenus_str_replace( 'href="/',concat('href="',$hostNamePrefix,'/') , $_content)}
{$_content}
{undef $hostNamePrefix $_content}