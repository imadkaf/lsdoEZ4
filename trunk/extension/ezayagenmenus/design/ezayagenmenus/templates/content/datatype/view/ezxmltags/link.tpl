{def $hostname = ezayagenmenus_get_hostname()}
<a href="{concat($hostname, $href|ezurl('no'))}"{if $id} id="{$id}"{/if}{if $title} title="{$title}"{/if}{if $target} target="{$target}"{/if}{if $classification} class="{$classification|wash}"{/if}{if and(is_set( $hreflang ), $hreflang)} hreflang="{$hreflang|wash}"{/if}>{$content}</a>
{undef $hostname}