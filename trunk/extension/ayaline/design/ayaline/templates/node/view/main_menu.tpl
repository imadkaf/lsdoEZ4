{if is_set($node.data_map.thumbnail)}
	{if $node.data_map.thumbnail.has_content}
													{attribute_view_gui attribute = $node.data_map.thumbnail image_class='main_menu' href=$node.url_alias|ezurl}
	{/if}
{/if}
													<h2><a href={$node.url_alias|ezurl}>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</a></h2>
{if is_set($node.data_map.short_description)}
	{if $node.data_map.short_description.has_content}
													<p>
														{attribute_view_gui attribute = $node.data_map.short_description nbChar=60}
													</p>
	{/if}
{/if}