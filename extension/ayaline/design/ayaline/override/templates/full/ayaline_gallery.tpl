{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}

<div class="bloc-type padding-tl">

	<h2 class="bloc-liste-h2">{$node.name|wash}</h2>
	<p class="clear"></p>
	
	<p class="chapeau">
		{attribute_view_gui attribute=$node.data_map.description}			
	</p>
	
	{* Formulaire de recherche *}
	<div class="bloc-search">
		{include uri='design:gallery/search_form.tpl' rubriques=$rubriques}
	</div>
	
	<div class="menu-h">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		{*<div class="gallery-tab-content">{node_view_gui content_node=$rubriques[0] view=gallery_tab}</div>*}
	</div>
	
	<div class="bloc-container">
		
		<p class="clear"></p>
	</div>
	
</div>
