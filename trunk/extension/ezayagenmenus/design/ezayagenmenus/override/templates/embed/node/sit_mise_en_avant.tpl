{set-block variable=$content_sit_mise_en_avant}
{if eq($node.data_map.mode_affichage.value.0, 2)}
	{if $node.data_map.title|ne('')}
	<div class="bloc-type">
		<h2 class="bloc-liste-h2-cote">{attribute_view_gui attribute = $node.data_map.title}</h2>
		<p class="clear"></p>
		
		{sit_mise_en_avant($node, $node.data_map.mode_affichage.value, sit_mise_en_avant_mode2_titre)}
	</div>
	{else}
		{sit_mise_en_avant($node, $node.data_map.mode_affichage.value, sit_mise_en_avant_mode2_titre)}
	{/if}
{else}
	{sit_mise_en_avant($node, $node.data_map.mode_affichage.value)}
{/if}
{/set-block}
{def $hostNamePrefix = ezayagenmenus_get_hostname()}
{ezayagenmenus_str_replace( 'src="/',concat('src="',$hostNamePrefix,'/') , $content_sit_mise_en_avant)}
{undef $hostNamePrefix}