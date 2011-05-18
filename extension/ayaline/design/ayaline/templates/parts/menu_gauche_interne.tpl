{def $parent1 = fetch('content','node', hash('node_id', $node.parent_node_id))}

{def $childParent = fetch('content','list', hash(
											'parent_node_id', $parent1.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}
											
{def $children1 = ''}

<div class="bloc-type">
	<h2 class="menu-gauche-h2">
		{attribute_view_gui attribute = $parent1.data_map.title}
	</h2>
	
	<p class="clear"></p>
	<ul class="menu-left">
	{foreach $childParent as $childP}

		{set $children1 = fetch('content','list', hash(
											'parent_node_id', $childP.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}

		{if eq($childP.node_id,$node.node_id)}
		<li class="actif">
		{else}
		<li>
		{/if}
			<span>{attribute_view_gui attribute = $childP.data_map.title}</span>
			<ul class="s-menu">
			{foreach $children1 as $child}
				<li><a href={$child.url_alias|ezurl}>{attribute_view_gui attribute = $child.data_map.title}</a></li>
			{/foreach}
			</ul>
		</li>
	{/foreach}
	</ul>
</div>
