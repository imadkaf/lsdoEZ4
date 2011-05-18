{if $attribute.data_text}
<a href="{$attribute.content|wash( xhtml )}"{if is_set($target)} target="{$target}"{/if}>{$attribute.data_text|wash( xhtml )}</a>
{else}
<a href="{$attribute.content|wash( xhtml )}"{if is_set($target)} target="{$target}"{/if}>{$attribute.content|wash( xhtml )}</a>
{/if}