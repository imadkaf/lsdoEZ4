{def $mises_en_avant = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
											'class_filter_type',  'include',
	              							'class_filter_array', array('sit_mise_en_avant') ))}

{if $mises_en_avant|count|gt(0)}
	{def $noeudMiseEnAvant = fetch('content', 'node', hash('node_id', $mises_en_avant.0.node_id))}

	<div class="mise-en-avant">
		{sit_mise_en_avant(null, $noeudMiseEnAvant.data_map.mode_affichage.value)}
		<div class="clear"></div>
	</div>
{/if}
