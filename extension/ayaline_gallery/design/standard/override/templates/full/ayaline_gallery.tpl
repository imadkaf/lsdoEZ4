{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}
              										
<div class="ayaline-gallery">
	<h1>{$node.name|wash}</h1>
	
	
	{* Formulaire de recherche *}
	{*include uri='design:gallery/search_form.tpl' rubriques=$rubriques*}
	
	<div class="description">{attribute_view_gui attribute=$node.data_map.description}</div>
	
	<div class="gallery-content">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		<div class="gallery-tab-content">{node_view_gui content_node=$rubriques[0] view=gallery_tab}</div>
	</div>
</div>
