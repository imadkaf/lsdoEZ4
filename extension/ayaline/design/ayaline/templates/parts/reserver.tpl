{def $langue = ezini( 'RegionalSettings', 'SiteLanguageList' )}
{set $langue = $langue.0}
<div class="bloc-type" id="bloc-ac-res">
	{* Deja appele <script src="http://gadget.open-system.fr/jquery.min.js" type="text/JavaScript" ></script> *}
	{*<script src="http://gadget.open-system.fr/osform.min.js" type="text/JavaScript" ></script>*}
	{literal}
	<script type="text/javascript" xml:space="preserve">
		$(function () {
			{/literal}
				{if eq('fre-FR', $langue)}
			{literal}
					document.oswidget = new OsFG("OSRecherche","22357-2457","fr");
			{/literal}
				{/if}
				{if eq('eng-GB', $langue)}
			{literal}
					document.oswidget = new OsFG("OSRecherche","22357-2457","uk");
			{/literal}
				{/if}
				{if eq('ger-DE', $langue)}
			{literal}
					document.oswidget = new OsFG("OSRecherche","22357-2457","uk");
			{/literal}
				{/if}
			{literal}
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
