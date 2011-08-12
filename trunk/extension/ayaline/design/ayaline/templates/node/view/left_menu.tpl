{def $nodeFiltre = fetch('content','list', hash(
											'parent_node_id', $node.node_id,
											'sort_by', $node.sort_array,
											'class_filter_type' , 'include',
											'class_filter_array', array('rubric', 'simple_free_content', 'page_contact', 'sit_liste', 'ayaline_gallery', 'gallery_category_photo', 'gallery_category_video', 'gallery_gallery_photo', 'site_map', 'brochures', 'survey', 'faqs', 'faq', 'brochure') ))}
								{if not($nodeFiltre|count)}
									<a href={$node.url_alias|ezurl}><span>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</span></a>
								{else}
									<span>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</span>
								{/if}
								{if $nodeFiltre|count}
								<ul class="s-menu">
{foreach $nodeFiltre as $child}
									<li><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></li>
{/foreach}
								</ul>
								{/if}