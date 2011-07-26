{if is_set($nomHoriz)}
	{node_view_gui content_node=$node.data_map.content.content.main_node view='menu' nomHorizSubMenu = $nomHoriz}
{else}
	{node_view_gui content_node=$node.data_map.content.content.main_node view='menu'}
{/if}
