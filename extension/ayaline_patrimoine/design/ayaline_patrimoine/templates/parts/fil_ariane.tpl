<nav id="breadcrumbs"> 
{if $module_result.uri|eq('/user/login')}
		<span>Vous êtes sur : </span><a href="/" rel='external'>Accueil</a> > <strong>Connexion</strong>
{elseif $module_result.uri|eq('/content/search')}
		<span>Vous êtes sur : </span><a href="/" rel='external'>Accueil</a> > <strong>Recherche</strong>
{else}

    {def $titreChemin = ''}
    {def $node = ''}

    {def $path = $module_result.path}
    {if is_set($pagedata.path_array)}
            {set $path = $pagedata.path_array}
    {/if}

    {if $cNode|is_set()}
            <span>Vous êtes sur : </span><a href="/" rel='external'>Accueil</a>&nbsp;> {foreach $path as $pathNode offset 2}
                            {set $node = fetch( 'content', 'node', hash( 'node_id', $pathNode.node_id ) )}
                            {set $titreChemin = ''}
                                    {* Si le noeud est celui de l'accueil du site mobile *}
                                    {if eq($pathNode.node_id, ezini('NodeSettings','RootNodePatrimoine','content.ini'))}
                                            {set $titreChemin = 'Accueil'}
                                    {else}
                                            {set $titreChemin = $pathNode.text}
                                    {/if}
                            {if or($pathNode.url_alias, $pathNode.url)}
                                            <a class="ui-link" href={$pathNode.url_alias|ezurl} rel='external'>{striptags($titreChemin)}</a> >
                            {else}
                                            <strong>{striptags($titreChemin)}</strong>
                            {/if}
                    {/foreach}
    {/if}
    
{/if}


</nav>



