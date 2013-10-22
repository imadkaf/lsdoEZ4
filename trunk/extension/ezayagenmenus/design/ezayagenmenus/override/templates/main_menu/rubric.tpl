{def $hostname = ezayagenmenus_get_hostname()}
{def $node_url_alias = concat($hostname, $node.url_alias|ezurl('no'))}

{if $node.data_map.thumbnail.has_content}
	{attribute_view_gui attribute = $node.data_map.thumbnail image_class='main_menu' href=$node_url_alias}
{else}
	<a href={$node_url_alias}><img src={'sit/image_fiche_defaut_moyenne.jpg'|ezimage} width="90" alt="{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}" title="{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}" /></a>
{/if}

<h2><a href={$node_url_alias}>{$node.name|wash}</a></h2>

{if $node.data_map.short_description.has_content}
	<p>
		{if eq($node.data_map.short_description.content|count_words, $node.data_map.short_description.content|word_cut(11)|count_words)}
			{attribute_view_gui attribute = $node.data_map.short_description}
		{else}
			{$node.data_map.short_description.content|wash|word_cut(11)}...
		{/if}
	</p>
{/if}
{undef $hostname}
