{set-block variable=$content_sit_mise_en_avant}
{sit_mise_en_avant(null, $object.data_map.mode_affichage.value)}
{/set-block}
{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $content_sit_mise_en_avant)}
{undef $hostNamePrefix}