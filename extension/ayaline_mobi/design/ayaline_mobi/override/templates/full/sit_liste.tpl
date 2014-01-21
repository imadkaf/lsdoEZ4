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
	<script src="http://gadget.open-system.fr/jquery.min.js" type="text/JavaScript" ></script>
	<script src="http://gadget.open-system.fr/osform.min.js" type="text/JavaScript" ></script>
	<script type="text/javascript" xml:space="preserve">
		$(function () {ldelim}
			document.oswidget = new OsFG("OSRecherche","22357-2509","fr");
			document.oswidget.SetOptionAffichage({ldelim}"Navigation":"accordeon","CouleurFond":"#ffffff"{rdelim});
			document.oswidget.Affiche();
			
		{rdelim});
	</script>
	<div id="OSRecherche"></div>

	{sit_recherche()}
	
	{sit_liste()}
</div>
