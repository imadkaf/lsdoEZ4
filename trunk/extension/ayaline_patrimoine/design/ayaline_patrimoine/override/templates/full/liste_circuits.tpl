{*$node.data_map|attribute(show)*}
{def $listeCircuits = false()}
{set $listeCircuits=fetch('content','list',hash('parent_node_id',$node.node_id,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_circuit')
    ))
}

<div class="contenu">
		<div class="accroche">
			{attribute_view_gui attribute=$node.data_map.accroche}
		</div>
		{if gt($listeCircuits|count,0)}
			{def $elt_circuit = false()}
			<section class="liste-circuits-mise-en-avant">
			{foreach $listeCircuits as $circuit}
				{if $circuit.data_map.mise_avant_liste_circuits.value|eq(1)}				
					{node_view_gui content_node=$circuit view='line' simple=false()}
				{/if}	
			{/foreach}
			</section>
			<section class="liste-circuits-simple">
			{foreach $listeCircuits as $circuit}
				{if $circuit.data_map.mise_avant_liste_circuits.value|eq(0)}
					{node_view_gui content_node=$circuit view='line' simple=true()}
				{/if}	
			{/foreach}
			</section>
			{undef $elt_circuit}
		{/if}
</div>
	<div class="bloc-carte-google">
		<p style="padding-left: 10px; padding-top: 11px;"
			class="afficher-bloc">
			<a href="#" class="affichage-bloc bold afficher-map">Carte / Itinéraire</a> 
			<a href="#" class="affichage-bloc afficher-map">Visualisez les parcours !</a>
		</p>
		<p style="padding-left: 10px; padding-top: 11px;" class="masquer-bloc">
			<a href="#" class="affichage-bloc bold masquer-map">Carte /
				Itinéraire</a> <a href="#" class="affichage-bloc masquer-map puce-gris">Masquer
				la carte</a>
		</p>
		<a href="#" class="lien-arrondi google-maps-actif masquer-map"></a> <a
			href="#" class="lien-arrondi google-maps-desactif afficher-map"></a>
		<div class="clear-tout"></div>
	</div>
	<div id="map_canvas" style="width: 100%; z-index: 5555;"></div>
	<script src="http://maps.googleapis.com/maps/api/js?sensor=false"
		type="text/javascript"></script>

