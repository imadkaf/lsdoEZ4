{def $affichageListeSIT = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id,
																				'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}

{set $affichageListeSIT = $affichageListeSIT.0}

<div class="contenu-liste liste-hotel">
	<div class="titre-liste">
		<h2>{$affichageListeSIT.name}</h2>
	</div>
	
	<div class="rech-dispo">
		<a href="#">Rechercher les disponibilités</a>
	</div>
	
	{sit_liste()}
</div>
