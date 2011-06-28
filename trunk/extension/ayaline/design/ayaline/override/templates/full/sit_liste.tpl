{def $nbPubs = 5}

{set-block scope=global variable=cache_ttl}0{/set-block}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{sit_recherche()}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type{if eq($node.name, 'Hôtellerie')} padding-lr{/if}">
			<h2 class="bloc-liste-h2">{$node.name|wash(xhtml)}</h2>
			<p class="clear"></p>
			{if eq($node.name, 'Hôtellerie')}
				<p class="chapeau-bis">
					{attribute_view_gui attribute=$node.data_map.description}
				</p>
			{/if}
			
			{sit_liste()}
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{if eq($node.name, 'Hôtellerie')}
		{include uri='design:parts/agenda.tpl'}
	{/if}
</div>
