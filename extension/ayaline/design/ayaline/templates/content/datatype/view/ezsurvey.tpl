<div class="survey-view">
{def $survey=$attribute.content.survey}
{if is_set($attribute.content.survey_validation.one_answer_need_login)}
	<p>{"You need to log in in order to answer this survey"|i18n('survey')}.</p>
	{include uri='design:user/login.tpl'}
{else}
	{if $survey.valid|eq(false())}
		<p>{"The survey is not active"|i18n('survey')}.</p>
	{else}
		{def $survey_validation=$attribute.content.survey_validation}
		{if or(is_set( $survey_validation.one_answer ), and(is_set($survey_validation.one_answer_count), $survey_validation.one_answer_count|gt(0)))}
			<p>{"The survey does already have an answer from you"|i18n('survey')}.</p>
		{else}
			{def $prefixAttribute='ContentObjectAttribute'}
			{def $node=fetch( 'content', 'node', hash( 'node_id', module_params().parameters.NodeID ))}
			{def $module_param_value=concat(module_params().module_name,'/', module_params().function_name)}
			{if $module_param_value|ne('content/edit')}
				{*$node.url_alias|ezurl()*}
				<form class="form-contact" enctype="multipart/form-data" method="post" action={$node.url_alias|ezurl()}>
			{/if}
			<input type="hidden" name="{$prefixAttribute}_ezsurvey_contentobjectattribute_id_{$attribute.id}" value="{$attribute.id}" />
			<input type="hidden" name="{$prefixAttribute}_ezsurvey_node_id_{$attribute.id}" value="{module_params().parameters.NodeID}" />
			
			<input type="hidden" name="{$prefixAttribute}_ezsurvey_id_{$attribute.id}" value="{$survey.id}" />
			<input type="hidden" name="{$prefixAttribute}_ezsurvey_id_view_mode_{$attribute.id}" value="{$survey.id}" />
			
			{*Affichage des erreurs*}
			{if is_set($preview)|not}
				{include uri="design:survey/view_validation.tpl"}
			{/if}
			{let question_results=$survey.question_results}
			{section show=$question_results}
			  {section var=question loop=$survey.questions}
			    {section show=$question.visible}
			      <div class="block">
			      <input type="hidden" name="{$prefix}_ezsurvey_question_list_{$attribute.id}[]" value="{$question.id}" />
			      <a name="survey_question_{$question.question_number}"></a>
			      {if is_set($question_results[$question.id])}
			        {survey_question_view_gui question=$question question_result=$question_results[$question.id] attribute_id=$attribute.id prefix_attribute=$prefixAttribute survey_validation=$survey_validation}
			      {else}
			        {survey_question_view_gui question=$question question_result=0 attribute_id=$attribute.id prefix_attribute=$prefixAttribute}
			      {/if}
      			  <div class="break"></div>
			      </div>
			    {/section}
			  {/section}
			{section-else}
			  {section var=question loop=$survey.questions}
			    {section show=$question.visible}
			      <div class="block">
			      <input type="hidden" name="{$prefixAttribute}_ezsurvey_question_list_{$attribute.id}[]" value="{$question.id}" />
			      <a name="survey_question_{$question.question_number}"></a>
			      {survey_question_view_gui question=$question question_result=0 attribute_id=$attribute.id prefix_attribute=$prefixAttribute}
			      <div class="break"></div>
			      </div>
			    {/section}
			  {/section}
			{/section}
			{/let}

			{*/reCaptcha/*}
			{$node.data_map.captcha_active.content}
			{if eq($node.data_map.captcha_active.content, 1)}
				<div class="block">
					<div class="label-form">
						<br />
						<label class="lsdo-label non-textarea">Code de sécurité<strong class="required">*</strong>:</label>
					</div>
					<div class="input-form lsdo-recaptcha">
						<p class="text-captcha">Saisir le code ci-dessous. Si vous ne pouvez lire toutes les lettres ou chiffres, <a href="javascript:Recaptcha.reload ();">Cliquez ici</a>.</p>
						<br />
						<div id="captcha" class="f-left">
							{*set $class='text-champs' set $class='text-champs textearea600' def $class='skin_select'*}
							{attribute_view_gui attribute=$node.data_map.recaptcha class='skin_select'}
						</div>
					</div>
				</div>
			{/if}
			{*/user mail subject/*}
			<input id="mail_subject" type="hidden" name="mail_subject" value="{$node.data_map.mail_subject.content}" /> 
			{*/user mail content/*}
			<input id="mail_content" type="hidden" name="mail_content" value="{$node.data_map.mail_content.content}" />
			{*/formulaire name/*}
			<input id="form_name" type="hidden" name="form_name" value="{$node.name}" />
			
			<div class="validate block button">
				<input class="button-effacer" type="image" src={"effacer.png"|ezimage} name="reset" value="Effacer" onclick="this.form.reset(); return false;" />
				<input class="button button-envoyer" type="image" src={"envoyer.png"|ezimage} name="{$prefixAttribute}_ezsurvey_store_button_{$attribute.id}" value="{'Submit'|i18n( 'survey' )}" onclick="this.form.submit(); return false;"/>
			</div>
			
			{if $module_param_value|ne('content/edit')}
			
				<div class="clear"></div>
				<p class="text-spec">
					<strong class="required">*</strong> Champs obligatoires
				</p>
				{*"Questions marked with %mark% are required."|i18n('survey', '', hash( '%mark%', '<strong class="required">*</strong>' ) )*}
				</form>
			{/if}
		{/if}
	{/if}
{/if}
</div>