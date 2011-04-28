{if is_set($attribute.content[1])}
<a href="{$attribute.content[0]|wash( xhtml )}" onClick="_gaq.push(['_trackEvent','{$attribute.content[2]}','{$attribute.content[3]}','{$attribute.content[4]}']);"{if $attribute.content[0]|begins_with('http://')} target="_blank"{/if} title="{$attribute.content[1]}">{$attribute.content[1]|wash( xhtml )}</a>
{else}
<a href="{$attribute.content[0]|wash( xhtml )}" onClick="_gaq.push(['_trackEvent','{$attribute.content[2]}','{$attribute.content[3]}','{$attribute.content[4]}']);"{if $attribute.content[0]|begins_with('http://')} target="_blank"{/if} title="{$attribute.content[0]}">{$attribute.content[0]|wash( xhtml )}</a>
{/if}