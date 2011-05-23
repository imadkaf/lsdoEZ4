{if $node.data_map.thumbnail.has_content}
													{attribute_view_gui attribute = $node.data_map.thumbnail image_class='main_menu' href=$node.url_alias|ezurl}
{/if}
													<h2><a href={$node.url_alias|ezurl}>{$node.name}</a></h2>
{if $node.data_map.short_description.has_content}
													<p>
														{attribute_view_gui attribute = $node.data_map.short_description nbChar=60}
													</p>
{/if}