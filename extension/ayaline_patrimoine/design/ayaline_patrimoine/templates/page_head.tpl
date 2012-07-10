{def $title = ezini('SiteSettings','SiteName')}
{foreach $module_result.path as $key => $item}
	{if $key|gt(0)}{set $title = $item.text|append(' | ', $title)}{/if}
{/foreach}
{def $referencement = false()}
{def $keywords = false()}
{def $description = false()}
{*def $cNode = fetch('content','node', hash('node_id',$module_result.node_id))*}
{if is_set($cNode.data_map.referencement)}
	{set $referencement = $cNode.data_map.referencement}
	{if $referencement.content[0]|trim|ne('')}
		{set $title = $referencement.content[0]|trim}
	{/if}
	{if $referencement.content[1]|trim|ne('')}
		{set $keywords = $referencement.content[1]|trim}
	{/if}
	{if $referencement.content[2]|trim|ne('')}
		{set $description = $referencement.content[2]|trim}
	{/if}
{/if}
	<head>
		<!-- PAGE TITLE -->
		<title>{$title}</title>
		<!-- METAS -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	    <meta name="viewport" content="width=device-width, user-scalable=no" />
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
			{case match='author'}
			{/case}
			{case match='copyright'}
			{/case}
			{case}
		<meta name="{$metaName}" content="{$value}" />
			{/case}
		{/switch}
{/foreach}

<link type="image/x-icon" href={'favicon.ico'|ezimage()} rel="icon" />
<!-- STYLESHEET -->
{foreach ezini( 'StylesheetSettings', 'CSSFileListPatrimoine', 'design.ini' )|unique as $css_fichier }
		<link rel="stylesheet" type="text/css" href={concat('stylesheets/', $css_fichier )|ezdesign} media="all" />
{/foreach}
<!-- JAVASCRIPT -->
{* Pour appeller jquery en premier *}
{foreach ezini( 'JavaScriptSettings', 'RequiredJavaScriptListPatrimoine', 'design.ini' ) as $js_fichier }
	{if eq("http://",$js_fichier|extract_left(7))}
            <script src="{$js_fichier}"></script>
        {else}
            <script src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
        {/if}
{/foreach}
{foreach ezini( 'JavaScriptSettings', 'JavaScriptListPatrimoine', 'design.ini' )|unique as $js_fichier }
		<script type="text/javascript" src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
{/foreach}
	</head>
{undef $title $cNode $referencement $description $keywords}