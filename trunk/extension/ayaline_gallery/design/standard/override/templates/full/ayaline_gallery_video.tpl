{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent_node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}
 
{def $limit = 12}
{def $offset = 0}
{if $view_parameters.offset|gt(0)}
	{set $offset = $view_parameters.offset}
{/if}

{def $videos = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
											'sort_by', $node.sort_array,
											'class_filter_type',  'include',
              								'class_filter_array', array('gallery_video'),
              								'limit',$limit,
              								'offset',$offset ))}
              								
{def $videos_count = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id, 
											'sort_by', $node.sort_array,
											'class_filter_type',  'include',
              								'class_filter_array', array('gallery_video') ))}     
         
              										  										
              										  										             										
<div class="ayaline-gallery">
	<h1>{$node.name|wash}</h1>
	
	<div class="description">{attribute_view_gui attribute=$node.data_map.description}</div>
	
	<div class="gallery-content">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		
		<div class="gallery-tab-content">
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
		{else}
			<div class="message">Aucune video n'est disponible pour le moment.</div>
		{/if}
		
			<div class="navigator">
				{include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$videos_count
                     view_parameters=$view_parameters
                     item_limit=$limit}
            </div>
		</div>
	</div>
</div>

	
              										
         
</div>