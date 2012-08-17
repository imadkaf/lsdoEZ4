<div class="contenu">
    <div class="quizz-resultat">
        <div class="background-quizz-reponse">
            <img src="{'images/quizz-logo.png'|ezdesign('no')}" class="float-droite"/>
            <div class="clear-tout"></div>
            <div class="quizz-reponse">
                <h1>Mauvaise réponse ! </h1>
                <p class="resultat-question">
                    {attribute_view_gui attribute=$quizz_node.data_map.question}
                </p>
                <span class="resultat-mauvaise">La bonne réponse était : </span>
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

    {def $list_seggestions=fetch('content','list',hash( 'parent_node_id',$quizz_node.node_id,
                                                        'class_filter_type','include',
                                                        'class_filter_array',array('smp_mise_avant_brute')
    ))}

    {foreach $list_seggestions as $suggestion}
        {if $suggestion.data_map.view.content[0]}
            <div class="instant-gagnant">
                <h2>{$suggestion.name|wash}</h2>
                <a href="#" class="diaporama-gagnat">
                    {attribute_view_gui attribute=$suggestion.data_map.visuel image_class='imageIconeW58'}
                </a>
                <div class="contenu-gagnant">
                    <div class="onlineeditor">
                        {attribute_view_gui attribute=$suggestion.data_map.text}

                        {if $suggestion.data_map.url_cible.has_content}
                            <a href="{$suggestion.data_map.url_cible.content}" class="voir-lots">
                                {if $suggestion.data_map.url_cible.data_text}
                                    {$suggestion.data_map.url_cible.data_text}
                                {else}
                                    {$suggestion.data_map.url_cible.content|wash( xhtml )}
                                {/if}
                            </a>
                        {/if}
                    </div>
                </div>
            </div>
        {else}
            <div class="tirage-au-sort">
                <h2>{$suggestion.name|wash}</h2>
                {attribute_view_gui attribute=$suggestion.data_map.visuel image_class='imageIconeW58'}
                <div class="contenu-tirage-au-sort">
                    <div class="onlineeditor">
                        {attribute_view_gui attribute=$suggestion.data_map.text}
                        {if $suggestion.data_map.url_cible.has_content}
                            <a href="{$suggestion.data_map.url_cible.content}" class="lien-voir-info">
                                {if $suggestion.data_map.url_cible.data_text}
                                    {$suggestion.data_map.url_cible.data_text}
                                {else}
                                    {$suggestion.data_map.url_cible.content|wash( xhtml )}
                                {/if}
                            </a>
                        {/if}
                    </div>
                </div>
            </div>
        {/if}
    {/foreach}

    {undef $list_seggestions}
</div>