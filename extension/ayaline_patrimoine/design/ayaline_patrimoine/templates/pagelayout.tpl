{def $cNode = array()}
{if is_set($module_result.node_id)}
    {set $cNode = fetch(content, node, hash(node_id, $module_result.node_id))}
{/if}
{def $rooNodeSitePatrimoine=fetch('content','list',hash('parent_node_id',ezini('NodeSettings','RootNode','content.ini'),
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_accueil')
    ))
}
{def $rNode=$rooNodeSitePatrimoine.0}

{def $nodeConfigGeneralPatrimoine=fetch('content','list',hash('parent_node_id',$rNode.node_id,
                                                'class_filter_type','include',
                                                'class_filter_array',array('smp_configuration')
    ))
}
{def $nodeConfigGeneral = $nodeConfigGeneralPatrimoine.0}
<!doctype html>
<html lang="fr">
{include uri="design:page_head.tpl"}
<body>
<div data-role="page">
	<!-- MAIN CONTAINER BEGINNING -->
	<div id="container">
		{include uri="design:parts/bandeau_haut.tpl"}
		<div class="clear"></div>
		<div id="Main">
			{$module_result.content}
			{if ne($module_result.node_id,$rNode.node_id)}
				{include uri="design:parts/fil_ariane.tpl"}
			{/if}
			{include uri="design:parts/formulaire_recherche.tpl"}
			{include uri="design:parts/copyright.tpl"}
			<div class="clear"></div>
		</div>		
		{if ne($module_result.node_id,$rNode.node_id)}
		<div class="sep-70px"></div>
			{include uri="design:parts/barre_navigation.tpl"}
		{/if}		
	</div>
	{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini.append')}
						<script type="text/javascript">
							var _gaq = _gaq || [];
							_gaq.push(['_setAccount', '{$googleAccountKey}']);
							_gaq.push(['_setDomainName', 'none']);
						    _gaq.push(['_setAllowLinker', true]);
							_gaq.push(['_trackPageview']);
				{literal}
							(function() {
								var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
								ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
								var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
							})();
				{/literal}
						</script>
	{undef $googleAccountKey}
</div>
</body>
{include uri="design:parts/script_barre_navigation.tpl"}
<script>head.js({ldelim}jplayer:"{'javascript/jquery.diaporama.js'|ezdesign('no')}"{rdelim},{ldelim}utils:"{'javascript/utils.min.js'|ezdesign('no')}"{rdelim});</script>
</html>
{undef $cNode $rNode $nodeConfigGeneral}