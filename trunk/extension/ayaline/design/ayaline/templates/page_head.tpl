{def $title = "Les Sables d'Olonne - Site officiel de l'office de tourisme des Sables d'Olonne"}
{if is_set($cNode.node_id)}
	{set $title = concat($cNode.name|wash(), " - ")}
{/if}
{def $referencement = false()}
{def $keywords = false()}
{def $description = false()}
{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
{if is_set($cNode.data_map.referencement)}
	{set $referencement = $cNode.data_map.referencement}
	{if $referencement.content[1]|trim|ne('')}
		{set $keywords = $referencement.content[1]|trim}
	{/if}
	{if $referencement.content[2]|trim|ne('')}
		{set $description = $referencement.content[2]|trim}
	{/if}
{/if}
{def $reverse_path = array()}
{def $path = $module_result.path}
{if is_set($pagedata.path_array)}
	{set $path = $pagedata.path_array}
{elseif is_set($module_result.title_path)}
	{set path=$module_result.title_path}
{/if}
{def $cPathNode = false()}
{foreach $path as $pathNode}
	{set $cPathNode = fetch(content, node, hash(node_path, $pathNode.url))}
	{if is_set($cPathNode.data_map.referencement)}
		{def $referencementPathNode = $cPathNode.data_map.referencement}
		{if $referencementPathNode.content[0]|trim|ne('')}
			{set $reverse_path=$reverse_path|prepend($referencementPathNode.content[0]|trim)}
		{else}
			{set $reverse_path=$reverse_path|prepend($pathNode.text)}
		{/if}
	{else}
		{set $reverse_path=$reverse_path|prepend($pathNode.text)}
	{/if}
{/foreach}
{set-block scope=root variable=site_title}
{foreach $reverse_path as $pathNode}{$pathNode|wash}{delimiter} / {/delimiter}{/foreach}
{/set-block}
	<head>
		<title>{$site_title}</title>
{* Balises META *}
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
{foreach ezini('SiteSettings','MetaDataArray') as $metaName => $value}
		{switch match=$metaName}
			{case match='description'}
				{if $description}
		<meta name="{$metaName}" content="{$description|wash()}" />
				{else}
		<meta name="{$metaName}" content="{$value}" />
				{/if}
			{/case}
			{case match='keywords'}
				{if $keywords}
		<meta name="{$metaName}" content="{$keywords|wash()}" />
				{else}
		<meta name="{$metaName}" content="{$value}" />
				{/if}
			{/case}
			{case}
		<meta name="{$metaName}" content="{$value}" />
			{/case}
		{/switch}
{/foreach}
{* Styles *}
{foreach ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ) as $css_fichier }
		<link rel="stylesheet" type="text/css" href={concat( 'stylesheets/', $css_fichier )|ezdesign} media="all" />
{/foreach}
		<!--[if IE 6]>
			<link rel="stylesheet" type="text/css" href={'stylesheets/main_ie6.css'|ezdesign} media="all" />
		<![endif]-->
		<!--[if IE 8]>
			<link rel="stylesheet" type="text/css" href={'stylesheets/main_ie8.css'|ezdesign} media="all" />
		<![endif]-->
		
		<link rel="stylesheet" type="text/css" href={'stylesheets/print.css'|ezdesign} media="print" />
{* Javascript *}
{foreach ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) as $js_fichier }
	{if eq("http://",$js_fichier|extract_left(7))}
		<script type="text/javascript" src="{$js_fichier}"></script>
	{else}
		<script type="text/javascript" src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
	{/if}
{/foreach}
		{ezscript_load( array('ezjsc::jqueryio'))}
		<script type="text/javascript">
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', '{$googleAccountKey}']);
{literal}
			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
{/literal}
		</script>
	</head>
{undef $title $googleAccountKey $referencement $description $keywords}