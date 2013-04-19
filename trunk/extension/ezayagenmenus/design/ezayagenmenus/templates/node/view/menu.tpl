{def $hostname = ezayagenmenus_get_hostname()}
{if $node.object.class_identifier|eq('espace_presse')}
{* cas de l'espace presse : redirection vers user/login pour connexion *}
<a href="{concat($hostname,'/user/login'|ezurl('no'))}">{if is_set($nomSousMenu)}{$nomSousMenu|wash}{else}{$node.name|wash}{/if}</a>
{else}
<a href="{concat($hostname,$node.url_alias|ezurl('no'))}">{if is_set($nomSousMenu)}{$nomSousMenu|wash}{else}{$node.name|wash}{/if}</a>
{/if}
{undef $hostname}