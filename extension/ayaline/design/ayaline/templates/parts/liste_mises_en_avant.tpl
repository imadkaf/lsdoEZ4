{def $mises_en_avant = fetch( 'content','list',hash(
	'parent_node_id', $node.node_id,
	'attribute_filter', array(array('sit_mise_en_avant/mode_affichage', '!=', '6'))
))}

{def $noeudCourant = ''}

{if $mises_en_avant|count|gt(0)}
	{foreach $mises_en_avant as $mise_en_avant}
		{set $noeudCourant = fetch('content', 'node', hash('node_id', $mise_en_avant.node_id))}
		
		{node_view_gui content_node=$noeudCourant view='embed'}
		<p style="margin-bottom: 15px;"></p>
	{/foreach}
{/if}

{undef $noeudCourant}
