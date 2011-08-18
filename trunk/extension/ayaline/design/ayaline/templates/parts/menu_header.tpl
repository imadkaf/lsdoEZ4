<div class="menu">
	<ul>
{def $mainMenuShowed = false()}
{* sur le noeud racine (classe accueil), on récupère les noeuds qui constitue le menu principal et on boucle dessus *}
{foreach $rNode.data_map.main_menu.content.main_node.children as $key => $sMenu sequence array( 'bottom', 'bottom-2', '' ) as $menuStyle}
		<li class="rubrique{$key}"> {* en principe rubrique0 => Découvrir, rubrique1 => Séjourner, rubrique2 => A la une *}
			{*<a class="element" href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}><span></span></a>*}
			{* suppression du lien sur la rubrique de niveau 1 car lien inutile puisque menu déroulant *}
			<a class="element" href="#"><span>{*$sMenu.data_map.content.content.name|wash*}</span></a> {* TO DO : mettre le titre de la rubrique plutôt qu'un span vide pour le menu principal !!! *}
	{*
		Gestion des sous-menu du menu général
	*}
			<div class="ss-menu">
	{if $key|eq(0)} {* Cas du menu Découvrir *}
				<ul class="top">
		{foreach $topicsList.children as $topic} {* themes Mer/ville/plage/Nature définis dans le pagelayout *}
			{if ne($topic.node_id, ezini('NodeSettings','topicDefaut','content.ini'))} {* on n'affiche pas le thème par défaut *}
				{node_view_gui content_node=$topic view=line topicIds=$topicIds redirectURI=$module_result.uri|ezurl}
			{/if}
		{/foreach}
				</ul>
				<div class="clear"></div>
	{/if}
				<ul class="{$menuStyle}">
	{foreach $sMenu.children as $nodeSeason}
		{*Sélection de la saison souhaitée*}
		{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
			{if $nodeSeason.data_map.title.value.0|eq($saisonId)}
				{foreach $nodeSeason.children as $subKey => $nodeSub_menu sequence array( '', 'right' ) as $style}
					{set $nameRubric = $nodeSub_menu.name}
					{if ezini('classList','HomeMainMenu','content.ini')|contains($nodeSub_menu.class_identifier)}
						{if $key|eq(2)}
							{*Gestion du menu à la une*}
							{switch match=$subKey}
								{*Noeud 'Menu à la une'*}
								{case match=0}
					<li>
						<div class="border">
									{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassMainMenuIdentifier','content.ini'))}
										{node_view_gui content_node=$nodeSub_menu view=main_focus_menu name=$nameRubric}
									{else}
							<span>Vous devez placer un contenu de type {ezini('ClassSettings','ClassMainMenuIdentifier','content.ini')} à cet emplacement.</span>
									{/if}
						</div>
								{/case}
								{*Noeud 'Meteo'*}
								{case match=1}
						<div class="meteo-maree">
									{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassEmbedCodeIdentifier','content.ini'))}
										{node_view_gui content_node=$nodeSub_menu view=main_focus_menu name=$nameRubric}
									{else}
										<span>Vous devez placer un contenu de type {ezini('ClassSettings','ClassEmbedCodeIdentifier','content.ini')} à cet emplacement.</span>
									{/if}
									{include uri='design:parts/maree.tpl'}
									
						</div>
					</li>
								{/case}
								{*Noeud 'BALADES DISCUTEES DANS LES MARAIS'*}
								{case match=2}
					<li class="right">
									{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassAlaUne','content.ini'))}
										{node_view_gui content_node=$nodeSub_menu view=main_focus_menu}
									{else}
										<span>Vous devez placer un contenu de type {ezini('ClassSettings','ClassAlaUne','content.ini')} à cet emplacement.</span>
									{/if}
					</li>
								{/case}
							{/switch}
						{else}
							{*Gestion de l'affichage des items en fonction des thèmes*}
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
								{set $i=inc( $i )}
					<li class="{$style}{if or($i|eq(1), $i|eq(2))} first{/if}">
								{node_view_gui content_node=$nodeSub_menu.data_map.content.content.main_node view=main_menu name=$nameRubric}
					</li>
								{set $mainMenuShowed = false()}
							{/if}
						{/if}
					{/if}
				{/foreach}
				{break}	
			{/if}
		{/if}
	{/foreach}
				</ul>
			</div>
		</li>
{/foreach}
	</ul>
</div>