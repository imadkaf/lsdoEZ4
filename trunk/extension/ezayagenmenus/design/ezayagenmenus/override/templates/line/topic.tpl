{def $hostname = ezayagenmenus_get_hostname()}
{* affichage des themes dans le menu Decouvrir du haut *}
<li{if $topicIds|contains($node.node_id)} class="actif"{/if}>
        <form method="post" action="{concat($hostname,"/themes/edit/"|ezurl('no'))}">
                <input type="hidden" value="{if is_set($redirectURI)}{$redirectURI}{else}{concat($hostname,$node.url_alias|ezurl('no'))}{/if}" name="RedirectURI" />
                <input type="hidden" value="{$node.node_id}" name="topic_id" />
                <input type="submit" name="{$node.name}" value="{$node.name}" />
        </form>
</li>
{undef $hostname}