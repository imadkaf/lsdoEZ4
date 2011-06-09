{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent_node_id, 
													'sort_by', $node.sort_array,
													'class_filter_type',  'include',
              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}

{def $limit = 4}
{def $offset = 0}
{if $view_parameters.offset|gt(0)}
	{set $offset = $view_parameters.offset}
{/if}

{def $videos = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
											'sort_by', $node.sort_array,
											'class_filter_type',  'include',
              								'class_filter_array', array('gallery_video'),
              								'limit',$limit,
              								'offset',$offset ))}
              								
{def $videos_count = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id, 
											'sort_by', $node.sort_array,
											'class_filter_type',  'include',
              								'class_filter_array', array('gallery_video') ))}

{def $compteur = 1}

<div class="bloc-type padding-tl">

	<h2 class="bloc-liste-h2">{$node.parent.name|wash}</h2>
	<p class="clear"></p>
	
	<p class="chapeau gallery">
		{attribute_view_gui attribute=$node.parent.data_map.description}			
	</p>
	
	<div class="menu-h">
		{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
	</div>
		
	<div class="bloc-container">
	
		{if $videos|count|gt(0)}
			<ul class="list-video">
			{foreach $videos as $video}
				<li {if eq($compteur, 1)}class="first"{/if}>
					<p class="box-img">
						<a class="link-popin" target="_blank" href={concat('layout/set/vide/', $video.url_alias)|ezurl}>{attribute_view_gui attribute=$video.data_map.thumbnail image_class=medium}</a>
					</p>
					<h3 class="titre"><a class="link-popin" target="_blank" href={concat('layout/set/vide/', $video.url_alias)|ezurl}>{$video.name|wash}</a></h3>
					<p class="text">
						{attribute_view_gui attribute=$video.data_map.description}
					</p>
				</li>
				{set $compteur = $compteur|inc}
			{/foreach}
			</ul>
		{else}
			<div class="message">Aucune video n'est disponible pour le moment.</div>
		{/if}
        	
	</div>
	
	<div class="taille-pagination">
		{include name=navigator
	        uri='design:navigator/google.tpl'
	        page_uri=$node.url_alias
	        item_count=$videos_count
	        view_parameters=$view_parameters
	        item_limit=$limit}
	</div>
		
</div>
