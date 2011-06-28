{* Faqs full view *}

<div name="faq">

	<a name="top_page"></a>
	<h1 class="faq_list_title">{$node.name|wash}</h1>
	
	{def $faqs = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
											   'sort_by', $node.sort_array,
											   'class_filter_type' , 'include',
											   'class_filter_array', array('faq')))}
	{*$node|attribute(show,3)*}
	
	{def $typeOfView = $node.object.data_map.type_of_view}
	{def $view = $typeOfView.content[0]}
	{*def $view = $typeOfView.class_content.options[$typeOfView.content[0]].name*}
	
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
			
			<hr/>
			
			<ul class="faq_list_full">
			{foreach $faqs as $faq}
				<li><a name="{$faq.object.id}"></a>{node_view_gui content_node=$faq view='line'}</li>
			{/foreach}
			</ul>		
			<a class="anchor_ref_top" href="#top_page">Retour en haut de page</a>
			
		{* Si l'affichage se fait via les réponses cachées *}
		{elseif eq($view,1)}
			<ul class="faq_list_grouped">
			{foreach $faqs as $faq}
				<li>{node_view_gui content_node=$faq view='grouped'}</li>
			{/foreach}
			</ul>
		{/if}
	{else}
		<p>Aucune questions n’est disponible pour le moment.</p>
	{/if}
</div>