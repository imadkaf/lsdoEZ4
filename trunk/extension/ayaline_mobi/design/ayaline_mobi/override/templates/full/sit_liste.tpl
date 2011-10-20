<div class="contenu-liste liste-hotel">
	<div class="titre-liste">
		<h2>{$node.name|wash}</h2>
	</div>
	
	{*<div class="rech-dispo">
		<a href="#">Rechercher les disponibilités</a>
	</div>*}
	{if eq($node.data_map.form_recherche.data_text, 0)}
		{sit_recherche()}
	{/if}
	{sit_liste()}
</div>
