{set-block scope=global variable=cache_ttl}0{/set-block}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{sit_recherche()}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type{if eq($node.data_map.categorie.object.name, 'Hôtellerie')} padding-lr{/if}">
			<h2 class="bloc-liste-h2">{$node.name|wash(xhtml)}</h2>
			<p class="clear"></p>
			{if eq($node.data_map.categorie.object.name, 'Hôtellerie')}
				<p class="chapeau-bis">
					{attribute_view_gui attribute=$node.data_map.description}
				</p>
				<p class="map">
				
				</p>
				<span class="picto-hotel">Hotels</span>
			{/if}
			{sit_liste()}
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{if eq($node.data_map.categorie.object.name, 'Hôtellerie')}
		{include uri='design:parts/agenda.tpl'}
	{/if}
</div>
