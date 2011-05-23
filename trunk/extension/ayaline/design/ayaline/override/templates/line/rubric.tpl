{def $description = ''}

<h3 class="bloc-liste-h3">
	<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute = $node.data_map.title}</a>
</h3>

{* Si la classe du noeud est = 'rubric'
{if eq($node.?, 'rubric')}
{else}
{/if}
*}

{attribute_view_gui attribute = $node.data_map.thumbnail}

<p>
	{$node.data_map.short_description.content|wash|shorten(90)}
</p>

<p class="lien-bas">
	<a href={$node.url_alias|ezurl}>En savoir plus</a>
</p>
