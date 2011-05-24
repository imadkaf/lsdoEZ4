{if not(is_set($compteurQuestion))}
	{def $compteurQuestion = ''}
{/if}

{if eq($question.num2, 1)}
	{if $compteurQuestion|ne('')}
		{set $compteurQuestion = $compteurQuestion|inc}
	{else}
		{set $compteurQuestion = 1}
	{/if}
{else}
	{if is_set($compteurQuestion)}
		{undef $compteurQuestion}
	{/if}
{/if}

<label class="lsdo-label {if eq($question.num2, 1)}non-textarea{/if}">{$question.text|wash('xhtml')} {section show=$question.mandatory}<strong class="required">*</strong>{/section}</label>

<div class="survey-choices {if and(eq($question.num2, 1) ,eq($compteurQuestion|mod(2), 1))}float-g{/if}">
{switch match=$question.num2}
{case match=1}
{section show=$question_result}
{if is_set($survey_validation.post_variables.variables[$question.id])}
  {def $previous_vars=$survey_validation.post_variables.variables[$question.id]}
{/if}
  <input class="box" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" type="text" size="{$question.num}" value="{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer}{else}{$question_result.text|wash('xhtml')}{/if}" />
{section-else}
  <input class="box" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" type="text" size="{$question.num}" value="{$question.answer|wash('xhtml')}" />
{/section}
{/case}
{case}
{section show=$question_result}
{if is_set($survey_validation.post_variables.variables[$question.id])}
  {def $previous_vars=$survey_validation.post_variables.variables[$question.id]}
{/if}
  <textarea class="box" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" rows="{$question.num2}" cols="{$question.num}">{if is_set($previous_vars.answer)}{$previous_vars.extra_answer}{else}{$question_result.text|wash('xhtml')}{/if}</textarea>
{section-else}
  <textarea class="box" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" rows="{$question.num2}" cols="{$question.num}">{$question.answer|wash('xhtml')}</textarea>
{/section}
{/case}
{/switch}
</div>

{if is_set($compteurQuestion)}
	Test : {$compteurQuestion}
{/if}
