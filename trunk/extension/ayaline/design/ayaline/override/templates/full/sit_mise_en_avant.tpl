{sit_mise_en_avant('sit_mise_en_avant_coup_de_coeur')}



{* OK
{if eq($node.data_map.mode_affichage, 'Agenda'))}
	{sit_mise_en_avant('sit_mise_en_avant_agenda')}
{else}
	{if eq($node.data_map.mode_affichage, 'Coup de coeur')}
		{sit_mise_en_avant('sit_mise_en_avant_coup_de_coeur')}
	{else}
		{if eq($node.data_map.mode_affichage, 'Les plus consultés')}
			{sit_mise_en_avant('sit_mise_en_avant_les_plus_consultes')}
		{else}
			Le mode d'affichage sélectionné ne correspond pas.
		{/if}
	{/if}
{/if}
*}
