{*$node.data_map.media_principal.content|attribute(show)*}

<div class="contenu">
	<div class="accroche border-bottom">
        <h1 class="titre-parcours">
             Parcours <a href="#"><b>{attribute_view_gui attribute=$node.parent.data_map.titre_circuit}</b></a>
        </h1>
     </div>
     <div class="fiche-interet">
     	<h2>{attribute_view_gui attribute=$node.data_map.titre_point_interet}</h2>
     	<div class="video">
     	{def $media_principal = false()}
     	{set $media_principal=fetch( 'content', 'node', hash( 'node_id', $node.data_map.media_principal.content.main_node_id))}
     	{node_view_gui content_node=$media_principal view='line'}      
     	</div>
     </div>
     {def $elemnts = false()}
					{set $elemnts=fetch('content','list',hash('parent_node_id',$node.node_id))}
					{def $etat = false()}
					{foreach $elemnts as $elt}
						{if ne($elt.node_id,$node.data_map.media_principal.content.main_node_id)}
							{set $etat = true()}
						{/if}
					{/foreach}
	{if and(gt($elemnts|count,1),$etat)}
     <div class="bloc-plus-image">
     	<div class="info accroche-plus-image">
                <p class="afficher-bloc-image"><a class="affichage-bloc voir-image" href="#"><span class="bold">{attribute_view_gui attribute=$node.data_map.titre_onglet_plus_medias}</span>{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_plus_medias_ferme}</a></p>
                <p class="masquer-bloc-image"><a class="affichage-bloc masquer-image" href="#"><span class="bold">{attribute_view_gui attribute=$node.data_map.titre_onglet_plus_medias}</span> <span class="affichage-bloc puce-gris">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_plus_medias_ouvert}</span></a></p>
                <a href="#" class="lien-arrondi plus-image voir-image"></a>
                <a href="#" class="lien-arrondi plus-image-ouvert masquer-image"></a>    
            </div>
         <div class="clear-tout"></div>
         <div class="liste-medias">
         {foreach $elemnts as $elt}
				{if ne($elt.node_id,$node.data_map.media_principal.content.main_node_id)}
					{if eq($elt.class_identifier,'smp_diaporama')}
						<div class="media">
                            <div class="diaporama">
                            <a href="#" class="image"><img src={"images/min.jpg"|ezdesign}/></a>
                            <a href="#" class="droite"></a>
                            <a href="#" class="gauche"></a>
                        </div>
                        <div class="contenu-media">
                        <h3><a href="#">{attribute_view_gui attribute=$elt.data_map.titre_diaporama}</a></h3>
                        <span class="puce-gris">Diaporama</span>
                    </div>
                    <div class="clear-tout"></div>
                 </div>
					{elseif eq($elt.class_identifier,'smp_audio')}
					<div class="media">
                            <a class="play-audio" href="#"></a>
                        <div class="contenu-media">
                        <h3><a href="#">{attribute_view_gui attribute=$elt.data_map.titre_audio}</a></h3>
                        <span class="puce-gris">Reportage audio - durée 30s</span>
                    </div>
                    <div class="clear-tout"></div>
                 </div>
					{elseif eq($elt.class_identifier,'smp_circuit_externe')}
					<div class="media">
                        <div class="media-video">
                            <a href="#" class="video"></a>
                            <a class="play-video" href="#"></a>
                        </div>
                        <div class="contenu-media">
                        <h3><a href="#">{attribute_view_gui attribute=$elt.data_map.titre_video}</a></h3>
                        <span class="puce-gris">Video - durée 30s</span>
                    </div>
                    <div class="clear-tout"></div>
                 </div>
					{elseif eq($elt.class_identifier,'smp_video_interne')}
					<div class="media">
                        <div class="media-video">
                            <a href="#" class="video"><img src={"images/min.jpg"|ezdesign} /></a>
                            <a class="play-video" href="#"></a>
                        </div>
                        <div class="contenu-media">
                        <h3><a href="#">{attribute_view_gui attribute=$elt.data_map.titre_video}</a></h3>
                        <span class="puce-gris">Video - durée 30s</span>
                    </div>
                    <div class="clear-tout"></div>
                 </div>
					{/if}
				{/if}
		 {/foreach}
         </div>
            <div class="clear-tout"></div>
     </div>
     {/if}
     {if $node.data_map.plus_informations.has_content}
     <div class="plus-info">
                <div class="accroche-plus-info">
                <p class="afficher-bloc-info"><a href="#" class="affichage-bloc voir-info"><span class="bold">{attribute_view_gui attribute=$node.data_map.titre_onglet_plus_infos}</span>{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_plus_infos_ferme}</a></p>
                <p class="masquer-bloc-info"><a href="#" class="affichage-bloc masquer-info"><span class="bold">{attribute_view_gui attribute=$node.data_map.titre_onglet_plus_infos}</span><span class="affichage-bloc puce-gris">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_plus_infos_ouvert}</span></a></p>                
                <a href="#" class="lien-arrondi lien-plus-info voir-info"></a>
                <a href="#" class="lien-arrondi lien-plus-info-ouvert masquer-info"></a>
                </div>
                <div class="plus-info-detail">
                	{attribute_view_gui attribute=$node.data_map.plus_informations}
                </div>
      </div>
            {/if}
</div>
<div class="bloc-carte-google">
	<p style="padding-left: 16px; padding-top: 16px;" class="afficher-bloc">
		<a href="#" class="affichage-bloc bold afficher-map">{attribute_view_gui attribute=$node.data_map.titre_onglet_carte}</a> 
		<a href="#" class="affichage-bloc afficher-map">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_carte_ferme}</a>
	</p>
	<p style="padding-left: 16px; padding-top: 16px;" class="masquer-bloc">
		<a href="#" class="affichage-bloc bold masquer-map">{attribute_view_gui attribute=$node.data_map.titre_onglet_carte}</a>
		<a href="#" class="affichage-bloc puce-gris masquer-map">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_carte_ouvert}</a>
	</p>
	<a href="#" class="lien-arrondi google-map-actif-circuit masquer-map"></a>
	<a href="#" class="lien-arrondi google-map-ferme-circuit afficher-map"></a>
	<div class="clear-tout"></div>
</div>
<div id="map_canvas" style="width: 100%; z-index: 5555; border-top: 1px solid #D1CCC8;"></div>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
{undef $elemnts $etat $media_principal}
