{if $node.data_map.thumbnail.has_content}
	{attribute_view_gui attribute = $node.data_map.thumbnail image_class='main_menu' href=$node.url_alias|ezurl}
{else}
	<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_moyenne.jpg'|ezimage} width="90" alt="{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}" title="{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}" /></a>
{/if}

<h2><a href={$node.url_alias|ezurl}>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</a></h2>

{if $node.data_map.short_description.has_content}
	<p> 
		{if eq($node.data_map.short_description.content|count_chars(), $node.data_map.short_description.content|word_cut(14)|count_chars|inc)}
			{attribute_view_gui attribute = $node.data_map.short_description}
		{else}
			{$node.data_map.short_description.content|wash|word_cut(14)}...
		{/if}
	</p>
{/if}
