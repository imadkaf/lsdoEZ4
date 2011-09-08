{if $module_result.uri|eq('/user/login')}
		<div class="PageRoot">Vous êtes sur : <a href="/">Accueil</a> > <strong>Connexion</strong></div>
{/if}

{if $module_result.uri|eq('/content/search')}
		<div class="PageRoot">Vous êtes sur : <a href="/">Accueil</a> > <strong>Recherche</strong></div>
{/if}

{def $titreChemin = ''}
{def $affListeSITFil = ''}
{def $node = ''}

{* Cas particulier pour les fiches "SIT" (qui ne sont pas des noeuds pour avoir un fil d'ariane) *}
{if $cNode|is_set()}
	<div class="PageRoot">Vous êtes sur : 
		{foreach $module_result.path as $Path}
			{set $node = fetch( 'content', 'node', hash( 'node_id', $Path.node_id ) )}
			
			{set $titreChemin = ''}
			
			{* Si le noeud est celui de l'accueil du site *}
			{if $Path.node_id|eq( ezini('NodeSettings','RootNode','content.ini') )}
				{continue}
			{/if}
			
			{* Cas d'une liste SIT *}
			{if eq($node.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
				{set $affListeSITFil = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
				{set $affListeSITFil = $affListeSITFil.0}
				{set $titreChemin = $affListeSITFil.name}
			{else}
				{* Si le noeud est celui de l'accueil du site mobile *}
				{if eq($node.node_id, ezini('NodeSettings','RootMobile','content.ini'))}
					{set $titreChemin = 'Accueil'}
				{else}
					{set $titreChemin = $Path.text}
				{/if}
			{/if}
			
			{if or($Path.url_alias, $Path.url)}
					<a class="ui-link" href={$Path.url_alias|ezurl}>{$titreChemin|wash}</a> >
			{else}
					<strong>{$titreChemin|wash}</strong>
			{/if}
		{/foreach}
	</div>
{elseif $module_result.ui_component|eq('Fiche')}
	<div class="PageRoot">Vous êtes sur : 
		{foreach $module_result.path as $Path}
			{if or($Path.url_alias, $Path.url)}
					<a class="ui-link" href={$Path.url_alias|ezurl}>{$Path.text|wash}</a> >
			{else}
					<strong>{$Path.text|wash}</strong>
			{/if}
		{/foreach}
	</div>
{/if}
