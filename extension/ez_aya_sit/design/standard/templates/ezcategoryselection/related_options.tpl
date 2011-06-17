{if count($foundOptions)|gt(0)}
<ul class="ezcategoryselection-found-options-{$attributeId}" style="background-color:white;height:300px;overflow:auto;margin:-1px 0 0 0;padding:0;border:1px solid #999999">
{foreach $foundOptions as $foundOptionId=>$foundOption sequence array('ezcategoryselection-odd', 'ezcategoryselection-even') as $bgcolorcss}
<li class="ezcategoryselection-found-option" style="list-style:none;margin:0;padding:0"><a href="#" rel="{$foundOption.categories}" class="{$bgcolorcss}">{$foundOption.name}</a><input type="hidden" name="ezcategoryselection-found-option-id[]" value="{$foundOptionId}" /></li>
{/foreach}
</ul>
{/if}