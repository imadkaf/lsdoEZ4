{def $nbPubs = 3}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{sit_recherche()}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type padding-lr">
			{$contenuBloc}
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites_fiche.tpl' nbPubs = $nbPubs}
	{*if eq($previousNode.data_map.categorie.data_text, '1')*}
		{*sit_liste('sit_liste_voir_aussi_1.xsl')*}
	{*else*}
		{sit_liste('sit_liste_voir_aussi')}
	{*/if*}
</div>
