{*$cNode.data_map.plus_informations.has_content|attribute(show)*}
<div class="pieds-page">
{if or(and(eq($cNode.class_identifier,'smp_point_interet'),eq($cNode.data_map.media_principal.content.class_identifier,'smp_diaporama')), eq($cNode.class_identifier,'smp_circuit'))}
	<span class="border_entre_circuits"></span>
{/if}
                <ul {if and(eq($cNode.class_identifier,'smp_point_interet'),eq($cNode.data_map.media_principal.content.class_identifier,'smp_diaporama'))}class="normal"{/if}>
                {if eq($cNode.class_identifier,'smp_liste_circuits')}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    <li><a href="#" class="lien-arrondi google-maps-actif-pieds-page masquer-map"></a></li>
                    <li><a href="#" class="lien-arrondi google-maps-desactif-pieds-page afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi supp-itiniraire"></a></li>
                {elseif eq($cNode.class_identifier,'smp_circuit')}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    <li><a href="#" class="lien-arrondi google-map-actif-circuit-pieds-page masquer-map"></a></li>
                    <li><a href="#" class="lien-arrondi google-map-ferme-circuit-pieds-page afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi itiniraire-circuit"></a></li>
                {elseif eq($cNode.class_identifier,'smp_point_interet')}
                    {def $elemnts = false()}
                    {def $listClassMedia = ezini('List_class_media', 'Class' ,'ayaline_patrimoine.ini')}
					{set $elemnts=fetch('content','list',hash('parent_node_id',$cNode.node_id,
															'class_filter_type','include',
															'class_filter_array', $listClassMedia))}
					{def $etat = false()}
					{foreach $elemnts as $elt}
						{if ne($elt.node_id,$cNode.data_map.media_principal.content.main_node_id)}
							{set $etat = true()}
						{/if}
					{/foreach}

                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    <li><a href="#" class="lien-arrondi-br-nv google-map-actif-circuit-pieds-page masquer-map"></a></li>
                    {if and(gt($elemnts|count,1),$etat)}
                    	<li><a href="#" class="lien-arrondi-br-nv masquer-media ferme-media" style="display: none;"></a></li>
                    {/if}
                    <li><a href="#" class="lien-arrondi google-map-ferme-circuit-pieds-page afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi-br-nv itiniraire-circuit"></a></li>

					{if and(gt($elemnts|count,1),$etat)}
	                    <li><a href="#" class="lien-arrondi plus-image-pieds-page voir-image"></a></li>
	                    <li><a href="#" class="lien-arrondi plus-image-ouvert-pieds-page masquer-image"></a></li>
                    {/if}

                    {if $cNode.data_map.plus_informations.has_content}
	                    <li><a href="#" class="lien-arrondi plus-info-pictos-pieds-page voir-info"></a></li>
	                    <li><a href="#" class="lien-arrondi lien-plus-info-ouvert-pieds-page masquer-info"></a></li>
                    {/if}
                    <li><a href="#" class="lien-arrondi quizz-pictos-pieds-page"></a></li>
                {elseif eq($cNode.class_identifier,'smp_contenu_libre')}
                		<li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                {elseif or(eq($cNode.class_identifier,'smp_circuit_externe'), eq($cNode.class_identifier,'smp_audio'), eq($cNode.class_identifier,'smp_video_interne'))}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                {elseif eq($cNode.class_identifier,'smp_diaporama')}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour fermer-video" rel='external'></a></li>
                {else}
                <li><a href="/" class="lien-arrondi retour" rel='external'></a></li>
                {/if}
                    <span class="clear-tout"></span>
                </ul>
                {*if and(eq($cNode.class_identifier,'smp_point_interet'),eq($cNode.data_map.media_principal.content.class_identifier,'smp_diaporama'))}
	                <ul class="media-diaporama">
		                <li><a id="prev" href="#" class="lien-arrondi diapo-prec"></a></li>
		                <li><a id="togglePause" href="#" class="lien-arrondi diapo-play"></a></li>
		                <li><a id="next" href="#" class="lien-arrondi diapo-suiv"></a></li>
		                <li><a href="#" class="lien-arrondi diapo-ferme"></a></li>
		                <span class="clear-tout"></span>
            		</ul>
                {/if*}
               <div class="clear-tout"></div>
</div>