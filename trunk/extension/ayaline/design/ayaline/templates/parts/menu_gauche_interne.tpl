{* Récuperation des variables session *}
{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonID = ezhttp('saison', 'session')}
{else}
	{def $saisonID = ezini('ClassSettings','DefaultSeasonId','content.ini')}
{/if}
{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
	{def $topicIDs = ezhttp('topics', 'session')}
{else}
	{def $topicIDs = array(ezini('NodeSettings','TopicDefaut','content.ini'))}
{/if}

{* Tableau qui contiendra les entrees a afficher *}
{def $entreeAssocie = array()}

{* Tableau qui contiendra les noms des entrees a ajouter *}
{def $nomEntreeAssocie = array()}
{* Variable qui contiendra le nom de l'entree a ajouter *}
{def $nomAjouter = ''}

{def $entreeAjoute = false()}
{def $affEntreeListeSIT = ''}

{* Si le pere est le noeud Decouvrir ou Sejourner *}
{if or(eq($node.parent.node_id, ezini('Noeuds','Decouvrir','ayaline.ini')), eq($node.parent.node_id, ezini('Noeuds','Sejourner','ayaline.ini')))}
	{* Recuperation du menu associe au noeud parent *}
	{def $menuPere = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.parent.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
	{set $menuPere = $menuPere.0}

	{* Pour chaque saison qu'il contient*}
	{foreach $menuPere.main_node.children as $saison}
		{* Sélection de la saison souhaitee *}
		{if and($saison.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($saison.data_map.title.value.0))}
			{if $saison.data_map.title.value.0|eq($saisonID)}
				{* Pour chaque entree du menu saison choisi *}
				{foreach $saison.children as $entree}
					{* Si l'objet associe a l'entree possede l'attribut topics *}
					{if is_set($entree.data_map.content.content.main_node.data_map.topics)}
						{* Pour chaque theme associe *}
						{foreach $entree.data_map.content.content.main_node.data_map.topics.content.relation_list as $monTheme1}
							{* Si l'entree n'est pas deja ajoutee *}
							{if ne($entreeAjoute, true())}
								{* Si un theme associe correspond a un theme selectionne *}
								{if $monTheme1.node_id|eq($topicIDs.0)}
									{set $entreeAssocie = $entreeAssocie|append($entree.data_map.content.content.main_node)}
									{* Traitement pour ajouter le nom de l'entree en fonction du theme *}
									{if ne($topicIDs.0, ezini('NodeSettings','TopicDefaut','content.ini'))}
										{if ne($entree.data_map[concat('title_topic_', $topicIDs.0)].value, '')}
											{set $nomAjouter = $entree.data_map[concat('title_topic_', $topicIDs.0)].value}
										{else}
											{set $nomAjouter = $entree.name}
										{/if}
									{else}
										{set $nomAjouter = $entree.name}
									{/if}
									{set $nomEntreeAssocie = $nomEntreeAssocie|append($nomAjouter)}
									{set $entreeAjoute = true()}
								{/if}
							{/if}
						{/foreach}
					{else}
						{* Si l'entree est de type liste_sit *}
						{if eq($entree.data_map.content.content.main_node.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
							{* On recupere ses themes associes *}
							{* !! 20110922 !! suppression de la classe affichage*liste*sit, le champ est géré directement sur la liste SIT*}
							{*set $affEntreeListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $entree.data_map.content.content.main_node.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )}
							{set $affEntreeListeSIT = $affEntreeListeSIT.0*}
							{set $affEntreeListeSIT =  $entree.data_map.content.content.main_node}
							{* Pour chacun de ses themes associes *}
							{foreach $affEntreeListeSIT.data_map.topics.content.relation_list as $monTheme2}
								{* Si l'entree n'est pas deja ajoutee *}
								{if ne($entreeAjoute, true())}
									{* Si un theme associe correspond a un theme selectionne *}
									{if $monTheme2.node_id|eq($topicIDs.0)}
										{set $entreeAssocie = $entreeAssocie|append($entree.data_map.content.content.main_node)}
										{* Traitement pour ajouter le nom de l'entree en fonction du theme *}
										{if ne($topicIDs.0, ezini('NodeSettings','TopicDefaut','content.ini'))}
											{if ne($entree.data_map[concat('title_topic_', $topicIDs.0)].value, '')}
												{set $nomAjouter = $entree.data_map[concat('title_topic_', $topicIDs.0)].value}
											{else}
												{set $nomAjouter = $entree.name}
											{/if}
										{else}
											{set $nomAjouter = $entree.name}
										{/if}
										{set $nomEntreeAssocie = $nomEntreeAssocie|append($nomAjouter)}
										{set $entreeAjoute = true()}
									{/if}
								{/if}
							{/foreach}
						{/if}
					{/if}
					
					{set $entreeAjoute = false()}
				{/foreach}
			{/if}
		{/if}
	{/foreach}
{else}
	{* Recuperation des fils du noeud parent *}
	{def $childParent = fetch('content','list', hash( 'parent_node_id', $node.parent.node_id,
														'sort_by', $node.sort_array,
														'class_filter_type' , 'include',
														'class_filter_array', ezini('classList','ClassesMenuInterne','content.ini')))}
	
	{* Ajout des fils a afficher *}
	{foreach $childParent as $childP}
		{* Si le noeud possede l'attribut topics *}
		{if is_set($childP.data_map.topics)}
			{* Pour chaque theme associe *}
			{foreach $childP.data_map.topics.content.relation_list as $unTheme1}
				{* Si le fils n'est pas deja ajoute *}
				{if ne($entreeAjoute, true())}
					{* Si un theme associe correspond a un theme selectionne *}
					{if $unTheme1.node_id|eq($topicIDs.0)}
						{set $entreeAssocie = $entreeAssocie|append($childP)}
						{set $nomEntreeAssocie = $nomEntreeAssocie|append($childP.name)}
						{set $entreeAjoute = true()}
					{/if}
				{/if}
			{/foreach}
		{else}
			{* Si le noeud est de type liste_sit *}
			{if eq($childP.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
				{* On recupere ses themes associes *}
				{*set $affEntreeListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $childP.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )*}
				{set $affEntreeListeSIT = $childP}
				{* Pour chacun de ses themes associes *}
				{foreach $affEntreeListeSIT.data_map.topics.content.relation_list as $unTheme2}
					{* Si le fils n'est pas deja ajoute *}
					{if ne($entreeAjoute, true())}
						{* Si un theme associe correspond a un theme selectionne *}
						{if $unTheme2.node_id|eq($topicIDs.0)}
							{set $entreeAssocie = $entreeAssocie|append($childP)}
							{set $nomEntreeAssocie = $nomEntreeAssocie|append($affEntreeListeSIT.name)}
							{set $entreeAjoute = true()}
						{/if}
					{/if}
				{/foreach}
			{/if}
		{/if}
			
		{set $entreeAjoute = false()}
	{/foreach}
{/if}



<div class="bloc-type menu-gauche-normal">
	<h2 class="menu-gauche-h2">
		{def $titreMenu = ''}
		{* Si le grand-parent du noeud en cour est Decouvrir ou Sejourner *}
		{if or(eq($node.parent.parent.node_id, ezini('Noeuds','Decouvrir','ayaline.ini')), eq($node.parent.parent.node_id, ezini('Noeuds','Sejourner','ayaline.ini')))}
			{* Recuperation des objets associes au pere *}
			{def $menusAssoPere = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.parent.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
			{* Pour chaque objet associe *}
			{foreach $menusAssoPere as $menuAssoPere}
				{* Si le pere de l'objet associe est une saison et qu'il a un titre *}
				{if and($menuAssoPere.main_node.parent.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($menuAssoPere.main_node.parent.data_map.title.value.0))}
					{* Si le pere de l'objet associe correspond a la saison en cours *}
					{if $menuAssoPere.main_node.parent.data_map.title.value.0|eq($saisonID)}
						{* Si le theme en cours n'est pas celui par defaut *}
						{if ne($topicIDs.0, ezini('NodeSettings','TopicDefaut','content.ini'))}
							{* Si l'attribut title_topic du theme en cours n'est pas vide *}
							{if ne($menuAssoPere.main_node.data_map[concat('title_topic_', $topicIDs.0)].value, '')}
								{set $titreMenu = $menuAssoPere.main_node.data_map[concat('title_topic_', $topicIDs.0)].value}
							{else}
								{set $titreMenu = $menuAssoPere.main_node.name}
							{/if}
						{else}
							{set $titreMenu = $menuAssoPere.main_node.name}
						{/if}
					{/if}
				{/if}
			{/foreach}
		{else}
			{set $titreMenu = $node.parent.name}
		{/if}
		{if ne($titreMenu, '')}
			{$titreMenu}
		{else} {* Cas ou la rubrique parente n'est pas associee a la saison selectionnee *}
			{$node.parent.name}
		{/if}
	</h2>
	<p class="clear"></p>
	
	<ul class="menu-left">
	{* Declaration des variables avant la boucle *}
	{def $subChildren = ''}
	{def $subChildParentAssocie = array()}
	{def $subChildParentAjoute = false()}
	{def $subAffParentListeSIT = ''}
	{def $nomSousFils = ''}
	{def $subNomChildParentAssocie = array()}
	
	{* Pour chaque fils a afficher *}
	{foreach $entreeAssocie as $entreeKey => $childPA}
		{* Recuperation des sous-fils *}
		{set $subChildren = fetch('content','list', hash( 'parent_node_id', $childPA.node_id,
															'sort_by', $node.sort_array,
															'class_filter_type' , 'include',
															'class_filter_array', ezini('classList','ClassesMenuInterne','content.ini') ))}

		{* Initialisation des variables *}
		{set $subChildParentAssocie = array()}
		{set $subChildParentAjoute = false()}
		{set $subAffParentListeSIT = ''}
		{set $subNomChildParentAssocie = array()}
		
		{* Ajout des sous-fils a afficher *}
		{foreach $subChildren as $subChildP}
			{* Si le noeud possede l'attribut topics *}
			{if is_set($subChildP.data_map.topics)}
				{* Pour chaque theme associe *}
				{foreach $subChildP.data_map.topics.content.relation_list as $subTheme1}
					{* Si le sous-fils n'est pas deja ajoute *}
					{if ne($subChildParentAjoute, true())}
						{* Si un theme associe correspond a un theme selectionne *}
						{if $subTheme1.node_id|eq($topicIDs.0)}
							{set $subChildParentAssocie = $subChildParentAssocie|append($subChildP)}
							{set $subNomChildParentAssocie = $subNomChildParentAssocie|append($subChildP.name)}
							{set $subChildParentAjoute = true()}
						{/if}
					{/if}
				{/foreach}
			{else}
				{* Si le noeud est de type liste_sit *}
				{if eq($subChildP.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
					{* On recupere ses themes associes *}
					{*set $subAffParentListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $subChildP.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )*}
					
					{set $subAffParentListeSIT = $subChildP}
					{* Pour chacun de ses themes associes *}
					{foreach $subAffParentListeSIT.data_map.topics.content.relation_list as $subTheme2}
						{* Si le sous-fils n'est pas deja ajoute *}
						{if ne($subChildParentAjoute, true())}
							{* Si un theme associe correspond a un theme selectionne *}
							{if $subTheme2.node_id|eq($topicIDs.0)}
								{set $subChildParentAssocie = $subChildParentAssocie|append($subChildP)}
								{set $subNomChildParentAssocie = $subNomChildParentAssocie|append($subAffParentListeSIT.name)}
								{set $subChildParentAjoute = true()}
							{/if}
						{/if}
					{/foreach}
				{/if}
			{/if}
				
			{set $subChildParentAjoute = false()}
		{/foreach}


		{* Si le fils est la page elle meme *}
		{if eq($childPA.node_id,$node.node_id)}
			<li class="actif">
		{else}
			<li>
		{/if}
		{* Si le fils n'a aucun sous-fils *}
		{if not($subChildParentAssocie|count)}
				<a href={$childPA.url_alias|ezurl}><span>{$nomEntreeAssocie.$entreeKey}</span></a>
		{else}
				<span>{$nomEntreeAssocie.$entreeKey}</span>
		{/if}
		{* Affichage des sous-fils s'il y en a *}
		{if $subChildParentAssocie|count}
				<ul class="s-menu">
				{* Pour chacun des sous-fils *}
				{foreach $subChildParentAssocie as $subKey => $subChildPA}
					<li><a href={$subChildPA.url_alias|ezurl}>{$subNomChildParentAssocie.$subKey}</a></li>
				{/foreach}
				</ul>
		{/if}
			</li>
	{/foreach}
	</ul>
</div>
