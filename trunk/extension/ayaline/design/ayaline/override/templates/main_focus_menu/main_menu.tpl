{if $node.data_map.image.has_content}
{attribute_view_gui attribute = $node.data_map.image image_class='main_focus_menu_left'}
{else}
<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_moyenne.jpg'|ezimage} width="90" alt="{$sMenu.name|wash}" title="{$sMenu.name|wash}" /></a>
{/if}
<ul class="list-in">
{foreach $node.children as $sMenu}
	<li><a href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}>{$sMenu.name|wash}</a></li>
{/foreach}
	<li><a href={'2012_HorairesMarees-web.pdf'|ezimage} target="_blank">Horaires des marées</a></li>
</ul>
<div class="clear"></div>
