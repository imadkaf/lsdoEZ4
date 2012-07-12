{*$node|attribute(show)*}
{if $simple}
 <article>
		<a href="#" class="image-article">{attribute_view_gui attribute=$node.data_map.visuel_normal}
		</a>
		<div class="titre-article">
			<a href="#">{attribute_view_gui attribute=$node.data_map.titre_circuit}</a>
		</div>
		<a href="#" class="lien-arrondi homme-vert"></a> 
</article> 
		<!-- <article>
		<a href="#" class="image-article"><img src="images/circuit2.jpg"
			alt="">
		</a>
		<div class="titre-article">
			<a href="#">Le Port de Pêche & le Coeur de Ville</a>
		</div>
		<a href="#" class="lien-arrondi homme-rose"></a> </article> <article>
		<a href="#" class="image-article"><img src="images/circuit2.jpg"
			alt="">
		</a>
		<div class="titre-article">
			<a href="#">La Chaume</a>
		</div>
		<a href="#" class="lien-arrondi homme-bleu-ciel"></a> </article>  -->
		
{else}
			<article>
				<a href="#" class="image-article">{attribute_view_gui attribute=$node.data_map.visuel_grand_format}</a>
				<div class="bloc-titre">
					<a class="article-titre" href="#"> 
						<span class="titre">{attribute_view_gui attribute=$node.data_map.titre_circuit}</span> 
							<span class="introduction">{attribute_view_gui attribute=$node.data_map.description}</span> </a> 
							<a href="#" class="lien-arrondi homme"><span></span>
					</a>
					<div class="clear-tout"></div>
				</div>
			</article>
		
{/if}	 