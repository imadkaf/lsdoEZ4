{def $noeudCourant = ''}

<div class="icons">
	{* Pour chaque contenus lies a la page d'accueil *}
	{foreach $node.data_map.bloc_accueil.content.relation_list as $contenu}
		{set $noeudCourant = fetch( 'content', 'node', hash( 'node_id', $contenu.node_id ) ) }
		<div class="icon">
			{node_view_gui content_node=$noeudCourant view='line'}
		</div>
	{/foreach}
	<div class="clear"></div>
</div>
