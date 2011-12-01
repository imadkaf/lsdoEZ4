{def $nbPubs = 5}

{def $nb_max = ezini('BrochureList','maxBrochureList','brochure.ini')}

{def $brochures = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
												'offset', $view_parameters.offset,
												'limit', $nb_max,
											   	'sort_by', $node.sort_array,
											   	'class_filter_type',  'include',
	              								'class_filter_array', array('brochure')))}

{def $nb_brochures = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id,
															'class_filter_type',  'include',
	              											'class_filter_array', array('brochure')))}											   

<div class="bloc-left-bis">

	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">
		
			<h2 class="bloc-liste-h2">{$node.name|wash}</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
			{if is_set($node.data_map.description)}
				{attribute_view_gui attribute = $node.data_map.description}
			{/if}
			</p>
			
			{if gt($nb_brochures,0)}
				<ul class="brochure_list_full">
				{foreach $brochures as $brochure}
					<li>{node_view_gui content_node=$brochure view='line'}</li>
				{/foreach}
				</ul>
			{else}
				<p class="brochure_no_elements">{"No booklet is available"|i18n("ayaline")}Aucune brochure n’est disponible pour le moment.</p>
			{/if}	
		
			{* Affichage de la pagination *}
			{include 
				name=navigator 
				uri='design:navigator/google.tpl' 
				page_uri=$node.url_alias
				item_count=$nb_brochures
				view_parameters=$view_parameters
				item_limit=$nb_max
			}
			
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>