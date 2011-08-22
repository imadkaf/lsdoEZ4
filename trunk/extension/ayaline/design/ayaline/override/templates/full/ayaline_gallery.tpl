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
	{def $rubriques = fetch( 'content','list',hash( 'parent_node_id', $node.node_id, 
														'sort_by', $node.sort_array,
														'class_filter_type',  'include',
	              										'class_filter_array', array('gallery_category_video', 'gallery_category_photo') ))}
	
	<div class="bloc-type padding-tl">
	
		<h2 class="bloc-liste-h2">{$node.name|wash}</h2>
		<p class="clear"></p>
		
		<div class="chapeauMedia gallery">
			{attribute_view_gui attribute=$node.data_map.description}			
		</div>
		
		{* Formulaire de recherche 
		<div class="bloc-search">
			{include uri='design:gallery/search_form.tpl' rubriques=$rubriques}
		</div>*}
		
		{*<div class="menu-h">
			{include uri='design:gallery/tabs.tpl' rubriques=$rubriques}
		</div>*}
		
		<div class="bloc-container">
			<p class="clear"></p>
		</div>
		
	</div>
{/if}
