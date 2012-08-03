<div id="diaporama-view">
	<div class="media">
		<div class="diaporama">
		<div class="titre-video">{attribute_view_gui attribute=$node.data_map.titre_diaporama}</div>
	    	<div id="gallery">

		{def $listeImages=fetch('content','list',hash('parent_node_id',$node.node_id,
	                                    'class_filter_type','include',
	                                    'class_filter_array',array('smp_image')
		))}
		{def $lienPrincipal = ""}
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
					{attribute_view_gui attribute=$image.data_map.fichier_image image_class='imageDiapoMedia'}</a>
					</li>
			{/if}
		{/foreach}
	        	</ul>
	     	</div>
		</div>
	 </div>
</div>