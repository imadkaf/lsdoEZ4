{def $parent1 = fetch('content','node', hash('node_id', $node.parent_node_id))}

{def $menuPiedPage = fetch('content','tree', hash(
											'parent_node_id',  ezini('NodeSettings','RootNode','content.ini'),
											'class_filter_type' , 'include', 
											'class_filter_array' , array('footer_menu')))}

{set $menuPiedPage=$menuPiedPage.0}

{def $liensHorizontaux = $menuPiedPage.data_map.menu_h.content.relation_list}

{def $liensHoriz = ''}

<div class="bloc-type">
	<h2 class="menu-gauche-h2">
		{attribute_view_gui attribute = $parent1.data_map.title}
	</h2>
	
	<p class="clear"></p>
	<ul class="menu-left">
	{foreach $liensHorizontaux as $keyVar =>$itemVar}
		{set $liensHoriz = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
		{if eq($liensHoriz.name, $node.name)}
		<li class="actif">
		{else}
		<li>
		{/if}
			<span>{node_view_gui content_node=$liensHoriz view='menu'}</span>
		</li>
	{/foreach}
	</ul>
</div>
