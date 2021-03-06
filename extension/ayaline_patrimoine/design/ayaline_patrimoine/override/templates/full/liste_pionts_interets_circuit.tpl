{*Page affiche la liste points d'intérêts*}
{def $listePointsInterets = false()}
{def $listePointsInteretsMisEnAvant = array()}

{set $listePointsInterets = fetch('content','list',hash('parent_node_id',$node.node_id,
												'sort_by', $node.sort_array,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_point_interet')
 ))}

{* Parcours courant *}
{def $parcoursNodeId = $node.node_id}

{* Récupération des noeuds des points d'intérêts à mettre en avant *}
{foreach $node.data_map.liste_poiunts_interets_mis_avant.content.relation_list as $objectMisEnAvant}
	{* Récupération du noeud principal du PI à mettre en avant *}
	{def $mainNodeMisEnAvant = fetch('content','object',hash('object_id',$objectMisEnAvant.contentobject_id))}
	{foreach $mainNodeMisEnAvant.assigned_nodes as $assignedNode}
		{* Récupération du noeud du PI lié au circuit courant (qui n'est pas forcément le noeud principal) *}
		{if $assignedNode.parent_node_id|eq($parcoursNodeId)}
			{set $listePointsInteretsMisEnAvant = $listePointsInteretsMisEnAvant|append($assignedNode.node_id)}
		{/if}
	{/foreach}
	{undef $mainNodeMisEnAvant}
{/foreach}

<div class="contenu">
	<div class="accroche">
		<h1 class="titre_circuit">
			<p>
				{supp_br($node.data_map.titre_circuit.value)}
			</p>
		</h1>
		{attribute_view_gui attribute=$node.data_map.description}
	</div>
	<div class="liste-interets">
	{if gt($listePointsInterets|count,0)}
		{foreach $listePointsInterets as $PointInteret}
			{if $listePointsInteretsMisEnAvant|contains($PointInteret.node_id)}
				{node_view_gui content_node=$PointInteret view='line' simple=false() declinaison=$node.data_map.declinaison_circuit.content.current}
			{else}
				{node_view_gui content_node=$PointInteret view='line' simple=true() declinaison=$node.data_map.declinaison_circuit.content.current}
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

                <a href="#" class="masquer-map lien-arrondi google-map-actif-circuit"></a>
                <a href="#" class="lien-arrondi google-map-ferme-circuit afficher-map"></a>
                <div class="clear-tout"></div>
 </div>
 <div id="carteGoogleMap"><div id="map_canvas"></div></div>

 {set-block variable="scriptInitGmap"}
    {concat("var listeCircuits = new Array();")}
        {def $circuit = $node}
            {* Liste Points d'intérêts Mise en avant *}
            {def $rListPtInteretsMA = $circuit.data_map.liste_poiunts_interets_mis_avant.content.relation_list}
            {def $listePtInteretsMA = array()}
            {concat("var listePointsInteretsMA = new Array();")}
			
			{foreach $rListPtInteretsMA as $objectMisEnAvant}
				{* Récupération du noeud principal du PI à mettre en avant *}
				{def $mainNodeMisEnAvant = fetch('content','object',hash('object_id',$objectMisEnAvant.contentobject_id))}
				{foreach $mainNodeMisEnAvant.assigned_nodes as $assignedNode}
					{* Récupération du noeud du PI lié au circuit courant (qui n'est pas forcément le noeud principal) *}
					{if $assignedNode.parent_node_id|eq($parcoursNodeId)}
						{def $nodePtInteretMA = fetch('content','node',hash('node_id',$assignedNode.node_id))}
						{set $listePtInteretsMA = $listePtInteretsMA|append($nodePtInteretMA)}
					{/if}
				{/foreach}
				{undef $mainNodeMisEnAvant}
				
				{concat("var pointInteretMAInfos = new Array();")}
				{concat("pointInteretMAInfos['name'] = '",supp_br($nodePtInteretMA.data_map.titre_point_interet.value)|explode("'")|implode("\\'"),"';")}
				{concat("pointInteretMAInfos['link'] = '",$nodePtInteretMA.url_alias|ezurl,"';")}
				{concat("pointInteretMAInfos['visuel'] = '",$nodePtInteretMA.data_map.visuel_normal.content.imageInfowinGmap.url|ezroot('no'),"';")}
				{concat("pointInteretMAInfos['picto'] = '",$circuit.data_map.declinaison_circuit.content.current.data_map.pictogramme_point_interet_mis_avant_carte_gmap.content.original.url|ezroot('no'),"';")}
				{concat("pointInteretMAInfos['lat'] = '",$nodePtInteretMA.data_map.coord_geolocalisation.content.latitude,"';")}
				{concat("pointInteretMAInfos['lng'] = '",$nodePtInteretMA.data_map.coord_geolocalisation.content.longitude,"';")}
				{concat("listePointsInteretsMA[listePointsInteretsMA.length] = pointInteretMAInfos;")}
				{undef $nodePtInteretMA}
			{/foreach}

            {* Liste Points d'intérêts normaux *}
            {def $listePtInterets = fetch('content','tree',hash('parent_node_id',$circuit.node_id,'class_filter_type','include','class_filter_array',array('smp_point_interet')))}
            {concat("var listePointsInterets = new Array();")}
			
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
					{concat("pointInteretInfos['name'] = '",supp_br($ptInteret.data_map.titre_point_interet.value)|explode("'")|implode("\\'"),"';")}
					{concat("pointInteretInfos['link'] = '",$ptInteret.url_alias|ezurl,"';")}
					{concat("pointInteretInfos['visuel'] = '",$ptInteret.data_map.visuel_normal.content.imageInfowinGmap.url|ezroot('no'),"';")}
					{concat("pointInteretInfos['picto'] = '",$circuit.data_map.declinaison_circuit.content.current.data_map.pictogramme_point_interet_normal_carte_gmap.content.original.url|ezroot('no'),"';")}
					{concat("pointInteretInfos['lat'] = '",$ptInteret.data_map.coord_geolocalisation.content.latitude,"';")}
					{concat("pointInteretInfos['lng'] = '",$ptInteret.data_map.coord_geolocalisation.content.longitude,"';")}
					{concat("listePointsInterets[listePointsInterets.length] = pointInteretInfos;")}
				{/if}
				{undef $isPtMA}

			{/foreach}
				
            {concat("var circuitInfos = new Array();")}
            {concat("circuitInfos['name'] = '",$circuit.name|trim|wash|explode("'")|implode("\\'"),"';")}
            {concat("circuitInfos['visuel'] = '",$circuit.data_map.visuel_normal.content.imageInfowinGmap.url|ezroot('no'),"';")}
            {if $circuit.data_map.code_trace_gmap.has_content}
                {concat("var traceCoords = new Array();")}
                {def $traceArrayCoord = $circuit.data_map.code_trace_gmap.data_text|trim|wash|explode("\n")}
                {foreach $traceArrayCoord as $traceCoord}
                    {if $traceCoord|explode(",")|count|gt(1)}
                        {concat("traceCoords[traceCoords.length] = new google.maps.LatLng(",$traceCoord|explode(",")[1],",",$traceCoord|explode(",")[0]|trim|wash,") ;")}
                    {/if}
                {/foreach}
                {undef $traceArrayCoord}
            {/if}

            {concat("circuitInfos['traceCoords'] = traceCoords;")}
            {concat("circuitInfos['couleurTrace'] = '",$circuit.data_map.declinaison_circuit.content.current.data_map.code_html_couleur.value|trim|wash,"';")}
            {concat("circuitInfos['listePointsInterets'] = listePointsInterets;")}
            {concat("circuitInfos['listePointsInteretsMA'] = listePointsInteretsMA;")}
            {concat("listeCircuits[listeCircuits.length] = circuitInfos;")}
            {undef $listePtInterets $listePtInteretsMA $rListPtInteretsMA}
        {undef $circuit}
        {/set-block}
                <script>
                {literal}

                    var carte;
                    var destinationPtInteret;
                    var maPosition = false;
                    var pointArrivee = false;
                    var directionsDisplay;
                    var directionsService;
                    var ListMarkersPtInterets = new Array();

                    function initializeMap(){
                     {/literal}
                         {$scriptInitGmap}
                     {literal}
                         directionsService = new google.maps.DirectionsService();

                var myLatLng = new google.maps.LatLng(46.49177448218621,-1.775665283203125 );
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
                    afficheTraceCircuits(listeCircuits[i]['traceCoords'],listeCircuits[i]['couleurTrace']);
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
                carte.setCenter(new google.maps.LatLng(46.49177448218621,-1.775665283203125 ));
            }
            function afficheTraceCircuits(parcoursCoords,couleurTracer){
                    var parcoursTrace = new google.maps.Polyline({
                            path: parcoursCoords,//chemin du tracé
                            strokeColor: couleurTracer,//couleur du tracé
                            strokeOpacity: 0.6,//opacité du tracé
                            strokeWeight: 5//grosseur du tracé
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
                    infoWinContentStr +='<a href='+ptInteret['link']+' alt="'+ptInteret['name']+'" rel="external"><div class="visuel">'+'<img src="'+ptInteret['visuel']+'">'+'</div></a>';
                    infoWinContentStr +='<a href='+ptInteret['link']+' alt="'+ptInteret['name']+'" rel="external"><div class="titre">'+ptInteret['name']+'</div></a>';
                    infoWinContentStr +='<a href="Javascript:tracerItineraireMaposition(ListMarkersPtInterets['+iMrk+']);" class="tracer-itineraire">Itinéraire</a>';
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
                            $(".pieds-page ul").css("max-width","186px");
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
                      title: 'Position actuelle',
                      icon: '/extension/ayaline_patrimoine/design/ayaline_patrimoine/images/pieton-map.png'
                    });
            }
            function cacherItineraireMaposition(){
                directionsDisplay.setMap(null);
				maPosition.setMap(null);
                pointArrivee.setMap(null);
            }
            function loadScript() {
                        if(document.getElementById('gmap-script-js') == null){
                            var script = document.createElement('script');
                            script.id = 'gmap-script-js';
                            script.type = 'text/javascript';
                            script.src = 'https://maps.googleapis.com/maps/api/js?sensor=false&' + 'callback=initializeMap';
                            document.body.appendChild(script);
                        }
                    }
        {/literal}

 </script>
{undef $listePointsInteretsMisEnAvant $listePointsInterets}
{undef $parcoursNodeId}