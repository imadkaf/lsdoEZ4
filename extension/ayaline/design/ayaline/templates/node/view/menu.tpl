{if $node.object.class_identifier|eq('espace_presse')}
{* cas de l'espace presse : redirection vers user/login pour connexion *}
<a href={'/user/login'|ezurl}>{if is_set($nomSousMenu)}{$nomSousMenu|wash}{else}{$node.name|wash}{/if}</a>
{else}
<a href={$node.url_alias|ezurl}>{if is_set($nomSousMenu)}{$nomSousMenu|wash}{else}{$node.name|wash}{/if}</a>
{/if}