{if is_set($nomSousMenu)}{node_view_gui content_node=$node.data_map.content.content.main_node view='menu' nomSousMenu = $nomSousMenu}{else}{node_view_gui content_node=$node.data_map.content.content.main_node view='menu'}{/if}