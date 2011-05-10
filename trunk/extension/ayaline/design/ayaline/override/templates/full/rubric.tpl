{def $children = fetch('content','list', hash(
											'parent_node_id', $node.node_id,
											'sort_by', $node.data_map.header_menu.content.main_node.sort_array
											))}
											
{def $parent = fetch('content','node', hash('node_id', $node.parent_node_id))}

<div class="bloc-left-bis">
	{if eq($node.class_identifier, $parent.object.class_identifier)} {*ne(children_count, 0)*}
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">
		
	{else}
	<div class="bloc-type padding-35px-32px">
	{/if}
	
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
		{if eq($node.class_identifier, $parent.class_identifier)}
			<div class="pagination no-margin">
				<ul class="pagin">
					<li class="actif"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
				</ul>
				<p class="float-g"><a href="#">Page suivante &gt;</a></p>
			</div>
		</div>
		{/if}
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/les_plus_consultes.tpl'}
	{if ne($node.class_identifier, $parent.class_identifier)}
		{include uri='design:parts/agenda.tpl'}
	{/if}
</div>