{def $search_text = ''}

{if ezhttp_hasvariable('SearchText')}
	{set $search_text = ezhttp('SearchText')}
{/if}
{if ezhttp_hasvariable('SearchText','get')}
	{set $search_text = ezhttp('SearchText', 'get')}
{/if}

{if ne($search_text, '')}
	{include uri='design:content/search_photo.tpl' noeud=$node search_text=$search_text}
{else}
	{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.parent_node_id, 
														'sort_by', $node.sort_array,
														'class_filter_type',  'include',
	              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}
	
	{def $limit = 9}
	{def $offset = 0}
	{def $picture = ''}
	{if $view_parameters.offset|gt(0)}
		{set $offset = $view_parameters.offset}
	{/if}
	{def $galleries = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
														'sort_by', $node.sort_array,
														'class_filter_type',  'include',
	              										'class_filter_array', array('gallery_gallery_photo'),
	              										'limit',$limit,
	              										'offset',$offset ))}
	
	{def $galleries_count = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id, 
														'sort_by', $node.sort_array,
														'class_filter_type',  'include',
	              										'class_filter_array', array('gallery_gallery_photo') ))}
	
	{def $compteurPhoto = 1}
	
	<div class="bloc-type padding-tl">
	
		<h2 class="bloc-liste-h2">{$node.parent.name|wash}</h2>
		<p class="clear"></p>
		
		<div class="chapeauMedia gallery">
			{attribute_view_gui attribute=$node.data_map.description}			
		</div>
		
		{* Formulaire de recherche *}
		<div class="bloc-search">
			{include uri='design:gallery/search_form.tpl' rubriques=$rubriques}
		</div>
		
		<div class="menu-h">
			{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		</div>
		
		<div class="bloc-container">
	
			{def $compteurlistegalerie = 1}
			{if $galleries_count|gt(0)}
				<ul class="ulhauteurjs">
					{foreach $galleries as $gallery}
						<li {if eq(mod($compteurlistegalerie, 3), 1)}class="premierli"{/if}>
							
							{* get photo of the gallery, or take the first one in the gallery *}
							{if $gallery.data_map.image.content.is_valid}
								<div class="cadre-t">
									<div class="cadre-b">
										<div class="cadre-l">
											<div class="cadre-r">
												<div class="cadre-tl">
													<div class="cadre-tr">
														<div class="cadre-bl">
															<div class="cadre-br">
																<a href={$gallery.url_alias|ezurl}>{attribute_view_gui attribute=$gallery.data_map.image}</a>
															</div>
														</div>
													</div>
												</div>									
											</div>
										</div>
									</div>
								</div>
							{else}
								
								{set $picture = fetch( 'content','list',hash( 'parent_node_id', $gallery.node_id, 
															'sort_by', $node.sort_array,
															'class_filter_type',  'include',
			              									'class_filter_array', array('gallery_photo'),
			              									'limit',1 ))}
			              									
			              		{if $picture|count|eq(1)}
			              			<div class="cadre-t">
										<div class="cadre-b">
											<div class="cadre-l">
												<div class="cadre-r">
													<div class="cadre-tl">
														<div class="cadre-tr">
															<div class="cadre-bl">
																<div class="cadre-br">
																	<a href={$gallery.url_alias|ezurl}>{attribute_view_gui attribute=$picture[0].data_map.image image_class='small'}</a>
																</div>
															</div>
														</div>
													</div>									
												</div>
											</div>
										</div>
									</div>
			              		{/if}
			              		
							{/if}
							
							<p><a href={$gallery.url_alias|ezurl}>{$gallery.name|wash}</a></p>
	
						</li>
						
						{if eq($compteurPhoto|mod(3), 0)}
							<p class="clear"></p>
						{/if}
						
						{set $compteurPhoto = $compteurPhoto|inc}
						
						{if and($galleries|count|gt($compteurlistegalerie), eq(mod($compteurlistegalerie, 3), 0))}
							</ul>
							<ul class="ulhauteurjs">
						{/if}
						{set $compteurlistegalerie = $compteurlistegalerie|inc}
					{/foreach}
				</ul>
				<p class="clear"></p>
			{else}
				<div class="message">Aucune photo n'est disponible pour le moment.</div>
			{/if}
	        
		</div>
		<script type="text/javascript">
			equilibre = true;
			$(window).load(equilibrerHauteursBlocs);
		</script>
		
		<div class="taille-pagination">
			{include name=navigator
		        uri='design:navigator/google.tpl'
		        page_uri=$node.url_alias
		        item_count=$galleries_count
		         view_parameters=$view_parameters
		         item_limit=$limit}
	     </div>
		
	</div>
{/if}