{def $config_generale = fetch('content','tree',hash('parent_node_id',ezini('NodeSettings','RootNode','content.ini'),
                                                    'class_filter_type','include',
                                                    'class_filter_array',array('smp_configuration'),
                                                    'limit',1

))}
{set $config_generale=$config_generale[0]}
{*quiz_page_conditions_generales_reglement*}
<div class="contenu form-resp">
    <form data-ajax="false" id="form-quizz-infos" method="post" action="{concat('quizz/etape3/')|ezurl('no')}" class="form-reponse">
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
        <div class="background-quizz">
            <img src="{'images/quizz-logo.png'|ezdesign('no')}" class="float-droite"/>
            <div class="clear-tout"></div>
            <div class="formulaire-reponse">
                <div class="ligne-form obligatoire">
                    <div class="champ-form">
                        <label for="mail">Mail <span class="texte-rouge">*</span></label>
                    </div>
                    <div class="input-form">
                        <input id="mail" type="text" name="email" size="29" value="{if is_set($quizz_form_values['email'])}{$quizz_form_values['email']}{/if}"/>
                    </div>
                </div> 

                <div class="ligne-form">
                    <div class="champ-form">
                        <label for="nom">Nom <span class="texte-rouge">*</span></label>
                    </div>
                    <div class="input-form">
                        <input id="nom" type="text" name="nom"  size="29" value="{if is_set($quizz_form_values['nom'])}{$quizz_form_values['nom']}{/if}"/>
                    </div>
                </div>

                <div class="ligne-form">
                    <div class="champ-form">
                        <label for="prenom">Prénom <span class="texte-rouge">*</span></label>
                    </div>
                    <div class="input-form">
                        <input id="prenom" type="text" name="prenom" size="29" value="{if is_set($quizz_form_values['prenom'])}{$quizz_form_values['prenom']}{/if}"/>
                    </div>
                </div>

                <div class="ligne-form">
                    <div class="champ-form">
                        <label for="adr">Adresse</label>
                    </div>
                    <div class="input-form">
                        <input id="adr" type="text" name="adresse1" size="29" value="{if is_set($quizz_form_values['adresse1'])}{$quizz_form_values['adresse1']}{/if}"/>
                    </div>
                    <div class="input-form">
                        <input type="text" name="adresse2" size="29" value="{if is_set($quizz_form_values['adresse2'])}{$quizz_form_values['adresse2']}{/if}"/>
                    </div>
                </div>

                <div class="ligne-form">
                    <div class="champ-form">
                        <label for="cp">Code Postal</label>
                    </div>
                    <div class="input-form">
                        <input id="cp" type="text" name="cp" size="10" value="{if is_set($quizz_form_values['cp'])}{$quizz_form_values['cp']}{/if}"/>
                    </div>
                </div>

                <div class="ligne-form">
                    <div class="champ-form">
                        <label for="ville">Ville</label>
                    </div>
                    <div class="input-form">
                        <input id="ville" type="text" name="ville" size="29" value="{if is_set($quizz_form_values['ville'])}{$quizz_form_values['ville']}{/if}"/>
                    </div>
                </div>

                <div class="ligne-form obligatoire checkbox">



                    <div class="checkbox champ-form">
                        <div class="check">
                            <img src="{'images/checkbox-inactif.png'|ezdesign('no')}" class="inactive"/>
                            <img src="{'images/checkbox-actif.png'|ezdesign('no')}" class="active display-none"/>
                            <p>
                                <span class="cliq"> J'ai lu et j'accepte</span>
                                <a href={concat( 'content/download/', 
												$config_generale.data_map.quiz_fichier_conditions_reglement.contentobject_id, 
												'/', 
												$config_generale.data_map.quiz_fichier_conditions_reglement.id,
												'/version/', 
												$config_generale.data_map.quiz_fichier_conditions_reglement.version , 
												'/file/', 
												$config_generale.data_map.quiz_fichier_conditions_reglement.content.original_filename|urlencode )|ezurl}
								target="_blank" class="texte-vert-souligne"> les conditions générales  du règlement </a>
                                <span class="texte-rouge">*</span>
                            </p>
                        </div>
                        <input id="input-contrat" type="hidden" name="contrat" value="0"/>
                    </div>



                    <div class="checkbox champ-form">
                        <div class="check">
                            <img src="{'images/checkbox-inactif.png'|ezdesign('no')}" class="inactive"/>
                            <img src="{'images/checkbox-actif.png'|ezdesign('no')}" class="active display-none"/>
                            <p><span class="cliq">Je souhaite recevoir par mail les bons plans des Sables d'Olonne</span></p>
                        </div>
                        <input id="input-recevoir-email" type="hidden" name="recevoir-email" value="{if is_set($quizz_form_values['recevoir-email'])}{$quizz_form_values['recevoir-email']}{else}0{/if}"/>
                    </div>

                </div>
            </div>
        </div>    
    </form>
    <script>
        {literal}
            $("form.form-reponse .formulaire-reponse .ligne-form.checkbox .champ-form.checkbox .check img").click(function(){
                  if($(this).is('.inactive')){
                      $(this).css("display","none");
                      $(this).parent('div').find(".active").css("display","block");
                      $(this).parent('div').addClass("activia");
                      $(this).parent('div').parent('div').find('input:hidden').attr({value : '1'});
                      return false;
                  }
                   $(this).parent('div').removeClass("activia");
                   $(this).css("display","none");
                   $(this).parent('div').find(".inactive").css("display","block");
                   $(this).parent('div').parent('div').find(' input:hidden').attr({value : '0'});
                   return false;
            });
            $("form.form-reponse .formulaire-reponse .ligne-form.checkbox .champ-form.checkbox .check p span.cliq").click(function(){
                  if($(this).parent('p').parent('div').is(".activia")){
                     $(this).parent('p').parent('div').removeClass("activia");
                     $(this).parent('p').parent('div').find('img.inactive').css("display","block");
                     $(this).parent('p').parent('div').find('img.active').css("display","none");
                     $(this).parent('p').parent('div').parent('div').find('input:hidden').attr({value : '0'});
                      return false;
                  }
                   $(this).parent('p').parent('div').addClass("activia");
                   $(this).parent('p').parent('div').find('img.active').css("display","block");
                   $(this).parent('p').parent('div').find('img.inactive').css("display","none");
                   $(this).parent('p').parent('div').parent('div').find('input:hidden').attr({value : '1'});
                   return false;
            });
            $("form.form-reponse .formulaire-reponse .ligne-form.checkbox .champ-form.checkbox .check img").each(function(){
                
                if($(this).parent('div').parent('div').find('input:hidden').val() == 0){
                    $(this).css("display","none");
                    $(this).parent('div').find(".active").css("display","block");
                    $(this).parent('div').addClass("activia");
                    $(this).parent('div').parent('div').find('input:hidden').attr({value : '0'});
                }else{
                    $(this).parent('div').removeClass("activia");
                    $(this).css("display","none");
                    $(this).parent('div').find(".inactive").css("display","block");
                    $(this).parent('div').parent('div').find(' input:hidden').attr({value : '1'});     
                }
                
            });
            $("form.form-reponse .formulaire-reponse .ligne-form.checkbox .champ-form.checkbox .check p span.cliq").each(function(){
                
                if($(this).parent('p').parent('div').parent('div').find('input:hidden').val() == 0){
                    $(this).parent('p').parent('div').removeClass("activia");
                    $(this).parent('p').parent('div').find('img.inactive').css("display","block");
                    $(this).parent('p').parent('div').find('img.active').css("display","none");
                    $(this).parent('p').parent('div').parent('div').find('input:hidden').attr({value : '0'});
                }else{
                    $(this).parent('p').parent('div').addClass("activia");
                    $(this).parent('p').parent('div').find('img.active').css("display","block");
                    $(this).parent('p').parent('div').find('img.inactive').css("display","none");
                    $(this).parent('p').parent('div').parent('div').find('input:hidden').attr({value : '1'});
                }
            });
            
                   
        {/literal}
    </script>

</div>
{undef $config_generale}