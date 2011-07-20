{if eq($object.data_map.mode_affichage.value.0, '2')}
	{sit_mise_en_avant('sit_mise_en_avant_basique')}
{else}
	{if eq($object.data_map.mode_affichage.value.0, '1')}
		{sit_mise_en_avant('sit_mise_en_avant_diaporama')}
	{else}
		Le mode d'affichage sélectionné ne correspond pas à la vue.
	{/if}
{/if}
