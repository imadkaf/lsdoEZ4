{def $affichageListeSITMenu = fetch( 'content', 'reverse_related_objects',
									hash( 'object_id', $node.contentobject_id,
											'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}

{if $affichageListeSITMenu|count}
{if $affichageListeSITMenu.0.data_map.thumbnail.has_content}
	{attribute_view_gui attribute = $affichageListeSITMenu.0.data_map.thumbnail image_class='main_menu' href=$node.url_alias|ezurl}
{else}
	<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_moyenne.jpg'|ezimage} width="90" alt="{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}" title="{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}" /></a>
{/if}
	<h2><a href={$node.url_alias|ezurl}>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</a></h2>
	
	<p>
		{$affichageListeSITMenu.0.data_map.short_description.content|wash|shorten(60)}
	</p>
{else}
	<h2><a href={$node.url_alias|ezurl}>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</a></h2>
{/if}
