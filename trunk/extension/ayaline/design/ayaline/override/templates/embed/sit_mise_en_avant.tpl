{if eq($object.data_map.mode_affichage.value, 'Basique'))}
	{sit_mise_en_avant()}
{else}
	{if eq($object.data_map.mode_affichage.value, 'Diaporama')}
		{sit_mise_en_avant('sit_mise_en_avant_diaporama')}
	{else}
		Le mode d'affichage sélectionné ne correspond pas.
	{/if}
{/if}
