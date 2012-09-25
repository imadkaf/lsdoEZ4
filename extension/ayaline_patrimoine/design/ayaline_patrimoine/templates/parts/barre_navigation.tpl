{*$cNode.data_map.plus_informations.has_content|attribute(show)*}
<div class="pieds-page">
	<span class="border_entre_circuits"></span>
	{def $media_interne=false}
	{if or(eq($cNode.class_identifier,'smp_audio'), eq($cNode.class_identifier,'smp_video_interne'))}
		{set $media_iterne = true}
		<div class="jp-gui jp-interface">
	{/if}
				{if $module_result.uri|eq('/content/search')}
				<ul style="width: 62px;">
				{else}
                <ul {if and(eq($cNode.class_identifier,'smp_point_interet'),eq($cNode.data_map.media_principal.content.class_identifier,'smp_diaporama'))}class="normal"{/if}{if $media_interne|eq(true())}class="jp-controls" id="jp_container_2"{/if}>
                {/if}

                {if $module_result.ui_component|eq('quizz')}
                    {def $node_quizz=fetch('content','node',hash('node_id',$module_result.node_id))}
                    {if $module_result.uri|contains('etape1')}
                        <li><a href="{concat($node_quizz.parent.url_alias)|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    {elseif $module_result.uri|contains('etape2')}
                        <li><a href="{concat('quizz/etape1/',$node_quizz.node_id)|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    {elseif $module_result.uri|contains('etape3')}
                        <li><a href="{concat($node_quizz.parent.url_alias)|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    {/if}

                <li>
                    {if $module_result.uri|contains('etape1')}
                        <input id="submit-form-quiz-question" type="button" rel="external" name="ok" value="" class="submit-form-quiz-question lien-arrondi ok-pieds-page"/>
                        <script>
                            {literal}
                                $(".submit-form-quiz-question").click(function(){
                                    $("#form-quiz-question").submit();
                                });
                            {/literal}
                        </script>

                    {elseif $module_result.uri|contains('etape2')}
                        <input id="submit-form-quiz-infos" type="button" rel="external" name="ok" value="" class="submit-form-quiz-infos lien-arrondi ok-pieds-page"/>
                        <script>
                            {literal}
                                $(".submit-form-quiz-infos").click(function(){
                                    $("#form-quizz-infos").submit();
                                });
                            {/literal}
                        </script>
                    {elseif $module_result.uri|contains('etape3')}

                    {/if}
                {undef $node_quizz}
                </li>
                {elseif eq($cNode.class_identifier,'smp_liste_circuits')}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    <li><a href="#" class="lien-arrondi google-maps-actif-pieds-page masquer-map"></a></li>
                    <li><a href="#" class="lien-arrondi google-maps-desactif-pieds-page afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi supp-itiniraire" style="display:none;"></a></li>
                {elseif eq($cNode.class_identifier,'smp_circuit')}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                    <li><a href="#" class="lien-arrondi google-map-actif-circuit-pieds-page masquer-map"></a></li>
                    <li><a href="#" class="lien-arrondi google-map-ferme-circuit-pieds-page afficher-map"></a></li>
                    <li><a href="#" class="lien-arrondi itiniraire-circuit" style="display:none;"></a></li>
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
                    <li><a href="#" class="lien-arrondi-br-nv itiniraire-circuit" style="display:none;"></a></li>

					{if and(gt($elemnts|count,1),$etat)}
	                    <li><a href="#" class="lien-arrondi plus-image-pieds-page voir-image"></a></li>
	                    <li><a href="#" class="lien-arrondi plus-image-ouvert-pieds-page masquer-image"></a></li>
                    {/if}

                    {if $cNode.data_map.plus_informations.has_content}
	                    <li><a href="#" class="lien-arrondi plus-info-pictos-pieds-page voir-info"></a></li>
	                    <li><a href="#" class="lien-arrondi lien-plus-info-ouvert-pieds-page masquer-info"></a></li>
                    {/if}
                    {if is_mobile()}
                        {def $node_quiz = fetch('content','tree',hash(  'parent_node_id',$cNode.node_id,
                                                            'class_filter_type','include',
                                                            'class_filter_array',array('smp_quizz'),
                                                            'limit',1
                        ))}
                        {if $node_quiz|count|ne(0)}
                            {set $node_quiz = $node_quiz[0]}
                            <li><a href="{concat('quizz/etape1/',$node_quiz.node_id)|ezurl('no')}" class="lien-arrondi quizz-pictos-pieds-page" rel="external"></a></li>
                        {/if}

                        {undef $node_quiz}
                    {/if}
                {elseif eq($cNode.class_identifier,'smp_contenu_libre')}
                		<li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour" rel='external'></a></li>
                {elseif or(eq($cNode.class_identifier,'smp_audio'), eq($cNode.class_identifier,'smp_video_interne'))}
					<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
					<li class="pause"><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
					<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
                	<li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour fermer-video" rel='external'></a></li>
				{elseif eq($cNode.class_identifier,'smp_circuit_externe')}
					<li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour fermer-video" rel='external'></a></li>
                {elseif eq($cNode.class_identifier,'smp_diaporama')}
                    <li><a href="{$cNode.parent.url_alias|ezurl('no')}" class="lien-arrondi retour fermer-video" rel='external'></a></li>
                {else}
                <li><a href="/" class="lien-arrondi retour" rel='external'></a></li>
                {/if}
                    <span class="clear-tout"></span>
                </ul>
        {if $media_interne|eq(true())}</div>{/if}
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