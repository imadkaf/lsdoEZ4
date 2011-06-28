{* Brochures full view *}

{* Variables *}
{def $nb_max = ezini('BrochureList','maxBrochureList','brochure.ini')}

{def $brochures = fetch( 'content','list',hash(	'parent_node_id', $node.node_id,
										'offset', $view_parameters.offset,
										'limit', $nb_max,
										'sort_by', $node.sort_array,
										'class_filter_type' , 'include',
										'class_filter_array', array('brochure')))}

{def $nb_brochures = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id, 'class_filter_type' , 'include', 'class_filter_array', array('brochure')))}

<div name="brochure">

	<h1 class="brochure_list_title">{$node.name|wash}</h1>
	
	{if gt($nb_brochures,0)}
		<ul class="brochure_list_full">
		{foreach $brochures as $brochure}
			<li>{node_view_gui content_node=$brochure view='line'}</li>
		{/foreach}
		</ul>		
	{else}
		<p class="brochure_no_elements">Aucune brochure n’est disponible pour le moment.</p>
	{/if}	

	{**** Affichage de la pagination ****}
	{include 
		name=navigator 
		uri='design:navigator/google.tpl' 
		page_uri=$node.url_alias
		item_count=$nb_brochures
		view_parameters=$view_parameters
		item_limit=$nb_max
	}
	
</div>
