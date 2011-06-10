{if ne($mail_content, '')}
	{set-block scope=root variable=subject}{"Confirmation de la réception de votre demande"|i18n('survey')}{/set-block}
	{*contenu du mail renseigné dans le formulaire*}
	{def $content = $mail_content|explode('###CHAMPS###')}
	{$content[0]}
	
{section var=question loop=$survey_questions}
{survey_question_result_gui view=mail question=$question}
{/section}
	
	{$content[1]}
{else}
	{set-block scope=root variable=subject}{"Confirmation de la réception de votre demande"}{/set-block}
	{*contenu du mail par défaut*}
	{*set $mail_content = ezini('ezSurvey','defaultMail','cg41.ini')*}
Bonjour,

Nous avons bien enregistré votre demande et nous vous en remercions.

Récapitulatif de vos informations :

{*Champs du formulaire*}
{section var=question loop=$survey_questions}
{survey_question_result_gui view=mail question=$question}
{/section}

À bientôt,

L’équipe Culture et Patrimoine
{/if}
