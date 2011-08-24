{def $titreTheme=''}
{if $module_result.uri|eq('/user/login')}
		<p class="fil-ariane"><a href="/">Les Sables d'Olonne</a> > <strong>Connexion</strong></p>
{/if}

	{if ne($cNode.node_id, ezini('NodeSettings', 'RootNode', 'content.ini'))}
		<p class="fil-ariane">
		{foreach $module_result.path as $Path}
			{set $titreTheme=''}
			{* on regarde si la rubrique a un titre different en fonction du theme *}
			
			{* pour cela : 1. on recupere le noeud 
						   2. on regarde si ya une relation inverse depuis un contenu de type rubrique 
						   3. on recupere la rubrique correspondant a la saison
						   4. on recupere le theme courant et on regarde si la rubrique a un titre sp�cifique au theme
			*}
			{* 1 *}
			{def $node = fetch( 'content', 'node', hash( 'node_id', $Path.node_id ) )}
			{* 2 *}
			{def $rubriques = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
			{* 3 & 4 *}
			{foreach $rubriques as $rubrique}
				{* test sur le theme : si on est sur le theme par défaut, pas la peine de chercher le titre lié au theme *}
				{if $topicId|ne(ezini('NodeSettings','topicDefaut','content.ini'))}
					{* test sur la saison *}
					{if and($rubrique.main_node.parent.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($rubrique.main_node.parent.data_map.title.value.0))}
						{* on vérifie qu'on est sur le theme en cours ET qu'un titre a été renseigné pour le theme en question *}
						{if and($rubrique.main_node.parent.data_map.title.value.0|eq($saisonId),$rubrique.data_map[concat('title_topic_', $topicId)].value|ne(""))}	
							{set $titreTheme=$rubrique.data_map[concat('title_topic_', $topicId)].value}
							{break}
						{/if}
					{/if}
				{/if}	
			{/foreach}
			{* si le titre du theme est défini on s'en sert, sinon on utilise le titre par défaut *}
			{if $titreTheme|eq('')}{set $titreTheme=$Path.text}{/if}
			{undef $node $rubriques}
			{if or($Path.url_alias, $Path.url)}
					<a href={$Path.url_alias|ezurl}>{$titreTheme|wash}</a> >
			{else}
					<strong>{$titreTheme|wash}</strong>
			{/if}
		{/foreach}
		</p>
	{/if}

{undef $titreTheme}