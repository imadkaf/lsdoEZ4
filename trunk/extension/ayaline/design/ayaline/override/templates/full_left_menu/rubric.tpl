{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonId = ezhttp('saison', 'session')}
{else}
	{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
{/if}
{if ezhttp('topics', 'session', 'hasVariable')}
	{def $topicIds = ezhttp('topics', 'session')}
{else}
	{def $topicIds = array()}
{/if}
{def $rNode = fetch('content','node', hash('node_id',  ezini('NodeSettings','RootNode','content.ini')))}
{def $nb_max = 4 }
{def $childrenShowed = $node.children|extract($view_parameters.offset,$nb_max)}
{def $mainMenuShowed = false()}
			<div class="bloc-left-bis">
				<div class="bloc-left-in-bis">
					<div class="bloc-type">
						<h2 class="menu-gauche-h2">
							{attribute_view_gui attribute = $node.parent.data_map.title}
						</h2>
						<p class="clear"></p>
{if $rNode.data_map.main_menu.has_content}
						<ul class="menu-left">
{foreach $rNode.data_map.main_menu.content.main_node.children as $sMenu}
	{if eq($sMenu.data_map.content.content.main_node.node_id,$node.parent_node_id)}
		{foreach $sMenu.children as $nodeSeason}
			{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
				{if $nodeSeason.data_map.title.value.0|eq($saisonId)}
					{foreach $nodeSeason.children as $nodeRubric}
						{if $nodeRubric.class_identifier|eq(ezini('ClassSettings','ClassSubMenuIdentifier','content.ini'))}
							{if $topicIds|count}
								{if $nodeRubric.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
									{if $nodeRubric.data_map.content.content.main_node.data_map.topics.content.relation_list|count}
										{foreach $nodeRubric.data_map.content.content.main_node.data_map.topics.content.relation_list as $relation}
											{foreach $topicIds as $topicId}
												{if $relation.node_id|eq($topicId)}
													{set $mainMenuShowed = true()}
													{break}
												{/if}
											{/foreach}
										{/foreach}
									{else}
										{set $mainMenuShowed = true()}
									{/if}
								{else}
									{set $mainMenuShowed = true()}
								{/if}
							{else}
								{set $mainMenuShowed = true()}
							{/if}
							{if $mainMenuShowed}
							<li{if eq($nodeRubric.data_map.content.content.main_node.node_id,$node.node_id)} class="actif"{/if}>{node_view_gui content_node=$nodeRubric.data_map.content.content.main_node view=left_menu}</li>
								{set $mainMenuShowed = false()}
							{/if}
						{/if}
					{/foreach}
					{break}	
				{/if}
			{/if}
		{/foreach}
	{/if}
{/foreach}
						</ul>
{/if}
					</div>
				</div>
					<div class="bloc-right-in-bis">
						<div class="bloc-type">
							<h2>
								{attribute_view_gui attribute = $node.data_map.title}
							</h2>
							<p class="clear"></p>
							<p class="chapeau">
								{attribute_view_gui attribute = $node.data_map.short_description}
							</p>
							<ul class="list">
{foreach $childrenShowed as $enfants sequence array( 'first', '' ) as $style}
								<li class="{$style}">
									{node_view_gui content_node=$enfants view='line'}
								</li>
{/foreach}
							</ul>
			{* Affichage de la pagination *}
			{include 
				view_name='rubric'
				uri='design:navigator/google.tpl' 
				page_uri=$node.url_alias
				item_count=$node.children|count
				view_parameters=$view_parameters 
				item_limit=$nb_max
				left_max=1
				right_max=1
			}
						</div>
					</div>
				</div>
				<div class="bloc-right-bis">
{include uri='design:parts/reserver.tpl'}
{include uri='design:parts/les_plus_consultes.tpl'}
				</div>
{literal}
			<script type="text/javascript">		
					//Menu left
					$("ul.menu-left > li").click(function(){
						$("ul.menu-left > li.actif").removeClass("actif");
						$(this).addClass("actif");
					});
			</script>
{/literal}
{undef $rNode $saisonId $topicIds}