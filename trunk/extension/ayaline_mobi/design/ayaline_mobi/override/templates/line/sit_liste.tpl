{* !! 20110927 !! Idem site internet : suppression de la classe affichage*liste*sit *}
{def $affichageListeSIT = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id,
																				'attribute_identifier', 'affichage*liste*sit/liaison_liste' ) )}
																				
{def $affichageListeSIT = $node}
<a href={$node.url_alias|ezurl}>
	{attribute_view_gui attribute=$affichageListeSIT.data_map.thumbnail image_class='contenuMobile'}
</a>

<div class="title">
	<a href={$node.url_alias|ezurl}>{$affichageListeSIT.name}</a>
</div>
<br />