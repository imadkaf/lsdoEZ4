{def $nb_max = 4 }

{def $parent = fetch('content','node', hash('node_id', $node.parent_node_id))}

{if eq($node.class_identifier, $parent.object.class_identifier)}
	{def $children = fetch('content','list', hash(
												'parent_node_id', $node.node_id,
												'offset', $view_parameters.offset,
												'limit', $nb_max,
												'sort_by', $node.data_map.header_menu.content.main_node.sort_array
												))}
												
	{def $nb_elements = fetch('content','list_count', hash(
														'parent_node_id', $node.node_id,
														'sort_by', $node.data_map.header_menu.content.main_node.sort_array
														))}
{else}
	{def $children = fetch('content','list', hash(
												'parent_node_id', $node.node_id,
												'sort_by', $node.data_map.header_menu.content.main_node.sort_array
												))}
{/if}

{def $compteur = 1}

<div class="bloc-left-bis">
	{if eq($node.class_identifier, $parent.object.class_identifier)}
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">
		
	{else}
	<div class="bloc-type padding-35px-32px">
	{/if}
	
		<h2 class="bloc-liste-h2">
			{attribute_view_gui attribute = $node.data_map.title}
		</h2>
		<p class="clear"></p>
		
		<p class="chapeau">
			{attribute_view_gui attribute = $node.data_map.short_description}
		</p>
		
		{if eq($node.class_identifier, $parent.object.class_identifier)}
		<ul class="list">
		{else}
		<ul class="list liste-parente">
		{/if}
			{foreach $children as $enfants}
				{if and(ne($compteur|mod(2), 0), eq($node.class_identifier, $parent.object.class_identifier))}
			<li class="first">
				{else}
					{if eq($compteur|mod(3), 0)}
			<li class="last">
					{else}
			<li class="autre">
					{/if}
				{/if}
				{node_view_gui content_node=$enfants view='line'}
			</li>
				{if and(eq($compteur|mod(3), 0), ne($node.class_identifier, $parent.object.class_identifier))}
			<p class="clear"></p>
				{/if}
				{set $compteur = $compteur|inc}
			{/foreach}
		</ul>
		
		{if eq($node.class_identifier, $parent.class_identifier)}
			{* Affichage de la pagination *}
			{include 
				name=navigator 
				uri='design:navigator/google.tpl' 
				page_uri=$node.url_alias
				item_count=$nb_elements
				view_parameters=$view_parameters 
				item_limit=$nb_max
			}
		</div>
		{/if}
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/les_plus_consultes.tpl'}
	{if ne($node.class_identifier, $parent.class_identifier)}
		{include uri='design:parts/agenda.tpl'}
	{/if}
</div>