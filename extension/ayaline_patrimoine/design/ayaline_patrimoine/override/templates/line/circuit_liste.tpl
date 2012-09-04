{if $simple}

 <article>
		<a href={$node.url_alias|ezurl} class="image-article" rel='external'>
		{attribute_view_gui attribute=$node.data_map.visuel_normal image_class="circuitNormal"}</a>
		<div class="titre-article">
			<a href={$node.url_alias|ezurl} rel='external'>
			{$node.data_map.titre_circuit.value}
			</a>
		</div>
		<a href={$node.url_alias|ezurl} class="image-lien ui-link" rel='external'>
			{attribute_view_gui attribute=$node.data_map.declinaison_circuit.content.current.data_map.picto_pieton image_class='original'}
		</a>
</article>
<span class="border_entre_circuits"></span>
{else}
			<article>
				<a href={$node.url_alias|ezurl} class="image-article" rel='external'>
				{attribute_view_gui attribute=$node.data_map.visuel_grand_format image_class="circuitMisEnAvant"}</a>
				<div class="bloc-titre">
					<a class="article-titre" href={$node.url_alias|ezurl} rel='external'>
						<span class="titre">{$node.data_map.titre_circuit.value}</span>
						<span class="introduction">{$node.data_map.description.content.input.input_xml|wash|word_cut(5)}...</span>
					</a>
					<a href={$node.url_alias|ezurl} class="image-lien ui-link" rel='external'>
						{attribute_view_gui attribute=$node.data_map.declinaison_circuit.content.current.data_map.picto_pieton image_class='original'}
					</a>
					<div class="clear-tout"></div>
				</div>
			</article>


{/if}