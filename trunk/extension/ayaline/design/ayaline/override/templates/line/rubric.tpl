{def $description = ''}

{def $typeImage = ''}
{if eq($node.parent.parent.object.class_identifier, ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
	{set $typeImage = 'list_sousrubric'}
{else}
	{set $typeImage = 'list_rubric'}
{/if}

<h3 class="bloc-liste-h3">
	<a href={$node.url_alias|ezurl}>{if is_set($nomEnfant)}{$nomEnfant}{else}{$node.name}{/if}</a>
</h3>

<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute=$node.data_map.thumbnail image_class=$typeImage}</a>

<p>
	{$node.data_map.short_description.content|wash|shorten(65)}
</p>

<p class="lien-bas">
	<a href={$node.url_alias|ezurl}>En savoir plus</a>
</p>
