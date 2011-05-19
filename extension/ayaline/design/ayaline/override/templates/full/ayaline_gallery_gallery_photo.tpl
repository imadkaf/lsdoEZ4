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

<div class="bloc-type padding-tl">
	
	<h2 class="bloc-liste-h2">{$node.parent.parent.name|wash}</h2>
	<p class="clear"></p>

	<p class="chapeau gallery">
		{attribute_view_gui attribute=$node.parent.parent.data_map.description}			
	</p>
	
	{* Formulaire de recherche *}
	<div class="bloc-search">
		{include uri='design:gallery/search_form.tpl' rubriques=$rubriques}
	</div>
	
	<div class="menu-h">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
	</div>
	
	<div class="bloc-container">
	
		<div class="container-diapo">
		
			<h3>{$node.name|wash}</h3>
			
			<p>
				{attribute_view_gui attribute=$node.data_map.description}
			</p>
				
		    {* Gallery or Flickr ? *} 										  										
			{if $photos|count|gt(0)}
				<div class="slider">
					
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
