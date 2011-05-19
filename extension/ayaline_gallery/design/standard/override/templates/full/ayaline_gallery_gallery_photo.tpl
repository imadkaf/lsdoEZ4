{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent.parent_node_id, 
												'sort_by', $node.sort_array,
												'class_filter_type',  'include',
              									'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}

{if $view_parameters.offset|gt(0)}
	{set $offset = $view_parameters.offset}
{/if}
{def $photos = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
											'sort_by', $node.sort_array,
											'class_filter_type',  'include',
              								'class_filter_array', array('gallery_photo') ))}
              								
<div class="ayaline-gallery">
	<h1>{$node.name|wash}</h1>	

	<div class="gallery-content">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		<div class="gallery-tab-content">
		
		{* Description *}
			<div class="description">
				{attribute_view_gui attribute=$node.data_map.description} 
			</div>
				
		    {* Gallery or Flickr ? *} 										  										
			{if $photos|count|gt(0)}
				<div id="galleria">
					{foreach $photos as $photo}
						{attribute_view_gui attribute=$photo.data_map.image link_to_image=true() title=$photo.name|wash}
					{/foreach}
					
					<script type="text/javascript">
						// Load the classic theme
			   			Galleria.loadTheme({'javascript/galleria/themes/classic/galleria.classic.min.js'|ezdesign});
			    
						// Initialize Galleria
						$('#galleria').galleria();
					</script>
				</div>
				<div class="clear"></div>
			{elseif $node.data_map.flickr_tag.content|ne('')}
				<div class="flickr">{$node.data_map.flickr_tag.content}</div>
			{else}
				<div class="message">Aucune photo n'est disponible pour le moment.</div>
			{/if}
		</div>
	</div>
</div>