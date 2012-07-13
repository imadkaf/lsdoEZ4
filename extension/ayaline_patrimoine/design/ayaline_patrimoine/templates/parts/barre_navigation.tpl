{*$cNode|attribute(show)*}
<div class="pieds-page">
                <ul>
                {if eq($cNode.class_identifier,'smp_liste_circuits')}
                    <li><a href="/" class="lien-arrondi retour"></a></li>
                    <li><a href="#" class="lien-arrondi google-maps-actif masquer-map"></a></li>
                    <li><a href="#" class="lien-arrondi google-maps-desactif afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi supp-itiniraire"></a></li>
                {elseif eq($cNode.class_identifier,'smp_circuit')}
                	<li><a href="#" class="retour"></a></li>
                    <li><a href="#" class="lien-arrondi google-map-actif-circuit masquer-map"></a></li>
                    <li><a href="#" class="lien-arrondi google-map-ferme-circuit afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi itiniraire-circuit"></a></li>
                {/if}
                    <span class="clear-tout"></span>
                </ul>
               <div class="clear-tout"></div>
</div>