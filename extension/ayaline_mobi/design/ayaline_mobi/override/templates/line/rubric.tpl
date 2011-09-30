<a href={$node.url_alias|ezurl}>
	{if $node.data_map.thumbnail.has_content}
		{attribute_view_gui attribute=$node.data_map.thumbnail image_class='contenuMobile'}
	{else}
		<img src={'sit/image_fiche_defaut_moyenne.jpg'|ezimage} width="88px" alt="{$node.name|wash}" title="{$node.name|wash}" />
	{/if}
</a>

<div class="title">
	<a href={$node.url_alias|ezurl}>{$node.name}</a>
</div>
<br />
