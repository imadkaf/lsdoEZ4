{def $cNode = array()}
{if is_set($module_result.node_id)}
	{set $cNode = fetch(content, node, hash(node_id, $module_result.node_id))}
{/if}

{def $rNode = fetch('content','node', hash('node_id',  ezini('NodeSettings','RootNode','content.ini')))}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN"
    "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	{include uri="design:header.tpl"}
	<body>
		<div data-role="page">
			<!-- Conteneur -->
			<div id="container">
				
				<!-- En-tete -->
				<div id="Header">
					<div class="logo">
						<a href={$rNode.url_alias|ezurl} class="ui-link">
							<img alt="" src={'images/logo1.png'|ezdesign()} />
							<h2>{attribute_view_gui attribute = $rNode.data_map.titre_en_tete}</h2>
							<h3>{attribute_view_gui attribute = $rNode.data_map.sous_titre_en_tete}</h3>
						</a>
					</div>
					<div class="TopNavBar">
						<div class="menu">
							{foreach $rNode.data_map.header_menu.content.main_node.children as $sMenu}
								{node_view_gui content_node=$sMenu view='menu'}
							{/foreach}
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>

				<!-- Corps -->
				<div id="Main">
					{$module_result.content}
				</div>
				
				<!-- Pied de page -->
				<div id="footer">
					{include uri="design:footer.tpl" node=$node}
				</div>
				{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
						<script type="text/javascript">
							var _gaq = _gaq || [];
							{*_gaq.push(['_setAccount', '{$googleAccountKey}']); prend en compte celui de l'extension ayaline... TODO*}
							_gaq.push(['_setAccount', 'UA-16152350-4']);
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
		</div>
	</body>
</html>
