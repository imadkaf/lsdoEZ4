{if not(is_set($mise_en_avant))}
	{sit_mise_en_avant()}
{else}
	{if eq($mise_en_avant, 'diaporama')}
		{sit_mise_en_avant('sit_mise_en_avant_diaporama')}
	{/if}
	
	{if eq($mise_en_avant, 'agenda')}
		{sit_mise_en_avant('sit_mise_en_avant_agenda')}
	{/if}
	
	{if eq($mise_en_avant, 'coup-de-coeur')}
		{sit_mise_en_avant('sit_mise_en_avant_coup_de_coeur')}
	{/if}
{/if}
