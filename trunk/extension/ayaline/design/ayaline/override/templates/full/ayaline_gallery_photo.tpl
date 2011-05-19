{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent_node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}

{def $limit = 9}
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

{def $parent = fetch('content','node', hash('node_id', $node.parent_node_id))}

<div class="bloc-type padding-tl">

	<h2 class="bloc-liste-h2">{$parent.name|wash}</h2>
	<p class="clear"></p>
	
	<p class="chapeau">
		{attribute_view_gui attribute=$parent.data_map.description}			
	</p>
	
	{* Formulaire de recherche *}
	<div class="bloc-search">
		{include uri='design:gallery/search_form.tpl' rubriques=$rubriques}
	</div>
	
	<div class="menu-h">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
	</div>
	
	<div class="bloc-container">

		{if $galleries_count|gt(0)}
			<ul>
				{foreach $galleries as $gallery}
					<li>
						
						{* get photo of the gallery, or take the first one in the gallery *}
						{if $gallery.data_map.image.content.is_valid}
							<div class="cadre-t">
								<div class="cadre-b">
									<div class="cadre-l">
										<div class="cadre-r">
											<div class="cadre-tl">
												<div class="cadre-tr">
													<div class="cadre-bl">
														<div class="cadre-br">
															<a href={$gallery.url_alias|ezurl}>{attribute_view_gui attribute=$gallery.data_map.image}</a>
														</div>
													</div>
												</div>
											</div>									
										</div>
									</div>
								</div>
							</div>
						{else}
							
							{set $picture = fetch( 'content','list',hash( 'parent_node_id', $gallery.node_id, 
														'sort_by', $node.sort_array,
														'class_filter_type',  'include',
		              									'class_filter_array', array('gallery_photo'),
		              									'limit',1 ))}
		              									
		              		{if $picture|count|eq(1)}
		              			<div class="cadre-t">
									<div class="cadre-b">
										<div class="cadre-l">
											<div class="cadre-r">
												<div class="cadre-tl">
													<div class="cadre-tr">
														<div class="cadre-bl">
															<div class="cadre-br">
																<a href={$gallery.url_alias|ezurl}>{attribute_view_gui attribute=$picture[0].data_map.image image_class='small'}</a>
															</div>
														</div>
													</div>
												</div>									
											</div>
										</div>
									</div>
								</div>
		              		{/if}
		              		
						{/if}
						
						<p><a href={$gallery.url_alias|ezurl}>{$gallery.name|wash}</a></p>

					</li>
				{/foreach}
			</ul>
			<p class="clear"></p>
		{else}
			<div class="message">Aucune photo n'est disponible pour le moment.</div>
		{/if}
		
		{include name=navigator
        	uri='design:navigator/google.tpl'
        	page_uri=$node.url_alias
        	item_count=$photos_count
         	view_parameters=$view_parameters
         	item_limit=$limit}
        
	</div>
	
</div>
