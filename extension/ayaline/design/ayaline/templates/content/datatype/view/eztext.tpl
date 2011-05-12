{if is_set($nbChar)}
{$attribute.content|shorten($nbChar)|wash( xhtml )|nl2br}
{else}
{$attribute.content|wash( xhtml )|nl2br}
{/if}