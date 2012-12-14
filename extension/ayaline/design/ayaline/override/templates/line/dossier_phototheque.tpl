<h3 class="bloc-liste-h3">
	<a href={$node.url_alias|ezurl} title="{$node.name|wash}">{attribute_view_gui attribute = $node.data_map.title}</a>
</h3>

{if $node.data_map.thumbnail.has_content}
	<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute=$node.data_map.thumbnail image_class='phototheque'}</a>
	<span class="legende-phototheque">{$node.data_map.thumbnail.content.alternative_text}</span>
{else}
	<a href={$node.url_alias|ezurl} class="no-vignette"><img src={"interrogation.png"|ezimage} alt="{$node.name|wash}" title="{$node.name|wash}" /></a>
{/if}
