{* !! 20110927 !! Idem site internet : suppression de la classe affichage*liste*sit *}
{*def $affichageListeSIT = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id,
																				'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )*}

{def $affichageListeSIT = $node}

<div class="contenu-liste liste-hotel">
	<div class="titre-liste">
		<h2>{$affichageListeSIT.name|wash}</h2>
	</div>
	
{*	<div class="rech-dispo">
		<a href="#">Rechercher les disponibilités</a>
	</div>*}
	
	{sit_liste()}
</div>
