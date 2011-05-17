<div class="ayaline-gallery">
	<h1>{$node.name|wash}</h1>
    <div class="gallery-content">
    	<div class="description">{attribute_view_gui attribute=$node.data_map.description}</div>
    	<div class="video">
			{$node.data_map.video_tag.content}
		</div>
	</div>        
</div>