{if $rubriques|count|gt(0)}
{def $selected = false()}
	<ul class="gallery-tab">
	{foreach $rubriques as $rubrique}
		<li{if $node.path_string|contains($rubrique.path_string)} class="selected"{/if}><strong><a href={$rubrique.url_alias|ezurl}>{$rubrique.name|wash}</a></strong></li>
	{/foreach}
	</ul>
	<div class="clear"></div>
{/if}