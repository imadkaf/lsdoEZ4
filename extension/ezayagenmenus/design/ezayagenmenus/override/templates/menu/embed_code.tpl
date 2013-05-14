{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $node.data_map.code.content )}
{undef $hostNamePrefix}