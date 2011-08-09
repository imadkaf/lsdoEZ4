{def $affichageListeSIT = fetch( 'content', 'reverse_related_objects',
									hash( 'object_id', $node.contentobject_id,
											'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}

{def $typeImage = ''}
{def $tailleDef = 0}
{if eq($node.parent.parent.object.class_identifier, ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
	{set $typeImage = 'list_sousrubric'}
	{set $tailleDef = 250}
{else}
	{set $typeImage = 'list_rubric'}
	{set $tailleDef = 225}
{/if}

{if $affichageListeSIT|count}
	<h3 class="bloc-liste-h3">
		<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute = $affichageListeSIT.0.data_map.title}</a>
	</h3>
	
	{if $affichageListeSIT.0.data_map.thumbnail.has_content}
		<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute=$affichageListeSIT.0.data_map.thumbnail image_class=$typeImage}</a>
	{else}
		<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_grande.jpg'|ezimage} width="{$tailleDef}px" alt="{attribute_view_gui attribute = $node.name}" title="{attribute_view_gui attribute = $node.name}" /></a>
	{/if}
	
	<p>
		{$affichageListeSIT.0.data_map.short_description.content|wash|shorten(65)}
	</p>
	
	<p class="lien-bas">
		<a href={$node.url_alias|ezurl}>En savoir plus</a>
	</p>
{else}
	<h3 class="bloc-liste-h3">
		<a href={$node.url_alias|ezurl}>{$node.name}</a>
	</h3>
	
	<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_grande.jpg'|ezimage} width="{$tailleDef}px" alt="{attribute_view_gui attribute = $node.name}" title="{attribute_view_gui attribute = $node.name}" /></a>
	<br /><br />
	
	<p class="lien-bas">
		<a href={$node.url_alias|ezurl}>En savoir plus</a>
	</p>
{/if}
