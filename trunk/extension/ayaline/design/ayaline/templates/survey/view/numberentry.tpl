<div class="label-form">
	<label class="lsdo-label non-textarea">
	{$question.text|wash('xhtml')}{section show=$question.mandatory}<strong class="required">*</strong>{/section} :</label>
</div>

<div class="input-form">
{section show=$question_result}
  <input size="10" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" type="text" value="{$question_result.text|number($question.num)|wash('xhtml')}" />
{section-else}
  <input size="10" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" type="text" value="{$question.answer|number($question.num)|wash('xhtml')}" />
{/section}
</div>