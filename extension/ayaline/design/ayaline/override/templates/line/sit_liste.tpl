{def $typeImage = ''}
{def $tailleDef = 0}
{if eq($node.parent.parent.object.class_identifier, ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
	{set $typeImage = 'list_sousrubric'}
	{set $tailleDef = 250}
{else}
	{set $typeImage = 'list_rubric'}
	{set $tailleDef = 225}
{/if}

<h3 class="bloc-liste-h3">
	<a href={$node.url_alias|ezurl}>{if is_set($nomEnfant)}{$nomEnfant}{else}{$node.name|wash}{/if}</a>
</h3>
	
{if $node.data_map.thumbnail.has_content}
	<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute=$node.data_map.thumbnail image_class=$typeImage}</a>
{else}
	<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_grande.jpg'|ezimage} width="{$tailleDef}px" alt="{if is_set($nomEnfant)}{$nomEnfant}{else}{$node.name|wash}{/if}" title="{if is_set($nomEnfant)}{$nomEnfant}{else}{$node.name|wash}{/if}" /></a>
{/if}

<p>
	{if eq($node.data_map.short_description.content|count_chars(), $node.data_map.short_description.content|word_cut(13)|count_chars|inc)}
		{attribute_view_gui attribute = $node.data_map.short_description}
	{else}
		{$node.data_map.short_description.content|wash|word_cut(13)}...
	{/if}
</p>

<p class="lien-bas">
	<a href={$node.url_alias|ezurl}>En savoir plus</a>
</p>
