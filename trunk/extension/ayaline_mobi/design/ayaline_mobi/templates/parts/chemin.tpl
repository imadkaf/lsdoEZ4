{if $module_result.uri|eq('/user/login')}
		<div class="PageRoot">Vous êtes sur : <a href="/">Accueil</a> > <strong>Connexion</strong></div>
{/if}

{if $module_result.uri|eq('/content/search')}
		<div class="PageRoot">Vous êtes sur : <a href="/">Accueil</a> > <strong>Recherche</strong></div>
{/if}

{def $titreChemin = ''}
{def $affListeSITFil = ''}
{def $node = ''}

{def $path = $module_result.path}
{if is_set($pagedata.path_array)}
	{set $path = $pagedata.path_array}
{/if}

{* Cas particulier pour les fiches "SIT" (qui ne sont pas des noeuds pour avoir un fil d'ariane) *}
{if $cNode|is_set()}
	<div class="PageRoot">Vous êtes sur : 
		{foreach $path as $pathNode}
			{set $node = fetch( 'content', 'node', hash( 'node_id', $pathNode.node_id ) )}
			
			{set $titreChemin = ''}
			
			{* Si le noeud est celui de l'accueil du site *}
			{if $pathNode.node_id|eq( ezini('NodeSettings','ContentRootNode','content.ini') )}
				{continue}
			{/if}
			
			{* Cas d'une liste SIT *}
			{if eq($node.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
				{* !! 20110927 !! Idem site internet : suppression de la classe affichage*liste*sit *}
				{*set $affListeSITFil = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )*}
				{set $affListeSITFil = $node}
				{set $titreChemin = $affListeSITFil.name|wash}
			{else}
				{* Si le noeud est celui de l'accueil du site mobile *}
				{if eq($pathNode.node_id, ezini('NodeSettings','RootNode','content.ini'))}
					{set $titreChemin = 'Accueil'}
				{else}
					{set $titreChemin = $pathNode.text}
				{/if}
			{/if}
			
			{if or($pathNode.url_alias, $pathNode.url)}
					<a class="ui-link" href={$pathNode.url_alias|ezurl}>{$titreChemin|wash}</a> >
			{else}
					<strong>{$titreChemin|wash}</strong>
			{/if}
		{/foreach}
	</div>
{elseif $module_result.ui_component|eq('Fiche')}
	<div class="PageRoot">Vous êtes sur : 
		{foreach $path as $pathNode}
			{if eq($pathNode.node_id, ezini('NodeSettings','RootNode','content.ini'))}
				{set $titreChemin = 'Accueil'}
			{else}
				{set $titreChemin = $pathNode.text}
			{/if}
			{if or($pathNode.url_alias, $pathNode.url)}
					<a class="ui-link" href={$pathNode.url_alias|ezurl}>{$titreChemin|wash}</a> >
			{else}
					<strong>{$titreChemin|wash}</strong>
			{/if}
		{/foreach}
	</div>
{/if}
