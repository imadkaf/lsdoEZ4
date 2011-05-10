{def $children = fetch('content','list', hash(
											'parent_node_id', $node.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}
											
{def $parent = fetch('content','node', hash('node_id', $node.parent_node_id))}

{def $childParent = fetch('content','list', hash(
											'parent_node_id', $parent.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}

{*$node|attribute(show)*}

<div class="bloc-type">
	<h2>
		{attribute_view_gui attribute = $parent.data_map.title}
		{*
		<span class="none">Découvrir</span>
		<a href="#"><img src={"decouvrir-titre.png"|ezimage} alt="" /></a>
		*}
	</h2>
	<p class="clear"></p>
	<ul class="menu-left">
	{foreach $childParent as $childP}
		{if eq($childP.node_id,$node.node_id)}
		<li class="actif">
		{else}
		<li>
		{/if}
			<a href={$childP.url_alias|ezurl}><span>{attribute_view_gui attribute = $childP.data_map.title}</span></a>
			<ul class="s-menu">
			{foreach $children as $child}
				<li><a href={$child.url_alias|ezurl}>{attribute_view_gui attribute = $child.data_map.title}</a></li>
			{/foreach}
			</ul>
		</li>
	{/foreach}
	</ul>
</div>
