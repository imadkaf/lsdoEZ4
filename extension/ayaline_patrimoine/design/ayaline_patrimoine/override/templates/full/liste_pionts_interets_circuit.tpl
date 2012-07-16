{*Page affiche la liste points d'intérêts*}
{def $listePointsInterets = false()}
{def $listePointsInteretsMisEnAvant = array()}

{set $listePointsInterets=fetch('content','list',hash('parent_node_id',$node.node_id,
												'sort_by', $node.sort_array,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_point_interet')
 ))}

{foreach $node.data_map.liste_poiunts_interets_mis_avant.content.relation_list as $PointInteretMisEnAvant}
	{set $listePointsInteretsMisEnAvant = $listePointsInteretsMisEnAvant|append($PointInteretMisEnAvant.node_id)}
{/foreach}

<div class="contenu">
	<div class="accroche">
		<h1 class="titre_circuit">
			<p>
				{$node.data_map.titre_circuit.value}
			</p>
		</h1>
		{attribute_view_gui attribute=$node.data_map.description}
	</div>
	<div class="liste-interets">
	{if gt($listePointsInterets|count,0)}
		{foreach $listePointsInterets as $PointInteret}
			{if $listePointsInteretsMisEnAvant|contains($PointInteret.node_id)}
				{node_view_gui content_node=$PointInteret view='line' simple=false()} 
			{else}
				{node_view_gui content_node=$PointInteret view='line' simple=true()}
			{/if}
		{/foreach}
    {/if}
	</div>
</div>
<div class="bloc-carte-google">
                <p style="padding-left:16px;padding-top: 16px;" class="afficher-bloc">
                    <a href="#" class="affichage-bloc bold afficher-map">{attribute_view_gui attribute=$node.data_map.titre_onglet_carte}</a>
                    <a href="#" class="affichage-bloc afficher-map">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_ferme}</a>
                </p>
                <p style="padding-left:16px;padding-top: 16px;" class="masquer-bloc">
                    <a href="#" class="affichage-bloc bold masquer-map">{attribute_view_gui attribute=$node.data_map.titre_onglet_carte}</a>
                    <a href="#" class="affichage-bloc masquer-map puce-gris">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_ouvert}</a>
                </p>
              
                <a href="#" class="lien-arrondi google-map-actif-circuit masquer-map"></a>
                <a href="#" class="lien-arrondi google-map-ferme-circuit afficher-map"></a>
                <div class="clear-tout"></div>
 </div>
 <div id="map_canvas" style="width:100%;z-index: 5555;border-top:1px solid #D1CCC8;"></div>
 <script src="http://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
{undef $listePointsInteretsMisEnAvant $listePointsInterets}