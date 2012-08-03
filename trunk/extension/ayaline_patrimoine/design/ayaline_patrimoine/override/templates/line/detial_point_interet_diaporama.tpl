{def $listeImages = false()}
{set $listeImages=fetch('content','list',hash('parent_node_id',$node.node_id,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_image')
 ))}

<div class="diapo">
<div id="gallery">
			<ul id="Gallery" style="position: relative">
			{foreach $listeImages as $key=>$image}
				 {if eq($key,0)}
				 	<li><a href="/{$image.data_map.fichier_image.content.original.full_path}" rel="external" >
                            <span class="cliquer play-diaporama"></span>
                            {attribute_view_gui attribute=$image.data_map.fichier_image image_class='imageDiapoPrincipal'}
                        </a>
                    </li>
				 {else}
				<li class="display-none"><a href="/{$image.data_map.fichier_image.content.original.full_path}" rel="external">
				{attribute_view_gui attribute=$image.data_map.fichier_image image_class='original'}</a>
				</li>
				{/if}
			{/foreach}
			</ul>
</div>
</div>
<div class="titre-video">{$node.name|wash('xhtml')}</div>
{undef $listeImages}