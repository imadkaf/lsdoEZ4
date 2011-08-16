{def $nbPubs = 5}

{set-block scope=global variable=cache_ttl}0{/set-block}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{sit_recherche()}
	</div>

	<div class="bloc-right-in-bis">
		<div class="bloc-type{if eq($node.data_map.categorie.data_text, '1')} padding-lr{/if}">
			{def $affichageListeSIT = fetch( 'content', 'reverse_related_objects',
								hash( 'object_id', $node.contentobject_id,
										'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
										
			<h2 class="bloc-liste-h2">
				{if $affichageListeSIT|count}
					{$affichageListeSIT.0.name}
				{else}
					{$node.name}
				{/if}
			</h2>
			<p class="clear"></p>
			
			{if $affichageListeSIT|count}
				{if ne($affichageListeSIT.0.data_map.short_description.content, '')}
					<p class="chapeau-bis">
						{attribute_view_gui attribute=$affichageListeSIT.0.data_map.short_description}
					</p>
				{else}
					<br />
				{/if}
				
				{if eq($affichageListeSIT.0.data_map.googlemaps.data_int, '1')}
					{if eq($node.data_map.categorie.data_text, '1')}
						{sit_liste('sit_liste_carte_1')}
					{else}
						{sit_liste('sit_liste_carte')}
					{/if}
				{/if}
			{/if}
			
			{sit_liste()}
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>
