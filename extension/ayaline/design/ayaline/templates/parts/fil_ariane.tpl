{if $module_result.uri|eq('/user/login')}
		<p class="fil-ariane"><a href="/">Les Sables d'Olonne</a> > <strong>Connexion</strong></p>
{/if}
{if $cNode|is_set()}
	{if ne($cNode.node_id, ezini('NodeSettings', 'RootNode', 'content.ini'))}
		<p class="fil-ariane">
		{foreach $module_result.path as $Path}
			{* on regarde si la rubrique � un titre diff�rent en fonction du theme *}
			
			{* pour cela : 1. on recup�re le noeud 
						   2. on regarde si ya une relation inverse depuis un contenu de type rubrique 
						   3. on recupere la rubrique correspondant � la saison
						   4. on r�cup�re le th�me courant et on regarde si la rubrique � un titre sp�cifique au theme
			*}
			{* 1 *}
			{def $node = fetch( 'content', 'node', hash( 'node_id', $Path.node_id ) )}
			{* 2 *}
			{def $rubriques = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
			{* 3 *}
			{foreach $rubriques as $rubrique}
				===============>{$rubrique.main_parent_node_id}
			{/foreach}
			{* 4 *}
			{$Path.text|wash} {*$rubric|attribute(show)*}
			{undef $node $rubriques}
			{if or($Path.url_alias, $Path.url)}
					<a href={$Path.url_alias|ezurl}>{$Path.text|wash}</a> >
			{else}
					<strong>{$Path.text|wash}</strong>
			{/if}
		{/foreach}
		</p>
	{/if}
{/if}