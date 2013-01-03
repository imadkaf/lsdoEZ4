{if $node.data_map.image.has_content}
{attribute_view_gui attribute = $node.data_map.image image_class='main_focus_menu_left'}
{else}
<a href={$node.url_alias|ezurl}><img src={'sit/image_fiche_defaut_moyenne.jpg'|ezimage} width="90" alt="{$sMenu.name|wash}" title="{$sMenu.name|wash}" /></a>
{/if}
<ul class="list-in">
{foreach $node.children as $sMenu}
	<li><a href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}>{$sMenu.name|wash}</a></li>
{/foreach}
	<li><a href="http://www.lessablesdolonne-tourisme.com/extension/ayaline/design/ayaline/images/2013_HorairesMarees-web.pdf?utm_source=site-internet&utm_medium=lien-interne&utm_campaign=horaires-marees" target="_blank">{"Tide Tables"|i18n("ayaline")}</a></li>{* attention lien avec tracking GA *}
</ul>
<div class="clear"></div>
