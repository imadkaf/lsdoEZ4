{set-block variable=$content_sit_mise_en_avant}
{sit_mise_en_avant(null, $object.data_map.mode_affichage.value)}
{/set-block}
{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{def $_content = ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $content_sit_mise_en_avant)}
{set $_content = ezayagenmenus_str_replace( 'href="/',concat('href="',$hostNamePrefix,'/') , $_content)}
{$_content}
{undef $hostNamePrefix $_content}