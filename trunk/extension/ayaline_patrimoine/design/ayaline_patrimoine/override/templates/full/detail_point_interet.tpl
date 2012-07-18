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
<script>
    {concat("var listeCircuits = new Array();")}
        {def $circuit = $node.parent}

            {* Liste Points d'intérêts Mise en avant *}
            {def $rListPtInteretsMA = $circuit.data_map.liste_poiunts_interets_mis_avant.content.relation_list}
            {def $listePtInteretsMA = array()}
            {concat("var listePointsInteretsMA = new Array();")}
            {if $rListPtInteretsMA|count|gt(0)}
                {foreach $rListPtInteretsMA as $ptInteretMA}
                    {def $nodePtInteretMA = fetch('content','node',hash('node_id',$ptInteretMA.node_id))}
                    {set $listePtInteretsMA = $listePtInteretsMA|append($nodePtInteretMA)}

                    {concat("var pointInteretMAInfos = new Array();")}
                    {concat("pointInteretMAInfos['name'] = '",$nodePtInteretMA.name|trim|wash|explode("'")|implode("\\'"),"';")}
                    {concat("pointInteretMAInfos['visuel'] = '",$nodePtInteretMA.data_map.visuel_normal.content.original.url|ezroot('no'),"';")}
                    {concat("pointInteretMAInfos['picto'] = '",$circuit.data_map.pictogramme_point_interet_mis_avant_carte_gmap.content.original.url|ezroot('no'),"';")}
                    {concat("pointInteretMAInfos['lat'] = '",$nodePtInteretMA.data_map.coord_geolocalisation.content.latitude,"';")}
                    {concat("pointInteretMAInfos['lng'] = '",$nodePtInteretMA.data_map.coord_geolocalisation.content.longitude,"';")}
                    {concat("listePointsInteretsMA[listePointsInteretsMA.length] = pointInteretMAInfos;")}
                    {undef $nodePtInteretMA}
                {/foreach}


            {/if}

            {* Liste Points d'intérêts normaux *}
            {def $listePtInterets = fetch('content','tree',hash('parent_node_id',$circuit.node_id,'class_filter_type','include','class_filter_array',array('smp_point_interet')))}
            {concat("var listePointsInterets = new Array();")}
            {if $listePtInterets|count|gt(0)}

                {foreach $listePtInterets as $ptInteret}

                    {def $isPtMA =false()}
                    {foreach $listePtInteretsMA as $ptIntMA}
                        {if $ptIntMA.node_id|eq($ptInteret.node_id)}
                            {set $isPtMA =true()}    
                            {break}
                        {/if}
                    {/foreach}

                    {if $isPtMA|not}
                        {concat("var pointInteretInfos = new Array();")}
                        {concat("pointInteretInfos['name'] = '",$ptInteret.name|trim|wash|explode("'")|implode("\\'"),"';")}
                        {concat("pointInteretInfos['visuel'] = '",$ptInteret.data_map.visuel_normal.content.original.url|ezroot('no'),"';")}
                        {concat("pointInteretInfos['picto'] = '",$circuit.data_map.pictogramme_point_interet_normal_carte_gmap.content.original.url|ezroot('no'),"';")}
                        {concat("pointInteretInfos['lat'] = '",$ptInteret.data_map.coord_geolocalisation.content.latitude,"';")}
                        {concat("pointInteretInfos['lng'] = '",$ptInteret.data_map.coord_geolocalisation.content.longitude,"';")}
                        {concat("listePointsInterets[listePointsInterets.length] = pointInteretInfos;")}
                    {/if}
                    {undef $isPtMA}

                {/foreach}

            {/if}

            {concat("var circuitInfos = new Array();")}
            {concat("circuitInfos['name'] = '",$circuit.name|trim|wash|explode("'")|implode("\\'"),"';")}
            {concat("circuitInfos['visuel'] = '",$circuit.data_map.visuel_normal.content.original.url|ezroot('no'),"';")}
            {if $circuit.data_map.code_trace_gmap.has_content}
                {concat("var traceCoords = new Array();")}
                {def $traceArrayCoord = $circuit.data_map.code_trace_gmap.data_text|trim|wash|explode("\n")}
                {foreach $traceArrayCoord as $traceCoord}
                    {if $traceCoord|explode(",")|count|gt(1)}
                        {concat("traceCoords[traceCoords.length] = new google.maps.LatLng(",$traceCoord|explode(",")[0],",",$traceCoord|explode(",")[1]|trim|wash,") ;")}
                    {/if}
                {/foreach}
                {undef $traceArrayCoord}
            {/if}

            {concat("circuitInfos['traceCoords'] = traceCoords;")}
            {concat("circuitInfos['couleurTrace'] = '",$circuit.data_map.code_couleur_trace_gmap.data_text|trim|wash,"';")}
            {concat("circuitInfos['listePointsInterets'] = listePointsInterets;")}
            {concat("circuitInfos['listePointsInteretsMA'] = listePointsInteretsMA;")}
            {concat("listeCircuits[listeCircuits.length] = circuitInfos;")}
            {undef $listePtInterets $listePtInteretsMA $rListPtInteretsMA}
        {undef $circuit}
        console.log(listeCircuits);
        {literal}
            var carte;
            var destinationPtInteret;
            var maPosition = false;
            var pointArrivee = false;
            var directionsDisplay;
            var directionsService = new google.maps.DirectionsService();
            var ListMarkersPtInterets = new Array();

            function initializeMap(){

                var myLatLng = new google.maps.LatLng(46.497398,-1.797536);
                var myOptions = {
                  zoom: 16,
                  center: myLatLng,
                  mapTypeId: google.maps.MapTypeId.ROADMAP
                }

                carte = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                directionsDisplay = new google.maps.DirectionsRenderer({
                    map: carte,
                    suppressMarkers: true,
                    polylineOptions: {strokeColor:'#0167C8'}
                })

                
                for(var i in listeCircuits){
                    afficheTraceCircuits(listeCircuits[i]['traceCoords'],'#'+listeCircuits[i]['couleurTrace']);
                    for(var j in listeCircuits[i]['listePointsInterets']){
                        afficherPointInteret(listeCircuits[i]['listePointsInterets'][j]);
                    }
                    for(var k in listeCircuits[i]['listePointsInteretsMA']){
                        afficherPointInteret(listeCircuits[i]['listePointsInteretsMA'][k]);
                    }
                }


                // adapter le zoom et la position du centre de la carte gmap
                var latlngbounds = new google.maps.LatLngBounds( );
                for( var i in listeCircuits){
                    for( var j in listeCircuits[i]['traceCoords']){
                        latlngbounds.extend( listeCircuits[i]['traceCoords'][j] );
                    }
                }
                carte.fitBounds(latlngbounds);
                if (navigator.geolocation){
                  var watchId = navigator.geolocation.watchPosition(successCallbackMaPosition,null,{enableHighAccuracy:false});  
                }else{
                  alert("Votre navigateur ne prend pas en compte la géolocalisation HTML5");
                }
                pointArrivee = new google.maps.Marker({
                      position: new google.maps.LatLng(carte.getCenter()),
                      map: carte,
                      title: "Point d'arrivée",
                      icon: '/extension/ayaline_patrimoine/design/ayaline_patrimoine/images/picto-arrivee.png'
                });
                pointArrivee.setMap(null);//ne pas afficher le picto du point d'arrivée
                
            }
            function afficheTraceCircuits(parcoursCoords,couleurTracer){
                    var parcoursTrace = new google.maps.Polyline({
                            path: parcoursCoords,//chemin du tracé
                            strokeColor: couleurTracer,//couleur du tracé
                            strokeOpacity: 0.6,//opacité du tracé
                            strokeWeight: 3//grosseur du tracé
                    });
                    parcoursTrace.setMap(carte);
            }
            function afficherPointInteret(ptInteret){
                    var iMrk = ListMarkersPtInterets.length;
                    ListMarkersPtInterets[iMrk] = new google.maps.Marker({
                      position: new google.maps.LatLng(ptInteret['lat'],ptInteret['lng']),
                      map: carte,
                      title: ptInteret['name'],
                      icon: ptInteret['picto']
                    });
                    var infoWinContentStr ='<div class="info-window-gmap">';
                    infoWinContentStr +='<div class="visuel">'+'<img src="'+ptInteret['visuel']+'">'+'</div>';
                    infoWinContentStr +='<div class="titre">'+ptInteret['name']+'</div>';
                    infoWinContentStr +='<a href="Javascript:tracerItineraireMaposition(ListMarkersPtInterets['+iMrk+']);" class="tracer-itineraire">itinéraire</a>';
                    infoWinContentStr +='<div class="clear-tout"></div>';
                    infoWinContentStr +='</div>';
                    var infowindow = new google.maps.InfoWindow({
                        content: infoWinContentStr
                    });
                    ListMarkersPtInterets[iMrk]._infowindow = infowindow;
                    google.maps.event.addListener(ListMarkersPtInterets[iMrk], 'click', function() {
                        for(var i in ListMarkersPtInterets){
                            ListMarkersPtInterets[i]._infowindow.close();
                        }

                        infowindow.open(carte,ListMarkersPtInterets[iMrk]);
                    });
            }
            function tracerItineraireMaposition(mrkPtInteret){
                destinationPtInteret = mrkPtInteret;
                if(maPosition){
                    var request = {
                        origin: maPosition.getPosition(),
                        destination: destinationPtInteret.getPosition(),
                        travelMode: google.maps.DirectionsTravelMode.DRIVING
                    };
                    directionsService.route(request, function(response, status) {
                        if (status == google.maps.DirectionsStatus.OK) {
                            directionsDisplay.setDirections(response);
                            directionsDisplay.setMap(carte);
                            maPosition.setMap(carte);
                            pointArrivee.setPosition(destinationPtInteret.getPosition());
                            pointArrivee.setTitle("Point d'arrivée : "+destinationPtInteret.getTitle());
                            pointArrivee.setMap(carte);
                            $(".itiniraire-circuit").removeClass("cache").show().css("display","block");
                        } else {
                            alert("Google directions response : "+status);
                        }
                    });
                }
            }
            function successCallbackMaPosition(position){
                maPosition = new google.maps.Marker({
                      position: new google.maps.LatLng(position.coords.latitude,position.coords.longitude),
                      map: carte,
                      title: 'ma position actuel',
                      icon: '/extension/ayaline_patrimoine/design/ayaline_patrimoine/images/pieton-map.png'
                    });
            }
            function cacherItineraireMaposition(){
                directionsDisplay.setMap(null);
                maPosition.setMap(null);
                pointArrivee.setMap(null);
            }
        {/literal}
    
 </script>
{undef $elemnts $etat $media_principal}
