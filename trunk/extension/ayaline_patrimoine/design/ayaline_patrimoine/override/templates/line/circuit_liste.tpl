{if $simple}

 <article>
		<a href={$node.url_alias|ezurl} class="image-article" rel='external'>
		{attribute_view_gui attribute=$node.data_map.visuel_normal image_class="circuitNormal"}</a>
		<div class="titre-article">
			<a href={$node.url_alias|ezurl} rel='external'>
			{$node.data_map.titre_circuit.value}
			</a>
		</div>
		<a href={$node.url_alias|ezurl} class="lien-arrondi-circuits-simple picto-circuit" rel='external'>
			{attribute_view_gui attribute=$node.data_map.pictogramme_circuit_affiche_liste_circuits image_class='pictoCircuit'}
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
					<a href={$node.url_alias|ezurl} class="lien-arrondi-circuits-mise-en-avant picto-circuit" rel='external'>
						{attribute_view_gui attribute=$node.data_map.pictogramme_circuit_affiche_liste_circuits image_class='pictoCircuit'}
					</a>
					<div class="clear-tout"></div>
				</div>
			</article>
			
		
{/if}	 