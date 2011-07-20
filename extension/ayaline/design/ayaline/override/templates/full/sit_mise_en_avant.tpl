{if eq($node.data_map.mode_affichage.value.0, '3')}
	{sit_mise_en_avant('sit_mise_en_avant_agenda')}
{else}
	{if eq($node.data_map.mode_affichage.value.0, '4')}
		{sit_mise_en_avant('sit_mise_en_avant_coup_de_coeur')}
	{else}
		{if eq($node.data_map.mode_affichage.value.0, '5')}
			{sit_mise_en_avant('sit_mise_en_avant_les_plus_consultes')}
		{else}
			Le mode d'affichage sélectionné ne correspond pas à la vue.
		{/if}
	{/if}
{/if}
