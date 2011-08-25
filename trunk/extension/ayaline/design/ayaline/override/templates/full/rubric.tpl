{if eq($node.class_identifier, $node.parent.object.class_identifier)}
	{node_view_gui content_node=$node view='full_left_menu' view_parameters=$view_parameters}
{else}
	<div class="bloc-left-bis">
		<div class="bloc-type padding-35px-32px">
			<h2 class="bloc-liste-h2">
				{attribute_view_gui attribute = $node.data_map.title}
			</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
				{attribute_view_gui attribute = $node.data_map.short_description}
			</p>

			{* Si le champs description est rempli *}
			{if $node.data_map.description.has_content}
				{attribute_view_gui attribute = $node.data_map.description}
			{else}
				{* Récuperation des variables session *}
				{if ezhttp('saison', 'session', 'hasVariable')}
					{def $saisonId = ezhttp('saison', 'session')}
				{else}
					{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
				{/if}
				{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
					{def $topicId = ezhttp('topics', 'session')}
				{else}
					{def $topicId = array(ezini('NodeSettings','topicDefaut','content.ini'))}
				{/if}
				
				{* Tableau qui contiendra les fils a afficher *}
				{def $filsAssocie = array()}
				
				{* Tableau qui contiendra les noms des fils a afficher *}
				{def $nomFilsAssocie = array()}
				{* Variable qui contiendra le nom du fils a ajouter *}
				{def $nomFilsAjouter = ''}
				
				{def $filsAjoute = false()}
				{def $affFilsListeSIT = ''}
				
				{* Si la rubrique est le noeud Decouvrir ou Sejourner *}
				{if or(eq($node.node_id, ezini('Noeuds','decouvrir','ayaline.ini')), eq($node.node_id, ezini('Noeuds','sejourner','ayaline.ini')))}
					{* Recuperation du menu associe a la rubrique *}
					{def $menuRubrique = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
					{set $menuRubrique = $menuRubrique.0}
				
					{* Pour chaque saison qu'il contient*}
					{foreach $menuRubrique.main_node.children as $saison}
						{* Selection de la saison souhaitee *}
						{if and($saison.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($saison.data_map.title.value.0))}
							{if $saison.data_map.title.value.0|eq($saisonId)}
								{* Pour chaque entree du menu saison choisi *}
								{foreach $saison.children as $entree}
									{* Si l'objet associe possede l'attribut topics *}
									{if is_set($entree.data_map.content.content.main_node.data_map.topics)}
										{* Pour chaque theme associe *}
										{foreach $entree.data_map.content.content.main_node.data_map.topics.content.relation_list as $monTheme1}
											{* Si le fils n'est pas deja ajoute *}
											{if ne($filsAjoute, true())}
												{* Si un theme associe correspond a un theme selectionne *}
												{if $monTheme1.node_id|eq($topicId.0)}
													{set $filsAssocie = $filsAssocie|append($entree.data_map.content.content.main_node)}
													{* Traitement pour ajouter le nom du fils en fonction du theme *}
													{if ne($topicId.0, ezini('NodeSettings','topicDefaut','content.ini'))}
														{if ne($entree.data_map[concat('title_topic_', $topicId.0)].value, '')}
															{set $nomFilsAjouter = $entree.data_map[concat('title_topic_', $topicId.0)].value}
														{else}
															{set $nomFilsAjouter = $entree.name}
														{/if}
													{else}
														{set $nomFilsAjouter = $entree.name}
													{/if}
													{set $nomFilsAssocie = $nomFilsAssocie|append($nomFilsAjouter)}
													{set $filsAjoute = true()}
												{/if}
											{/if}
										{/foreach}
									{else}
										{* Si l'objet associe est de type liste_sit *}
										{if eq($entree.data_map.content.content.main_node.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
											{* On recupere ses themes associes *}
											{set $affFilsListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $entree.data_map.content.content.main_node.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
											{set $affFilsListeSIT = $affFilsListeSIT.0}
											{* Pour chacun de ses themes associes *}
											{foreach $affFilsListeSIT.data_map.topics.content.relation_list as $monTheme2}
												{* Si le fils n'est pas deja ajoute *}
												{if ne($filsAjoute, true())}
													{* Si un theme associe correspond a un theme selectionne *}
													{if $monTheme2.node_id|eq($topicId.0)}
														{set $filsAssocie = $filsAssocie|append($entree.data_map.content.content.main_node)}
														{* Traitement pour ajouter le nom du fils en fonction du theme *}
														{if ne($topicId.0, ezini('NodeSettings','topicDefaut','content.ini'))}
															{if ne($entree.data_map[concat('title_topic_', $topicId.0)].value, '')}
																{set $nomFilsAjouter = $entree.data_map[concat('title_topic_', $topicId.0)].value}
															{else}
																{set $nomFilsAjouter = $entree.name}
															{/if}
														{else}
															{set $nomFilsAjouter = $entree.name}
														{/if}
														{set $nomFilsAssocie = $nomFilsAssocie|append($nomFilsAjouter)}
														{set $filsAjoute = true()}
													{/if}
												{/if}
											{/foreach}
										{/if}
									{/if}
									
									{set $filsAjoute = false()}
								{/foreach}
							{/if}
						{/if}
					{/foreach}
				{else}
					{* Recuperation des fils de la rubrique *}
					{def $filsRubrique = fetch('content','list', hash( 'parent_node_id', $node.node_id,
																		'sort_by', $node.sort_array,
																		'class_filter_type' , 'include',
																		'class_filter_array', array('rubric', 'sit_liste')))}
					
					{* Ajout des fils a afficher *}
					{foreach $filsRubrique as $filsR}
						{* Si le fils possede l'attribut topics *}
						{if is_set($filsR.data_map.topics)}
							{* Pour chaque theme associe *}
							{foreach $filsR.data_map.topics.content.relation_list as $theme1}
								{* Si le fils n'est pas deja ajoute *}
								{if ne($filsAjoute, true())}
									{* Si un theme associe correspond a un theme selectionne *}
									{if $theme1.node_id|eq($topicId.0)}
										{set $filsAssocie = $filsAssocie|append($filsR)}
										{set $nomFilsAssocie = $nomFilsAssocie|append($filsR.name)}
										{set $filsAjoute = true()}
									{/if}
								{/if}
							{/foreach}
						{else}
							{* Si le fils est de type liste_sit *}
							{if eq($filsR.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
								{* On recupere ses themes associes *}
								{set $affFilsListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $filsR.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
								{set $affFilsListeSIT = $affFilsListeSIT.0}
								{* Pour chacun de ses themes associes *}
								{foreach $affFilsListeSIT.data_map.topics.content.relation_list as $theme2}
									{* Si le fils n'est pas deja ajoute *}
									{if ne($filsAjoute, true())}
										{* Si un theme associe correspond a un theme selectionne *}
										{if $theme2.node_id|eq($topicId.0)}
											{set $filsAssocie = $filsAssocie|append($filsR)}
											{set $nomFilsAssocie = $nomFilsAssocie|append($affFilsListeSIT.name)}
											{set $filsAjoute = true()}
										{/if}
									{/if}
								{/foreach}
							{/if}
						{/if}
						
						{set $filsAjoute = false()}
					{/foreach}
				{/if}



				{def $compteurlisterubrique = 1}

				{if $filsAssocie|count}
					<ul class="liste">
					{foreach $filsAssocie as $key => $enfant sequence array( '', '', 'last' ) as $style}
						<li class="{$style}">
							{node_view_gui content_node=$enfant view='line' nomEnfant=$nomFilsAssocie.$key}
						</li>
						{if and($filsAssocie|count|gt($compteurlisterubrique), $style|eq('last'))}
							</ul>
							<ul class="liste">
						{/if}
						
						{set $compteurlisterubrique = $compteurlisterubrique|inc}
					{/foreach}
					</ul>
				{/if}
			{/if}
		</div>
	</div>
	
	<div class="bloc-right-bis">
		{include uri='design:parts/reserver.tpl'}
		{include uri='design:parts/liste_mises_en_avant.tpl'}
	</div>
	
	<script type="text/javascript">
		$(window).load(equilibrerHauteursBlocs);
	</script>
{/if}
