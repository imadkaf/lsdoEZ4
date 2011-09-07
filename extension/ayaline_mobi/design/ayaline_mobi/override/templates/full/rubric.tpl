{if $node.data_map.description.has_content}
	<div class="titre-basique">
		<h2>{$node.name}</h2>
	</div>
	
	<div class="detail-rubrique">
		{attribute_view_gui attribute=$node.data_map.description}
	</div>
{else}
	{def $enfants = fetch('content','list', hash( 'parent_node_id', $node.node_id,
													'sort_by', $node.sort_array,
													'class_filter_type' , 'include',
													'class_filter_array', array('rubric', 'sit_liste')))}
	
	<div class="titre-basique">
		<h2>{$node.name}</h2>
	</div>
	<div class="icons">
		{* Pour chacun de ses fils (rubrique ou liste SIT) *}
		{foreach $enfants as $enfant}
			<div class="icon">
				{node_view_gui content_node=$enfant view='line'}
			</div>
		{/foreach}
		<div class="clear"></div>
	</div>
{/if}
