{def $children = fetch('content','list', hash(
											'parent_node_id', $node.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}

{*
Test : 
{$node.data_map|attribute(show)}
*}

<div class="bloc-left-bis">
	<div class="bloc-type padding-35px-32px">
		<h2>
{attribute_view_gui attribute = $node.data_map.title}
			{*
			<img alt="" src="images/decouvrir2.png">
			<span class="none">Découvrir</span>
			*}
		</h2>
		<p class="clear"></p>
		<p class="chapeau">
{attribute_view_gui attribute = $node.data_map.short_description}
		</p>
		
		<ul class="container-list-3col">
{foreach $children as $enfants}
	{node_view_gui content_node=$enfants view='line'}
{/foreach}
		</ul>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/les_plus_consultes.tpl'}
	{include uri='design:parts/agenda.tpl'}
</div>
{*<div class="clear"></div>*}