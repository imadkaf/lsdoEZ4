 {def $videos = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_video') ))}
{if $videos|count|gt(0)}
	<ul class="gallery-videos">
	{foreach $videos as $video}
		<li>
			<div><strong><a href={$video.url_alias|ezurl}>{$video.name|wash}</a></strong></div>
			<div><a href={$video.url_alias|ezurl}>{attribute_view_gui attribute=$video.data_map.thumbnail image_class=medium}</a></div>
		</li>
	{/foreach}
	</ul>
	<div class="clear"></div>
{/if}
