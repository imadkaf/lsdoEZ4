{if eq($node.data_map.mode_affichage.value.0, 2)}
	<div class="bloc-type">
		<h2 class="bloc-liste-h2-cote">{attribute_view_gui attribute = $node.data_map.title}</h2>
		<p class="clear"></p>
		
		{sit_mise_en_avant($node, $node.data_map.mode_affichage.value, sit_mise_en_avant_mode2_titre)}
	</div>
{else}
	{sit_mise_en_avant($node, $node.data_map.mode_affichage.value)}
{/if}
