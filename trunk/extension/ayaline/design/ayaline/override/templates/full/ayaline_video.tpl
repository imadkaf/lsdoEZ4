{* Vue full de base
{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent.parent_node_id, 
												'sort_by', $node.sort_array,
												'class_filter_type',  'include',
              									'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}
<div class="bloc-type padding-tl">
	<h2 class="bloc-liste-h2">{$node.parent.parent.name|wash}</h2>
	<p class="clear"></p>
	<p class="chapeau gallery">
		{attribute_view_gui attribute=$node.parent.parent.data_map.description}			
	</p>
	<div class="menu-h">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
	</div>
    <div class="bloc-container">
    	<div class="container-diapo">
	    	<h3>{$node.name|wash}</h3>
			<p>
				{attribute_view_gui attribute=$node.data_map.description}
			</p>
	    	<div class="video">
				{$node.data_map.video_tag.content}
			</div>
		</div>
	</div>
</div>
*}

<div class="popin-container">
	<div class="popin-top">
		<p><a href="#" class="popin-close" title="Fermer la popin"><span>Fermer</span></a><p>
	</div>
	<hr />
	<div class="popin-content">
		<div class="popin-content-bloc">
			<div class="container-diapo">
				<div class="video">
					{$node.data_map.video_tag.content}
				</div>
			</div>
		</div>
	</div>
</div>
