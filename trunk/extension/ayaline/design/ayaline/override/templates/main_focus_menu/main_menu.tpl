{if $node.data_map.image.has_content}
{attribute_view_gui attribute = $node.data_map.image image_class='main_focus_menu_left'}
{/if}
<ul class="list-in">
{foreach $node.children as $sMenu}
	<li><a href={$node.url_alias|ezurl}>{$sMenu.name|wash}</a></li>
{/foreach}
</ul>
<div class="clear"></div>