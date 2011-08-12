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
{def $offset = 0}
{if $view_parameters.offset|gt(0)}
	{set $offset = $view_parameters.offset}
{/if}
{def $childrenShowed = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
												'sort_by', $node.sort_array,
												'class_filter_type' , 'include',
												'class_filter_array', array('rubric', 'sit_liste'),
												'limit',$nb_max,
	              								'offset',$offset))}
{def $childrenShowedCount = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id,
												'sort_by', $node.sort_array,
												'class_filter_type' , 'include',
												'class_filter_array', array('rubric', 'sit_liste')))}

{def $mainMenuShowed = false()}
{def $nameRubric = ''}
{def $nameRubricSelected = ''}
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
					{foreach $nodeSeason.children as $nodeSub_menu}
						{set $nameRubric = $nodeSub_menu.name}
						{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassSubMenuIdentifier','content.ini'))}
							{if $topicIds|count}
								{if $nodeSub_menu.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
									{if $nodeSub_menu.data_map.content.content.main_node.data_map.topics.content.relation_list|count}
										{foreach $nodeSub_menu.data_map.content.content.main_node.data_map.topics.content.relation_list as $relation}
											{foreach $topicIds as $topicId}
												{if $relation.node_id|eq($topicId)}
													{set $mainMenuShowed = true()}
													{if 1|eq($topicIds|count)}
														{set $nameRubric = $nodeSub_menu.data_map[concat('title_topic_', $topicId)].value}
													{/if}
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
							<li{if eq($nodeSub_menu.data_map.content.content.main_node.node_id,$node.node_id)} class="actif"{set $nameRubricSelected=$nameRubric}{/if}>{node_view_gui content_node=$nodeSub_menu.data_map.content.content.main_node view=left_menu name=$nameRubric}</li>
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
							<h2 class="bloc-liste-h2">
{if is_set($nameRubricSelected)}
								{$nameRubricSelected|wash}
{else}
								{attribute_view_gui attribute = $node.data_map.title}
{/if}
							</h2>
							<p class="clear"></p>
							<p class="chapeau">
								{attribute_view_gui attribute = $node.data_map.short_description}
							</p>
							
{def $compteurlisterubrique2 = 1}
							<ul class="list">
{foreach $childrenShowed as $enfants sequence array( 'first', '' ) as $style}
								<li class="{$style}">
									{node_view_gui content_node=$enfants view='line'}
								</li>
	{if and($childrenShowed|count|gt($compteurlisterubrique2), $style|ne('first'))}
							</ul>
							<ul class="list">
	{/if}
	{set $compteurlisterubrique2 = $compteurlisterubrique2|inc}
{/foreach}
							</ul>
			{* Affichage de la pagination *}
			{include 
				uri='design:navigator/google.tpl' 
				page_uri=$node.url_alias
				item_count=$childrenShowedCount
				view_parameters=$view_parameters 
				item_limit=$nb_max
			}
						</div>
					</div>
				</div>
				<div class="bloc-right-bis">
{include uri='design:parts/reserver.tpl'}
{include uri='design:parts/liste_mises_en_avant.tpl'}
				</div>
{literal}
			
			<script type="text/javascript">
				$(window).load(equilibrerHauteursBlocs);
			</script>
{/literal}
{undef $rNode $saisonId $topicIds $nameRubric $nameRubricSelected}