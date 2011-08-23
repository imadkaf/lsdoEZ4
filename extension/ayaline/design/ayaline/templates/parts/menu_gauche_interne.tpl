{* Récuperation des variables session *}
{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonID = ezhttp('saison', 'session')}
{else}
	{def $saisonID = ezini('ClassSettings','DefaultSeasonId','content.ini')}
{/if}
{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
	{def $topicIDs = ezhttp('topics', 'session')}
{else}
	{def $topicIDs = array(ezini('NodeSettings','topicDefaut','content.ini'))}
{/if}

{* Tableau qui contiendra les fils a afficher *}
{def $entreeAssocie = array()}

{* Tableau qui contiendra les noms des entrees a ajouter *}
{def $nomEntreeAssocie = array()}
{* Variable qui contiendra le nom de l'entree a ajouter *}
{def $nomAjouter = ''}

{def $entreeAjoute = false()}
{def $affEntreeListeSIT = ''}

{* Si le parent est le noeud Decouvrir ou Sejourner *}
{if or(eq($node.parent.node_id, ezini('Noeuds','decouvrir','ayaline.ini')), eq($node.parent.node_id, ezini('Noeuds','sejourner','ayaline.ini')))}
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
					{* Si l'objet associe possede l'attribut topics *}
					{if is_set($entree.data_map.content.content.main_node.data_map.topics)}
						{* Pour chaque theme associe *}
						{foreach $entree.data_map.content.content.main_node.data_map.topics.content.relation_list as $monTheme1}
							{* Si le fils n'est pas deja ajoute *}
							{if ne($entreeAjoute, true())}
								{* Si un theme associe correspond a un theme selectionne *}
								{if $monTheme1.node_id|eq($topicIDs.0)}
									{set $entreeAssocie = $entreeAssocie|append($entree.data_map.content.content.main_node)}
									{* Traitement pour ajouter le nom de l'entree en fonction du theme *}
									{if ne($topicIDs.0, ezini('NodeSettings','topicDefaut','content.ini'))}
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
						{* Si le noeud est de type liste_sit *}
						{if eq($entree.data_map.content.content.main_node.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
							{* On recupere ses themes associes *}
							{set $affEntreeListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $entree.data_map.content.content.main_node.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
							{set $affEntreeListeSIT = $affEntreeListeSIT.0}
							{* Pour chacun de ses themes associes *}
							{foreach $affEntreeListeSIT.data_map.topics.content.relation_list as $monTheme2}
								{* Si le fils n'est pas deja ajoute *}
								{if ne($entreeAjoute, true())}
									{* Si un theme associe correspond a un theme selectionne *}
									{if $monTheme2.node_id|eq($topicIDs.0)}
										{set $entreeAssocie = $entreeAssocie|append($entree.data_map.content.content.main_node)}
										{* Traitement pour ajouter le nom de l'entree en fonction du theme *}
										{if ne($topicIDs.0, ezini('NodeSettings','topicDefaut','content.ini'))}
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
			{foreach $childP.data_map.topics.content.relation_list as $theme1}
				{* Si le fils n'est pas deja ajoute *}
				{if ne($entreeAjoute, true())}
					{* Si un theme associe correspond a un theme selectionne *}
					{if $theme1.node_id|eq($topicIDs.0)}
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
				{set $affEntreeListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $childP.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
				{set $affEntreeListeSIT = $affEntreeListeSIT.0}
				{* Pour chacun de ses themes associes *}
				{foreach $affEntreeListeSIT.data_map.topics.content.relation_list as $theme2}
					{* Si le fils n'est pas deja ajoute *}
					{if ne($entreeAjoute, true())}
						{* Si un theme associe correspond a un theme selectionne *}
						{if $theme2.node_id|eq($topicIDs.0)}
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



<div class="bloc-type">
	<h2 class="menu-gauche-h2">
		{attribute_view_gui attribute = $node.parent.data_map.title}
	</h2>
	<p class="clear"></p>
	
	<ul class="menu-left">
	{* Initialisations avant la boucle *}
	{def $subChildren = ''}
	{def $subChildParentAssocie = array()}
	{def $subChildParentAjoute = false()}
	{def $subAffParentListeSIT = ''}

	{def $nomSousFils = ''}
	{def $affListeSITSousFils = ''}
	
	{* Pour chaque fils a afficher *}
	{foreach $entreeAssocie as $entreeKey => $childPA}
		{* Recuperation des sous-fils *}
		{set $subChildren = fetch('content','list', hash( 'parent_node_id', $childPA.node_id,
															'sort_by', $node.sort_array,
															'class_filter_type' , 'include',
															'class_filter_array', ezini('classList','ClassesMenuInterne','content.ini') ))}

		{* Tableau qui contiendra les sous-fils a afficher *}
		{set $subChildParentAssocie = array()}

		{set $subChildParentAjoute = false()}
		{set $subAffParentListeSIT = ''}
		
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
							{set $subChildParentAjoute = true()}
						{/if}
					{/if}
				{/foreach}
			{else}
				{* Si le noeud est de type liste_sit *}
				{if eq($subChildP.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
					{* On recupere ses themes associes *}
					{set $subAffParentListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $subChildP.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
					{set $subAffParentListeSIT = $subAffParentListeSIT.0}
					{* Pour chacun de ses themes associes *}
					{foreach $subAffParentListeSIT.data_map.topics.content.relation_list as $subTheme2}
						{* Si le sous-fils n'est pas deja ajoute *}
						{if ne($subChildParentAjoute, true())}
							{* Si un theme associe correspond a un theme selectionne *}
							{if $subTheme2.node_id|eq($topicIDs.0)}
								{set $subChildParentAssocie = $subChildParentAssocie|append($subChildP)}
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
				{foreach $subChildParentAssocie as $subChildPA}
					{* Traitement pour recuperer le bon nom du sous-fils *}
					{set $nomSousFils = ''}
					{if eq($subChildPA.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
						{set $affListeSITSousFils = fetch('content', 'reverse_related_objects', hash( 'object_id', $subChildPA.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
						{set $affListeSITSousFils = $affListeSITSousFils.0}
						{set $nomSousFils = $affListeSITSousFils.name}
					{else}
						{set $nomSousFils = $subChildPA.name}
					{/if}
					<li><a href={$subChildPA.url_alias|ezurl}>{$nomSousFils}</a></li>
				{/foreach}
				</ul>
		{/if}
			</li>
	{/foreach}
	</ul>
</div>
