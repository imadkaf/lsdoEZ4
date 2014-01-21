{def $title = "Les Sables d'Olonne - Site officiel de l'office de tourisme des Sables d'Olonne"}
{if is_set($cNode.node_id)}
	{set $title = concat($cNode.name|wash(), " - ")}
{/if}
{def $pageTitle = false()}
{def $referencement = false()}
{def $keywords = false()}
{def $description = false()}
{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
{if is_set($cNode.data_map.referencement)}
	{set $referencement = $cNode.data_map.referencement}
	{if $referencement.content[0]|trim|ne('')}
		{set $page = $referencement.content[1]|trim}
	{/if}
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
{/if}
{def $cPathNode = false()}
{def $pathUrl = false()}
{def $titreChemin = ''}
{foreach $path as $pathNode}
	{if $pathNode.node_id|eq( ezini('NodeSettings','ContentRootNode','content.ini') )}
		{continue}
	{/if}
	{if and(not($pathNode.url_alias), not($pathNode.url))}
		{set $cPathNode = $cNode}
	{else}
		{set $cPathNode = fetch(content, node, hash(node_path, $pathNode.url_alias))}
	{/if}
	{if is_set($cPathNode.data_map.referencement)}
		{def $referencementPathNode = $cPathNode.data_map.referencement}
		{if $referencementPathNode.content[0]|trim|ne('')}
			{set $reverse_path=$reverse_path|prepend($referencementPathNode.content[0]|trim)}
		{else}
			{if eq($pathNode.node_id, ezini('NodeSettings','RootNode','content.ini'))}
				{set $titreChemin = "Les Sables d'Olonne"}
			{else}
				{set $titreChemin = $pathNode.text}
			{/if}
			{set $reverse_path=$reverse_path|prepend($titreChemin)}
		{/if}
	{else}
		{if eq($pathNode.node_id, ezini('NodeSettings','RootNode','content.ini'))}
			{set $titreChemin = "Les Sables d'Olonne"}
		{else}
			{set $titreChemin = $pathNode.text}
		{/if}
		{set $reverse_path=$reverse_path|prepend($titreChemin)}
	{/if}
{/foreach}
{set-block scope=root variable=site_title}
{foreach $reverse_path as $pathNode}{$pathNode|wash}{delimiter} / {/delimiter}{/foreach}
{/set-block}
	<head>
		<!-- PAGE TITLE -->
		<title>{$site_title}</title>
		
		<!-- METAS -->
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
		{foreach ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ) as $css_fichier }
			{if eq("http://",$css_fichier|extract_left(7))}
				<link rel="stylesheet" type="text/css" href="{$css_fichier}" />
			{else}
				<link rel="stylesheet" type="text/css" href={concat( 'stylesheets/', $css_fichier )|ezdesign} />
			{/if}
		{/foreach}	
	
		<script type="text/javascript">
			if (navigator.userAgent.indexOf('iPhone') != -1) {ldelim}
				{foreach ezini( 'StylesheetSettings', 'FrontendCSSFileListiPhone', 'design.ini' ) as $css_fichier }
					document.write('<link rel="stylesheet" href={concat( 'stylesheets/', $css_fichier )|ezdesign} type="text/css" />');
				{/foreach}	
			{rdelim} else if (navigator.userAgent.indexOf('Android') != -1) {ldelim}
				{foreach ezini( 'StylesheetSettings', 'FrontendCSSFileListAndroid', 'design.ini' ) as $css_fichier }
					document.write('<link rel="stylesheet" href={concat( 'stylesheets/', $css_fichier )|ezdesign} type="text/css" />');
				{/foreach}	
			{rdelim} else if (navigator.userAgent.indexOf('BlackBerry') != -1) {ldelim}
				{foreach ezini( 'StylesheetSettings', 'FrontendCSSFileListBB', 'design.ini' ) as $css_fichier }
					document.write('<link rel="stylesheet" href={concat( 'stylesheets/', $css_fichier )|ezdesign} type="text/css" />');
				{/foreach}	
			{rdelim} else {ldelim}
				{foreach ezini( 'StylesheetSettings', 'FrontendCSSFileListPC', 'design.ini' ) as $css_fichier }
					document.write('<link rel="stylesheet" href={concat( 'stylesheets/', $css_fichier )|ezdesign} type="text/css" />');
				{/foreach}	
			{rdelim}
		</script>
		{foreach ezini( 'JavaScriptSettings', 'JavaScriptListMobile', 'design.ini' ) as $js_fichier }
			{if eq("http://",$js_fichier|extract_left(7))}
				<script type="text/javascript" charset="utf-8" src="{$js_fichier}"></script>
			{else}
				<script type="text/javascript" src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
			{/if}
		{/foreach}
		<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<link rel="apple-touch-icon" href="apple-touch-icon-57x57.png" />
<link rel="apple-touch-icon" sizes="72x72" href="apple-touch-icon-72x72.png" />
<link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-114x114.png" />
<link rel="apple-touch-startup-image" href="apple-touch-startup-image-320x460.png" />
<link rel="apple-touch-startup-image" sizes="768x1004" href="apple-touch-startup-image-768x1004.png" />
	</head>
{undef $title $googleAccountKey $referencement $description $keywords}
