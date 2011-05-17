{*$node|attribute(show)*}

{def $blocsContenus = $node.data_map.blocks.content.relation_list}
{def $blocsCont = ''}
{def $compteur = 0}

{foreach $blocsContenus as $blocs}
	{set $blocsCont = fetch('content', 'node', hash('node_id', $blocs.node_id))}
	
	{if eq($compteur, 0)}
		<div class="bloc-left">
	{/if}
	
	{if le($compteur, 3)}
		{if or(eq($compteur,0), eq($compteur,2))}
			<div class="bloc-type" style="width:358px; float:left; margin-right:20px;">
		{else}
			<div class="bloc-type" style="width:358px; float:left;">
		{/if}
				{node_view_gui content_node=$blocsCont view='blocsAccueil'}
			</div>
	{/if}
	
	{if ge($compteur, 4)}
		<div class="bloc-type-bis">
			{node_view_gui content_node=$blocsCont view='blocsAccueil'}
		</div>
	{/if}

	{set $compteur = $compteur|inc}
	
	{if eq($compteur, 4)}
		</div>
		<div class="bloc-right">
			{include uri='design:parts/reserver.tpl'}
	{/if}
{/foreach}
		</div>