{if $simple}
<article class="vignette-simple">
                        <div>
                        <a href={$node.url_alias|ezurl} class="article-image" rel='external'>
                        {attribute_view_gui attribute=$node.data_map.visuel_normal image_class="pointInteretNormal"}</a>
                        <p>
                        <a href={$node.url_alias|ezurl} rel='external'>
                         {$node.data_map.titre_point_interet.value}
                        </a>
                        </p>
                        <a href={$node.url_alias|ezurl} class="lien-arrondi fleche" rel='external'></a>
                        <div class="clear-tout"></div>
                        </div>
           	</article>
{else}

<div class="vignette-mise-en-avant">
                    <article>
                        <a href={$node.url_alias|ezurl} class="article-image" rel='external'>
                        {attribute_view_gui attribute=$node.data_map.visuel_grand_format image_class="pointInteretMisEnAvant"}
                        </a>
                        <div class="bloc-titre">
                        <a class="article-titre" href={$node.url_alias|ezurl} rel='external'>
                            {$node.data_map.titre_point_interet.value}
                        </a>
                        <a href={$node.url_alias|ezurl} class="lien-arrondi fleche" rel='external'></a>
                        <div class="clear-tout"></div>
                        </div>
                    </article>
            	</div>
{/if}