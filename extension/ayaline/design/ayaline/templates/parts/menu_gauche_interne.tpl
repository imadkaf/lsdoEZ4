{def $childParent = fetch('content','list', hash(
											'parent_node_id', $node.parent.node_id,
											'sort_by', $node.sort_array,
											'class_filter_type' , 'include',
											'class_filter_array', array('rubric', 'simple_free_content', 'page_contact', 'sit_liste', 'ayaline_gallery', 'gallery_category_photo', 'gallery_category_video', 'gallery_gallery_photo', 'site_map', 'brochures', 'survey', 'faqs', 'faq', 'brochure') ))}

{def $children1 = ''}

<div class="bloc-type">
	<h2 class="menu-gauche-h2">
		{attribute_view_gui attribute = $node.parent.data_map.title}
	</h2>
	
	<p class="clear"></p>
	<ul class="menu-left">
	{foreach $childParent as $childP}

		{set $children1 = fetch('content','list', hash(
											'parent_node_id', $childP.node_id,
											'sort_by', $node.sort_array,
											'class_filter_type' , 'include',
											'class_filter_array', array('rubric', 'simple_free_content', 'page_contact', 'sit_liste', 'ayaline_gallery', 'gallery_category_photo', 'gallery_category_video', 'gallery_gallery_photo', 'site_map', 'brochures', 'survey', 'faqs', 'faq', 'brochure') ))}

		{if eq($childP.node_id,$node.node_id)}
		<li class="actif">
		{else}
		<li>
		{/if}
			{if not($children1|count)}
				<a href={$childP.url_alias|ezurl}><span>{$childP.name}</span></a>
			{else}
				<span>{$childP.name}</span>
			{/if}
			{if $children1|count}
				<ul class="s-menu">
				{foreach $children1 as $child}
					<li><a href={$child.url_alias|ezurl}>{$child.name}</a></li>
				{/foreach}
				</ul>
			{/if}
		</li>
	{/foreach}
	</ul>
</div>
