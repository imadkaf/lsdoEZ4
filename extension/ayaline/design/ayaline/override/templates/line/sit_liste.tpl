{def $affichageListeSIT = fetch( 'content', 'reverse_related_objects',
									hash( 'object_id', $node.contentobject_id,
											'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}

{if $affichageListeSIT|count}
	<h3 class="bloc-liste-h3">
		<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute = $affichageListeSIT.0.data_map.title}</a>
	</h3>
	
	<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute=$affichageListeSIT.0.data_map.thumbnail image_class='list_rubric'}</a>
	
	<p>
		{$affichageListeSIT.0.data_map.short_description.content|wash|shorten(65)}
	</p>
	
	<p class="lien-bas">
		<a href={$node.url_alias|ezurl}>En savoir plus</a>
	</p>
{else}
	<h3 class="bloc-liste-h3">
		<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute = $node.name}</a>
	</h3>
	
	<p class="lien-bas">
		<a href={$node.url_alias|ezurl}>En savoir plus</a>
	</p>
{/if}
