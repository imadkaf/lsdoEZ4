{def $listeImages = false()}
{set $listeImages=fetch('content','list',hash('parent_node_id',$node.node_id,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_image')
 ))}

<div class="diapo">
			<ul class="diaporama1">
			{foreach $listeImages as $image}
				<li>{attribute_view_gui attribute=$image.data_map.fichier_image image_class='original'}</li>
			{/foreach}
			</ul>
</div>
{undef $listeImages}