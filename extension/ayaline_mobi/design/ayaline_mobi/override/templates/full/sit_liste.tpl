<div class="contenu-liste liste-hotel">
	<div class="titre-liste">
		<h2>{$node.name|wash}</h2>
	</div>
	
	{*<div class="rech-dispo">
		<a href="#">Rechercher les disponibilités</a>
	</div>*}
	
	{if eq($node.data_map.googlemaps.data_int, '1')}
		{sit_liste('sit_liste_carte_mobile')}
	{/if}
	
	{sit_liste()}
</div>
