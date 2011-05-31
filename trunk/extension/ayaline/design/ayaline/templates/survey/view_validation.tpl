{section show=and( is_set( $survey_validation ), or( $survey_validation.error, $survey_validation.warning ))}
<div class="block">
	<div class="message-warning">
		<h2>Veuillez remplir les champs suivants :</h2><br />
		{*<h3>{"Erreur"|i18n( 'survey' )}</h3>*}
		
		<ul>
			{foreach $survey_validation.errors as $key => $error}
			  <li>
			  	<span class="label-erreur"><b>{$error.question.text}</b></span>{if ne($error.question.text, '')} : {/if}{$error.message}
			  </li>
			{/foreach}
			{foreach $survey_validation.warnings as $key => $warning}
			  <li>
			  	{$warning.message}
			  </li>
			{/foreach}
		</ul>
	</div>
</div>
<br/ >
{/section}
