<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>

	<div class="bloc-right-in-bis">
		<div class="bloc-type">
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
			
			<h2 class="bloc-liste-h2">
				{def $titre = ''}
				{* Si le pere de la rubrique est Decouvrir ou Sejourner *}
				{if or(eq($node.parent.node_id, ezini('Noeuds','decouvrir','ayaline.ini')), eq($node.parent.node_id, ezini('Noeuds','sejourner','ayaline.ini')))}
					{* Recuperation de ces objets associes *}
					{def $objetsAsso = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
					{* Pour chaque objet associe *}
					{foreach $objetsAsso as $objetAsso}
						{* test sur le theme : si on est sur le theme par défaut, pas la peine de chercher le titre lié au theme *}
						{if $topicId|ne(ezini('NodeSettings','topicDefaut','content.ini'))}
							{* cas des contenus avec plusieurs emplacements : il faut regarder les différents noeuds *}
							{foreach $objetAsso.assigned_nodes as $rub}
								{* Si le pere de l'objet associe est une saison et qu'il a un titre *}
								{if and($rub.parent.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($rub.parent.data_map.title.value.0))}
									{* Si le pere de l'objet associe correspond a la saison en cours *}
									{if $rub.parent.data_map.title.value.0|eq($saisonId)}
										{* Si le theme en cours n'est pas celui par defaut *}
										{if ne($topicId.0, ezini('NodeSettings','topicDefaut','content.ini'))}
											{* Si l'attribut title_topic du theme en cours n'est pas vide *}
											{if ne($rub.data_map[concat('title_topic_', $topicId.0)].value, '')}
												{set $titre = $rub.data_map[concat('title_topic_', $topicId.0)].value}
											{else}
												{set $titre = $rub.name}
											{/if}
										{else}
											{set $titre = $rub.name}
										{/if}
									{/if}
								{/if}
							{/foreach}
						{/if}
					{/foreach}
				{else}
					{set $titre = $node.name}
				{/if}
				{if ne($titre, '')}
					{$titre}
				{else} {* Cas ou la rubrique n'est pas associee a la saison selectionnee *}
					{$node.name}
				{/if}
			</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
				{attribute_view_gui attribute = $node.data_map.short_description}
			</p>
			
			{* Traitement pour voir si la rubrique est associe au theme courant *}
			{def $rubriqueAssoTheme = false()}
			{* Pour chacun de ses themes *}
			{foreach $node.data_map.topics.content.relation_list as $myTheme}
				{* Si un theme associe correspond a un theme selectionne *}
				{if $myTheme.node_id|eq($topicId.0)}
					{set $rubriqueAssoTheme = true()}
				{/if}
			{/foreach}
			
			{* Si la rubrique est associe au theme courant *}
			{if $rubriqueAssoTheme}
				{* Si le champs description est rempli *}
				{if $node.data_map.description.has_content}
					{attribute_view_gui attribute = $node.data_map.description}
				{else}
					{* Initialisations pour la pagination *}
					{def $nb_max = 4}
					{def $offset = 0}
					{if $view_parameters.offset|gt(0)}
						{set $offset = $view_parameters.offset}
					{/if}
					
					{* Tableau qui contiendra les fils a afficher *}
					{def $filsAssocie = array()}
					
					{* Tableau qui contiendra les noms des fils a afficher *}
					{def $nomFilsAssocie = array()}
					{* Variable qui contiendra le nom du fils a ajouter *}
					{def $nomFilsAjouter = ''}
					
					{def $filsAjoute = false()}
					{def $affFilsListeSIT = ''}
					
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
								{*set $affFilsListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $filsR.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )*}
								{* !! 20110922 !! suppression de cette classe, tout est désormais au niveau de SIT Liste *}
								{set $affFilsListeSIT = $filsR}
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
					
					{* Affichage de la selection *}
					{def $compteurlisterubrique2 = 1}
					<ul class="list">
					{foreach $filsAssocie as $key => $enfant sequence array( 'first', '' ) as $style offset $offset max $nb_max}
						<li class="{$style}">
							{node_view_gui content_node=$enfant view='line' nomEnfant=$nomFilsAssocie.$key}
						</li>
						{if and($filsAssocie|count|gt($compteurlisterubrique2), $style|ne('first'))}
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
						item_count=$filsAssocie|count
						view_parameters=$view_parameters
						item_limit=$nb_max
					}
				{/if}
			{else}
				<p>Cette page n'est pas associée au thème sélectionné.</p>
			{/if}
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
