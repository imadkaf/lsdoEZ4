<div class="ayaline-gallery">
	<h1>{$node.name|wash}</h1>
	{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent_node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}

{def $limit = 12}
{def $offset = 0}
{def $picture = ''}
{if $view_parameters.offset|gt(0)}
	{set $offset = $view_parameters.offset}
{/if}
{def $galleries = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_gallery_photo'),
              										'limit',$limit,
              										'offset',$offset ))}
              										
{def $galleries_count = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_gallery_photo') ))}   
              											
	<div class="gallery-content">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		<div class="gallery-tab-content">
		


		  
         
              										  										
		{if $galleries_count|gt(0)}
			{foreach $galleries as $gallery}
				<div class="gallery-gallery-photos">
					
					
					{* get photo of the gallery, or take the first one in the gallery *}
					{if $gallery.data_map.image.content.is_valid}
						<div class="gallery-picture">
							<a href={$gallery.url_alias|ezurl}>{attribute_view_gui attribute=$gallery.data_map.image}</a>
						</div>
					{else}
						{set $picture = fetch( 'content','list',hash( 'parent_node_id', $gallery.node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_photo'),
              										'limit',1 ))}
              			{if $picture|count|eq(1)}
              			<div class="gallery-picture">
							<a href={$gallery.url_alias|ezurl}>{attribute_view_gui attribute=$picture[0].data_map.image image_class='small'}</a>
						</div>
              			{/if}						
					{/if}
					
					<div class="gallery-description">
						<div class="gallery-title"><a href={$gallery.url_alias|ezurl}>{$gallery.name|wash}</a></div>
						{attribute_view_gui attribute=$gallery.data_map.description}
					</div>
				</div>
				<div class="clear"></div>
			{/foreach}
			<div class="clear"></div>
		{else}
			<div class="message">Aucune photo n'est disponible pour le moment.</div>
		{/if}
			<div class="navigator">
				{include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$photos_count
                     view_parameters=$view_parameters
                     item_limit=$limit}
            </div>
		</div>
	</div>
</div>

	
              										
         
</div>