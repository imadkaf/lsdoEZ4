{if $simple}
<div class="vignette-simple">
	<article>
                        <div>
                        <a href={$node.url_alias|ezurl} class="article-image" rel='external'>
                        {attribute_view_gui attribute=$node.data_map.visuel_normal image_class="pointInteretNormal"}</a>
                        <p>
                        <a href={$node.url_alias|ezurl} rel='external'>
                         {$node.data_map.titre_point_interet.value}
                        </a>
                        </p>
						<a href={$node.url_alias|ezurl} class="image-lien ui-link" rel='external'>
                        	{attribute_view_gui attribute=$declinaison.data_map.picto_fleche}
                        </a>
                        <div class="clear-tout"></div>
                        </div>
           	</article>
</div>
{else}

<div class="liste-circuits-simple liste-mis-en-avant-inetrets">
                    <article>
                        <a href={$node.url_alias|ezurl} class="article-image" rel='external'>
                        {attribute_view_gui attribute=$node.data_map.visuel_grand_format image_class="pointInteretMisEnAvant"}
                        </a>
                        <div class="titre-article">
                        <a href={$node.url_alias|ezurl} rel='external'>
                            {$node.data_map.titre_point_interet.value}
                        </a>
                        </div>
                        <a href={$node.url_alias|ezurl} class="image-lien ui-link" rel='external'>
                        	{attribute_view_gui attribute=$declinaison.data_map.picto_fleche}
                        </a>
                    </article>
                    <span class="border_entre_circuits"></span>
 </div>
{/if}