<div class="menu">
	<ul>
{def $mainMenuShowed = false()}
{def $affMenuListeSIT=""}
{* sur le noeud racine (classe accueil), on récupère les noeuds qui constitue le menu principal et on boucle dessus -> menu général dans lequel on retrouve les arbos par saison *}
{foreach $rNode.data_map.main_menu.content.main_node.children as $key => $sMenu sequence array( 'bottom', 'bottom-2', '' ) as $menuStyle}
		<li class="rubrique{$key}"> {* en principe rubrique0 => Découvrir, rubrique1 => Séjourner, rubrique2 => A la une *}
			{*<a class="element" href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}><span></span></a>*}
			{* suppression du lien sur la rubrique de niveau 1 car lien inutile puisque menu déroulant *}
			<a class="element" href="#"><span>{*$sMenu.data_map.content.content.name|wash*}</span></a> {* TO DO : mettre le titre de la rubrique plutôt qu'un span vide pour le menu principal !!! *}
	{*
		Gestion des sous-menu du menu général
	*}
			<div class="ss-menu">
	{if or($key|eq(0),$key|eq(1))} {* Cas du menu Découvrir & Séjourner *}
				{* affichage des thème en haut du menu découvrir *}
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
	{* $sMenu.children correspond à Découvrir / Séjourner / A la une du menu 'Configuration générale'->'Menu Général'-> Découvrir ou Séjourner ou A la Une *}
	{* Dans chaque arbo Découvrir / Séjourner / A la une, on retrouve les 4 saisons. on boucle sur ces saisons *}
	{foreach $sMenu.children as $nodeSeason}
		{*Sélection de la saison souhaitée*}
		{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
			{if $nodeSeason.data_map.title.value.0|eq($saisonId)}
				{* pour la saison sélectionnée, on parcourt les sous-éléments *}
				{def $index=0}
				{foreach $nodeSeason.children as $subKey => $nodeSub_menu}
					{set $nameRubric = $nodeSub_menu.name}
					{* on n'affiche que certaines classes de contenu dans le menu *}
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
						{else} {* menu découvrir ou séjourner*}
							{*Gestion de l'affichage des items en fonction des thèmes*}
							{if $topicIds|count}
								{* si un theme est sélectionné, on vérifie que la classe à afficher est un contenu de type 'rubric' *}
								{if or($nodeSub_menu.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassRubricIdentifier','content.ini')),
										$nodeSub_menu.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassListeSIT','content.ini')))}
									{* on récupère les themes sélectionnés au niveau de la rubrique et pour chacun de ces thèmes on teste si le theme courant fait partie de ceux de la rubrique *}
									{if $nodeSub_menu.data_map.content.content.main_node.data_map.topics.content.relation_list|count}
										{foreach $nodeSub_menu.data_map.content.content.main_node.data_map.topics.content.relation_list as $relation}
											{* NB : un seul theme sélectionné par l'internaute à la fois *}
											{foreach $topicIds as $topicId}
												{if $topicId|ne(ezini('NodeSettings','topicDefaut','content.ini'))} {* cas du thème par defaut à ne pas prendre en compte*}
													{* cas ou la rubrique est associé au thème courant : dans ce cas on récupère le titre de la rubrique*}
													{if $relation.node_id|eq($topicId)}
														{set $mainMenuShowed = true()}
														{if and(1|eq($topicIds|count),$nodeSub_menu.data_map[concat('title_topic_', $topicId)].value|ne(""))}
															{set $nameRubric = $nodeSub_menu.data_map[concat('title_topic_', $topicId)].value}
														{/if}
														{break}
													{/if}
												{else}
													{set $mainMenuShowed = true()}													
												{/if}
											{/foreach}
										{/foreach}
									{else}
										{set $mainMenuShowed = true()}
									{/if}
								{*elseif $nodeSub_menu.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassListeSIT','content.ini'))*}
								{* cas des Listes SIT : on n'a pas directement la correspondance entre la classe et le thème, on est obligé d'aller récupérer le thème dans la classe associée (affichage*liste*sit) *}
								{* -> 20110922 ! ce n'est plus le cas !! suppression de cette classe, on a mis l'info directement au niveau de la liste SIT*}
									{*set $affMenuListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $nodeSub_menu.data_map.content.content.main_node.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )}
									{set $affMenuListeSIT = $affMenuListeSIT.0*}
									{* on a récupéré l'élément Affichage Liste SIT qui a le champ theme, on peut faire le meme traitement que dans le if précédent *}
									{*if $affMenuListeSIT.data_map.topics.content.relation_list|count}
										{foreach $affMenuListeSIT.data_map.topics.content.relation_list as $relation*}
											{* NB : un seul theme sélectionné par l'internaute à la fois *}
											{*foreach $topicIds as $topicId}
												{if $topicId|ne(ezini('NodeSettings','topicDefaut','content.ini'))*} {* cas du thème par defaut à ne pas prendre en compte*}
													{* cas ou la rubrique est associé au thème courant : dans ce cas on récupère le titre de la rubrique*}
													{*if $relation.node_id|eq($topicId)}
														{set $mainMenuShowed = true()}
														{if and(1|eq($topicIds|count),$nodeSub_menu.data_map[concat('title_topic_', $topicId)].value|ne(""))}
															{set $nameRubric = $nodeSub_menu.data_map[concat('title_topic_', $topicId)].value}
														{/if}
														{break}
													{/if}
												{else*}
													{* on prend le nom de la rubrique par défaut *}
													{*set $mainMenuShowed = true()}													
												{/if}
											{/foreach}
										{/foreach*}
									{*else}
										{set $mainMenuShowed = true()}
									{/if*}
								{else} 
									{* cas ou un autre type de contenu (que 'Rubrique' et 'Liste SIT' seraient dans le menu : une page de contenu libre par ex, mais ceci ne devrait pas arriver car aucune vignette ne s'affichera dans le menu *}
									{set $mainMenuShowed = true()}
								{/if}
							{else}
								{* cas ou il y a aucun thème de sélectionné : ne devrait jamais arriver car meme si aucun theme n'est sélectionné, c'est le theme 'defaut' qui est renseigné *}
								{set $mainMenuShowed = true()}
							{/if}
							{if $mainMenuShowed}
								{set $i=inc( $i )}
					<li class="{if eq($index|mod(2),1)}right{/if}{if or($i|eq(1), $i|eq(2))} first{/if}">
								{node_view_gui content_node=$nodeSub_menu.data_map.content.content.main_node view=main_menu name=$nameRubric}
					</li>
								{set $index=inc( $index )}
								{set $mainMenuShowed = false()}
							{/if}
						{/if}
					{/if}
				{/foreach}
				{undef $index}
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