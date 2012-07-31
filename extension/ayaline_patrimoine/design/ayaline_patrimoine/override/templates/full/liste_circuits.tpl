{*Page affiche la liste des circuits*}
{def $listeCircuits = false()}
{set $listeCircuits=fetch('content','list',hash('parent_node_id',$node.node_id,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_circuit')
 ))}

<div class="contenu">
		<div class="accroche">
			<h1><p>{$node.data_map.title_accroche.value}</p></h1>
			{attribute_view_gui attribute=$node.data_map.accroche}
		</div>
		{if gt($listeCircuits|count,0)}
			{def $elt_circuit = false()}

			{foreach $listeCircuits as $circuit}
				{if $circuit.data_map.mise_avant_liste_circuits.value|eq(1)}
				<section class="liste-circuits-mise-en-avant">
					{node_view_gui content_node=$circuit view='line' simple=false()}
				</section>
				{/if}
			{/foreach}

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
		<p style="padding-left: 16px; padding-top: 16px;"
			class="afficher-bloc">
			<a href="#" class="affichage-bloc bold afficher-map">{attribute_view_gui attribute=$node.data_map.titre_onglet_carte}</a>
			<a href="#" class="affichage-bloc afficher-map">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_ferme}</a>
		</p>
		<p style="padding-left: 16px; padding-top: 16px;" class="masquer-bloc">
			<a href="#" class="affichage-bloc bold masquer-map">{attribute_view_gui attribute=$node.data_map.titre_onglet_carte}</a>
			<a href="#" class="affichage-bloc masquer-map puce-gris">{attribute_view_gui attribute=$node.data_map.sous_titre_onglet_ouvert}</a>
		</p>
		<a href="#" class="lien-arrondi google-maps-actif masquer-map"></a> <a
			href="#" class="lien-arrondi google-maps-desactif afficher-map"></a>
		<div class="clear-tout"></div>
	</div>
	<div id="map_canvas" style="width: 100%; z-index: 5555;"></div>

            {set-block variable="scriptInitGmap"}
                {concat("var listeCircuits = new Array();")}
                {if $listeCircuits|count|gt(0)}
                    {foreach $listeCircuits as $keyCircuit=>$circuit}

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
                                {concat("pointInteretMAInfos['visuel'] = '",$nodePtInteretMA.data_map.visuel_normal.content.imageInfowinGmap.url|ezroot('no'),"';")}
                                {concat("pointInteretMAInfos['picto'] = '",$circuit.data_map.declinaison_circuit.content.current.data_map.pictogramme_point_interet_mis_avant_carte_gmap.content.original.url|ezroot('no'),"';")}
                                {concat("pointInteretMAInfos['lat'] = '",$nodePtInteretMA.data_map.coord_geolocalisation.content.latitude,"';")}
                                {concat("pointInteretMAInfos['lng'] = '",$nodePtInteretMA.data_map.coord_geolocalisation.content.longitude,"';")}
                                {concat("listePointsInteretsMA[listePointsInteretsMA.length] = pointInteretMAInfos;")}
                                {undef $nodePtInteretMA}
                            {/foreach}


                        {/if}

                        {* Liste Points d'intérêts normaux *}
                        {def $listePtInterets = fetch('content','tree',hash('parent_node_id',$circuit.node_id,
                                                                'class_filter_type','include',
                                                                'class_filter_array',array('smp_point_interet'),
                                                                'main_node_only', true()
                        ))}
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
                                    {concat("pointInteretInfos['visuel'] = '",$ptInteret.data_map.visuel_normal.content.imageInfowinGmap.url|ezroot('no'),"';")}
                                    {concat("pointInteretInfos['picto'] = '",$circuit.data_map.declinaison_circuit.content.current.data_map.pictogramme_point_interet_normal_carte_gmap.content.original.url|ezroot('no'),"';")}
                                    {concat("pointInteretInfos['lat'] = '",$ptInteret.data_map.coord_geolocalisation.content.latitude,"';")}
                                    {concat("pointInteretInfos['lng'] = '",$ptInteret.data_map.coord_geolocalisation.content.longitude,"';")}
                                    {concat("listePointsInterets[listePointsInterets.length] = pointInteretInfos;")}
                                {/if}
                                {undef $isPtMA}

                            {/foreach}

                        {/if}

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
                    {/foreach}
                {/if}
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
                            var couleurCircuit = listeCircuits[i]['couleurTrace'];
                            afficheTraceCircuits(listeCircuits[i]['traceCoords'],couleurCircuit);
                            for(var j in listeCircuits[i]['listePointsInterets']){
                                afficherPointInteret(listeCircuits[i]['listePointsInterets'][j],couleurCircuit);
                            }
                            for(var k in listeCircuits[i]['listePointsInteretsMA']){
                                afficherPointInteret(listeCircuits[i]['listePointsInteretsMA'][k],couleurCircuit);
                            }
                        }

                        // adapter le zoom et la position du centre de la carte gmap
                        /*
                        var latlngbounds = new google.maps.LatLngBounds( );
                        for( var i in listeCircuits){
                            for( var j in listeCircuits[i]['traceCoords']){
                                latlngbounds.extend( listeCircuits[i]['traceCoords'][j] );
                            }
                        }
                        carte.fitBounds(latlngbounds);
                            */
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
                        //map set center
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
                    function afficherPointInteret(ptInteret,couleurTrace){
                            var iMrk = ListMarkersPtInterets.length;
                            ListMarkersPtInterets[iMrk] = new google.maps.Marker({
                              position: new google.maps.LatLng(ptInteret['lat'],ptInteret['lng']),
                              map: carte,
                              title: ptInteret['name'],
                              icon: ptInteret['picto']
                            });
                            var infoWinContentStr ='<div class="info-window-gmap">';
                            infoWinContentStr +='<div class="visuel" style="background-color: '+couleurTrace+'">'+'<img src="'+ptInteret['visuel']+'">'+'</div>';
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
                                    $(".supp-itiniraire").removeClass("cache").show().css("display","block");
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
                        //maPosition.setMap(null);
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


	{if $node.data_map.texte_libre.has_content}
		<div class="bloc-carte-google texte-libre" style="padding-left: 10px; padding-top: 11px;padding-bottom: 11px;padding-right: 10px;">
			{attribute_view_gui attribute=$node.data_map.texte_libre}
		</div>
	{/if}

