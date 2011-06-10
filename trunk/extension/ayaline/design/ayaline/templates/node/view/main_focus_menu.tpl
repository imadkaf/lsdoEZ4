{if is_set($node.data_map.thumbnail)}
	{if $node.data_map.thumbnail.has_content}
{attribute_view_gui attribute = $node.data_map.thumbnail image_class='main_focus_menu'}
	{/if}
{/if}
<p class="title">{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</p>
<span>{$node.object.modified||datetime(ezini( 'RegionalSettings', 'Locale' ))}</span>
{if is_set($node.data_map.short_description)}
	{if $node.data_map.short_description.has_content}
<p>
	{attribute_view_gui attribute = $node.data_map.short_description nbChar=140}
</p>
	{/if}
{/if}
<p class="lien-bas">
	<a class="type5" href={$node.parent.url_alias|ezurl}>{$node.parent.name|wash}</a>
</p>