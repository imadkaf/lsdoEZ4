{* Faqs full view *}

{def $nbPubs = 5}

<div class="bloc-left-bis">

	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">
			
			<a name="top_page"></a>
			
			<h2 class="bloc-liste-h2">{$node.name|wash}</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
			{if is_set($node.data_map.description)}
				{attribute_view_gui attribute = $node.data_map.description}
			{/if}
			</p>
		
			{def $faqs = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
													   'sort_by', $node.sort_array,
													   'class_filter_type' , 'include',
													   'class_filter_array', array('faq')))}
			
			{def $typeOfView = $node.object.data_map.type_of_view}
			{def $view = $typeOfView.content[0]}
			
			{if gt($faqs|count(),0)}
				{* Si l'affichage se fait via les ancres *}
				{if eq($view, 0)}
					<ul class="faq_list_link">
					{foreach $faqs as $faq}
						<li>
							<a href="#{$faq.object.id}">{$faq.name|wash}</a>
						</li>
					{/foreach}
					</ul>
					<hr/><br />
					
					<ul class="faq_list_full">
					{foreach $faqs as $faq}
						<li><a name="{$faq.object.id}"></a>{node_view_gui content_node=$faq view='line'}<br /></li>
					{/foreach}
					</ul>		
					<a class="anchor_ref_top" href="#top_page">Retour en haut de page</a><br /><br />
					
				{* Si l'affichage se fait via les réponses cachées *}
				{elseif eq($view,1)}
					<ul class="faq_list_grouped">
					{foreach $faqs as $faq}
						<li>{node_view_gui content_node=$faq view='grouped'}<br /></li>
					{/foreach}
					</ul>
				{/if}
			{else}
				<p>Aucune questions n’est disponible pour le moment.</p>
			{/if}
	
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
</div>