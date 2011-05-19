{def $compteur = 1}

{if $rubriques|count|gt(0)}
{def $selected = false()}
	<ul>
	{foreach $rubriques as $rubrique}
		<li class="{if eq($compteur,1)}first{/if} {if $node.path_string|contains($rubrique.path_string)}actif{/if}">
			{if $node.path_string|contains($rubrique.path_string)}
				<span class="menu-g-on">
					<span class="menu-d-on">{$rubrique.name|wash}</span>
				</span>
			{else}
				<a href={$rubrique.url_alias|ezurl} class="menu-g-off">
					<span class="menu-d-off">{$rubrique.name|wash}</span>
				</a>
			{/if}
		</li>
		{set $compteur = inc($compteur)}
	{/foreach}
	</ul>
	<p class="clear"></p>
{/if}
