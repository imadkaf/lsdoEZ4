{def $extAyaWidgetFilterName=ezini('GlobalSettings','FilterName','ayaline_external_widget.ini')}
{set $extAyaWidgetFilterName=cond($extAyaWidgetFilterName,$extAyaWidgetFilterName,'widget')}

{def $nbPubs = 3}
{*$previousNode.name*}
<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
            {if is_unset($view_parameters[$extAyaWidgetFilterName])}
		{sit_recherche()}
            {/if}
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
        {if is_unset($view_parameters[$extAyaWidgetFilterName])}
            {sit_liste('sit_liste_voir_aussi')}
        {/if}
	
</div>
        
{if is_unset($view_parameters[$extAyaWidgetFilterName])|not}
    <script>
        {literal}
            $('.bloc-right-in-bis').css({'width':'100%'});
            $('.bloc-right-in-bis .box-right').css({'width':'510px'});
        {/literal}
    </script>
{/if}