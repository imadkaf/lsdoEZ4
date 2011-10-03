{def $title = "Les Sables d'Olonne - Site officiel de l'office de tourisme des Sables d'Olonne"}
{if is_set($cNode.node_id)}
	{set $title = concat($cNode.name|wash(), " - ")}
{/if}
{def $pageTitle = false()}
{def $referencement = false()}
{def $keywords = false()}
{def $description = false()}
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
{foreach $path as $pathNode}
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
{def $chemin = ''}
{if is_set($path.1)}
	{if and(not($path.1.url_alias), not($path.1.url))}
		{set $chemin = $cNode.path_string}
	{else}
		{set $chemin = fetch(content, node, hash(node_path, $path.1.url_alias))}
		{set $chemin = $chemin.path_string}
	{/if}
{/if}
{if eq($chemin, ezini('Chemins', 'Decouvrir', 'ayaline.ini'))}
		<link rel="stylesheet" type="text/css" href={'stylesheets/decouvrir.css'|ezdesign} media="all" />
{/if}
{if eq($chemin, ezini('Chemins', 'Sejourner', 'ayaline.ini'))}
		<link rel="stylesheet" type="text/css" href={'stylesheets/sejourner.css'|ezdesign} media="all" />
{/if}
{if eq($chemin, ezini('Chemins', 'ALaUne', 'ayaline.ini'))}
		<link rel="stylesheet" type="text/css" href={'stylesheets/alaune.css'|ezdesign} media="all" />
{/if}
		<link rel="stylesheet" type="text/css" href={'stylesheets/print.css'|ezdesign} media="print" />
		
{*** Javascript ***}
{* Pour appeller jquery en premier ! *}
{foreach ezini( 'JavaScriptSettings', 'RequiredJavaScriptList', 'design.ini' ) as $js_fichier }
	{if eq("http://",$js_fichier|extract_left(7))}
		<script type="text/javascript" src="{$js_fichier}"></script>
	{else}
		<script type="text/javascript" src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
	{/if}
{/foreach}
{* Ensuite les autres javascripts *}
{foreach ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) as $js_fichier }
	{if eq("http://",$js_fichier|extract_left(7))}
		<script type="text/javascript" src="{$js_fichier}"></script>
	{else}
		<script type="text/javascript" src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
	{/if}
{/foreach}
		{ezscript_load( array('ezjsc::jqueryio'))}
	</head>
{undef $title $referencement $description $keywords}