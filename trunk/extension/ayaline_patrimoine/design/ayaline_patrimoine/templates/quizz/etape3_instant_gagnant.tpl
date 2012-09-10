{def $config_generale = fetch('content','tree',hash('parent_node_id',ezini('NodeSettings','RootNode','content.ini'),
                                                    'class_filter_type','include',
                                                    'class_filter_array',array('smp_configuration'),
                                                    'limit',1

))}
{set $config_generale=$config_generale[0]}
<div class="contenu">
    <div class="quizz-resultat">
        <div class="background-quizz-reponse">
            <img src="{'images/quizz-logo.png'|ezdesign('no')}" class="float-droite"/>
            <div class="clear-tout"></div>
            <div class="quizz-reponse">
                <h1>Bonne réponse ! </h1>
                <p class="resultat-question">
                    {attribute_view_gui attribute=$quizz_node.data_map.question}
                </p>
                {if and(is_set($quizz_node.data_map.bonne_reponse.content.0),$quizz_node.data_map.bonne_reponse.content.0|eq(0))}
                <div class="resultat-reponse">
                    <span class="lien-arrondi resultat-reponse1"></span>
                    <p>
                        {attribute_view_gui attribute=$quizz_node.data_map.reponse_1}
                    </p>
                    <div class="clear-tout"></div>
                </div>
                {elseif and(is_set($quizz_node.data_map.bonne_reponse.content.0),$quizz_node.data_map.bonne_reponse.content.0|eq(1))}
                <div class="resultat-reponse">
                    <span class="lien-arrondi resultat-reponse2"></span>
                    <p>
                        {attribute_view_gui attribute=$quizz_node.data_map.reponse_2}
                    </p>
                    <div class="clear-tout"></div>
                </div>
                {/if}
            </div>
        </div>
    </div>
    <div class="bloc-statut-resultat arriere-plan-jaune">
        <p class="statut-resultat"><span class="text-vert">Instant gagnant : </span>Gagné</p>
        <p class="bold font-size-96">Venez vite chercher votre lot à <a href="#" class="texte-vert-souligne">l'office de tourisme</a></p>
    </div>

    {def $list_seggestions=fetch('content', 'related_objects',hash( 'object_id', $config_generale.object.id,
                                                        'attribute_identifier', 'smp_configuration/quiz_suggestions'
    ))}
    {include uri="design:parts/liste_suggestion.tpl" cNode=$quizz_node suggest_list=$list_seggestions}

    {undef $list_seggestions}

</div>
{undef $quizz_node $config_generale}