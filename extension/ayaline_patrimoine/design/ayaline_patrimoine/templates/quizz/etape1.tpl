<div class="contenu quizz-question">
    {if and(is_set($erreurs),$erreurs|ne(false()), $erreurs|count|ne(0))}
        <div class="messages-erreurs">
            <div class="container">
                <ul>
                    {foreach $erreurs as $key=>$erreur}
                        <li>{$erreur|wash}</li>
                    {/foreach}
                </ul>
            </div> 
        </div>
    {/if}
    <div class="background-quizz question-reponse">
        <img src="{'images/quizz-logo.png'|ezdesign('no')}" class="float-droite"/>
        <div class="clear-tout"></div>
        <div class="question">
            <p class="onlineeditor">
                {attribute_view_gui attribute=$quizz_node.data_map.question}
            </p>
        </div>
        <ul class="reponses">
            <li class="float-gauche">
                <p class="aligne-centre">
                    <span class="lien-arrondi reponse1"></span>
                    <span class="lien-arrondi reponse1-selectionne"></span>
                </p>
                {attribute_view_gui attribute=$quizz_node.data_map.reponse_1}
            </li>
            <li class="float-droite">
                <p class="aligne-centre">
                    <span class="lien-arrondi reponse2"></span>
                    <span class="lien-arrondi reponse2-selectionne"></span>
                </p>
                <p>{attribute_view_gui attribute=$quizz_node.data_map.reponse_2}</p>
            </li>
        </ul>
        <input type="hidden" value="" name="reponse" />
        <div class="clear-tout"></div>
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

    <form data-ajax="false" id="form-quiz-question" method="post" action="{concat('quizz/etape2/')|ezurl('no')}">
        <input id="quiz-question-reponse" type="hidden" name="reponse" value=""/>
    </form>
</div>

<script>
    {literal}
        $(".contenu.quizz-question .question-reponse ul.reponses .reponse1").click(function(){
        $('#quiz-question-reponse').val('1');
        $(".question-reponse .reponses li .reponse1").css("display","none");
        $(".question-reponse .reponses li .reponse1-selectionne").css("display","block");
        $(".question-reponse .reponses li .reponse2-selectionne").css("display","none");
        $(".question-reponse .reponses li .reponse2").css("display","block");
        $(".question-reponse .reponses li .reponse2-selectionne").css("display","none");
     });
     $(".contenu.quizz-question .question-reponse ul.reponses .reponse2").click(function(){
        $('#quiz-question-reponse').val('2');
         $(".question-reponse .reponses li .reponse2").css("display","none");
        $(".question-reponse .reponses li .reponse2-selectionne").css("display","block");

         $(".question-reponse .reponses li .reponse1").css("display","block");
        $(".question-reponse .reponses li .reponse1-selectionne").css("display","none");
     });

     $(".contenu.quizz-question .question-reponse ul.reponses .reponse1-selectionne").click(function(){
        $('#quiz-question-reponse').val('');
        $(".question-reponse .reponses li .reponse1").css("display","block");
        $(".question-reponse .reponses li .reponse1-selectionne").css("display","none");
     });
     $(".contenu.quizz-question .question-reponse ul.reponses .reponse2-selectionne").click(function(){
        $('#quiz-question-reponse').val('');
        $(".question-reponse .reponses li .reponse2").css("display","block");
        $(".question-reponse .reponses li .reponse2-selectionne").css("display","none");
     });
    {/literal}
</script>