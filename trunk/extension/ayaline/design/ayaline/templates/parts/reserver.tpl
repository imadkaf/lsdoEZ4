<div class="bloc-type" id="bloc-ac-res">
	{* Deja appele <script src="http://gadget.open-system.fr/jquery.min.js" type="text/JavaScript" ></script> *}
	{*<script src="http://gadget.open-system.fr/osform.min.js" type="text/JavaScript" ></script>*}
	{literal}
	<script type="text/javascript" xml:space="preserve">
		$(function () {
			document.oswidget = new OsFG("OSRecherche","22357-1608","fr");
			document.oswidget.SetOptionAffichage({"Navigation":"accordeon","CouleurFond":"#ffffff"});
			document.oswidget.Affiche();
			
		});
	</script>
	{/literal}
	
	<h2 class="bloc-accueil-h2">
		{"Reserve"|i18n("ayaline")}
	</h2>
	<p class="clear"></p>
	<h3 class="bloc-accueil-h3">
		{"I search"|i18n("ayaline")}
	</h3>
	<div id="OSRecherche"></div>

</div>
