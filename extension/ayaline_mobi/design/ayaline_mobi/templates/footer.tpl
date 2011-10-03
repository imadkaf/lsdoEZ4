{include uri="design:parts/recherche.tpl"}
					
{include uri="design:parts/chemin.tpl"}
					
{include uri="design:parts/sit_mise_en_avant.tpl" node=$node}

<div id="piedPage">
	<div id="Copyrights">
		{attribute_view_gui attribute = $rNode.data_map.footer}
	</div>
	<div class="ayaline">
		<a class="lien" href="http://www.ayaline.com" target="_blank"> Réalisation&nbsp;:<span>aYaline</span><br /><img src={"ayaline.png"|ezimage} alt="" /></a>
	</div>
</div>
<div class="clear"></div>