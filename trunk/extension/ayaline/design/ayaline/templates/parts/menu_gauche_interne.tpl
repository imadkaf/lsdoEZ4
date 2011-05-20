{def $childParent = fetch('content','list', hash(
											'parent_node_id', $node.parent.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}

{def $children1 = ''}

<div class="bloc-type">
	<h2 class="menu-gauche-h2">
		{attribute_view_gui attribute = $node.parent.data_map.title}
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
			<span>{$childP.name}</span>
			{if $childParent|count}
				<ul class="s-menu">
				{foreach $children1 as $child}
					<li><a href={$child.url_alias|ezurl}>{$child.name}</a></li>
				{/foreach}
				</ul>
			{/if}
		</li>
	{/foreach}
	</ul>
</div>
