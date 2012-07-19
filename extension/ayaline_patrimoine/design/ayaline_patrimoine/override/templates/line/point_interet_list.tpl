{if $simple}
<article class="vignette-simple">
                        <div>
                        <a href={$node.url_alias|ezurl} class="article-image" rel='external'>{attribute_view_gui attribute=$node.data_map.visuel_normal}</a>
                        <p>
                        <a href={$node.url_alias|ezurl} rel='external'>
                         {attribute_view_gui attribute=$node.data_map.titre_point_interet}
                        </a>
                        </p>
                        <a href={$node.url_alias|ezurl} class="lien-arrondi fleche" rel='external'></a>
                        <div class="clear-tout"></div>
                        </div>
           	</article>
{else}

<div class="vignette-mise-en-avant">
                    <article>
                        <a href={$node.url_alias|ezurl} class="article-image" rel='external'>{attribute_view_gui attribute=$node.data_map.visuel_grand_format}</a>
                        <div class="bloc-titre">
                        <a class="article-titre" href={$node.url_alias|ezurl} rel='external'>
                            {attribute_view_gui attribute=$node.data_map.titre_point_interet}
                        </a>
                        <a href={$node.url_alias|ezurl} class="lien-arrondi fleche" rel='external'></a>
                        <div class="clear-tout"></div>
                        </div>
                    </article>
            	</div>
{/if}