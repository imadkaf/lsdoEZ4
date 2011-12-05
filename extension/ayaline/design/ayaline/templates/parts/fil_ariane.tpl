{def $titreTheme=''}
{if $module_result.uri|eq('/user/login')}
		<p class="fil-ariane"><a href="/">Les Sables d'Olonne</a> > <strong>{"Connection"|i18n("ayaline")}</strong></p>
{elseif $module_result.uri|eq('/content/search')}
		<p class="fil-ariane"><a href="/">Les Sables d'Olonne</a> > <strong>{"Search"|i18n("ayaline")}</strong></p>
{def $affListeSIT=''}
{elseif $cNode|is_set()} {* cas particulier pour les fiches "SIT" (qui ne sont pas des noeuds pour avoir un fil d'ariane *}
	{if ne($cNode.node_id, ezini('NodeSettings', 'RootNode', 'content.ini'))}
		<p class="fil-ariane">
		{foreach $module_result.path as $Path}
			{set $titreTheme=''}
			{* on regarde si la rubrique a un titre different en fonction du theme *}
			
			{* pour cela : 1. on recupere le noeud 
						   2. on regarde si ya une relation inverse depuis un contenu de type rubrique 
						   3. on recupere la rubrique correspondant a la saison
						   4. on recupere le theme courant et on regarde si la rubrique a un titre specifique au theme
			*}
			{* 1 *}
			{def $node = fetch( 'content', 'node', hash( 'node_id', $Path.node_id ) )}
			{* 2 *}
			{def $rubriques = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
			{* 3 & 4 *}

			{foreach $rubriques as $key=>$rubrique}
				{* test sur le theme : si on est sur le theme par défaut, pas la peine de chercher le titre lié au theme *}
				{if $topicId|ne(ezini('NodeSettings','TopicDefaut','content.ini'))}
					{* cas des contenus avec plusieurs emplacements : il faut regarder les différents noeuds *}
					{foreach $rubrique.assigned_nodes as $rub}
						{if and($rub.parent.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($rub.parent.data_map.title.value.0))}
							{* on vérifie qu'on est sur le theme en cours ET qu'un titre a été renseigné pour le theme en question *}
							{if and($rub.parent.data_map.title.value.0|eq($saisonId),$rub.data_map[concat('title_topic_', $topicId)].value|ne(""))}	
								{set $titreTheme=$rub.data_map[concat('title_topic_', $topicId)].value}
								{break}
							{/if}
						{/if}
					{/foreach}
				{/if}	
			{/foreach}
			{* si le titre du theme est défini on s'en sert, sinon on utilise le titre par défaut *}
			{if $titreTheme|eq('')}
				{* cas particulier de liste SIT :
					1. la liste SIT est associée à un sous menu (rubrique de niveau 2 Séjourner -> Hotels par ex) : il faut récupérer le titre du thème
					2. pas d'association avec un sous menu : il faut récupérer la classe affichage*liste*sit liée pour récupérer le titre à afficher 
					!! 20110922 !! modif du 2eme cas, suppression des affichage*liste*sit, le titre est au niveau de la liste SIT directement *}
				
				{if eq($node.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
				{* 1. *}
					{set $affListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
					
				{* 2. *}
					{*set $affListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )}
					{set $affListeSIT = $affListeSIT.0}
					{set $titreTheme=$affListeSIT.name*}
					{set $titreTheme=$Path.text}			
				{else}
					{set $titreTheme=$Path.text}
				{/if}
			{/if}
			{undef $node $rubriques}
			{if or($Path.url_alias, $Path.url)}
					<a href={$Path.url_alias|ezurl}>{$titreTheme|wash}</a> >
			{else}
					<strong>{$titreTheme|wash}</strong>
			{/if}
		{/foreach}
		</p>
	{/if}
{elseif $module_result.ui_component|eq('Fiche')}
	<p class="fil-ariane">
	{foreach $module_result.path as $Path}
		{if or($Path.url_alias, $Path.url)}
				<a href={$Path.url_alias|ezurl}>{$Path.text|wash}</a> >
		{else}
				<strong>{$Path.text|wash}</strong>
		{/if}
	{/foreach}
	</p>
{/if}
{undef $titreTheme $affListeSIT}