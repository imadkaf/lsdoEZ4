<div class="ayaline-gallery-embed">
{if $object.main_node_id|null|not}
	{def $photos = fetch( 'content','list',hash( 'parent_node_id', $object.main_node.node_id, 
												'sort_by', $object.main_node.sort_array,
												'class_filter_type',  'include',
	              								'class_filter_array', array('gallery_photo') ))}

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
	{elseif $object.data_map.flickr_tag.content|ne('')}
		<div class="flickr">{$object.data_map.flickr_tag.content}</div>
	{else}
		<div class="message">Aucune photo n'est disponible pour le moment.</div>
	{/if}
{else}
    {$object.name|wash}
{/if}
</div>