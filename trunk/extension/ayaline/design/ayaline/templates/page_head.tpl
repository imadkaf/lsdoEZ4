{def $title = "Les Sables d'Olonne - Site officiel de l'office de tourisme des Sables d'Olonne"}
{if is_set($cNode.node_id)}
	{set $title = concat($cNode.name|wash(), " - ")}
{/if}
{def $referencement = false()}
{def $keywords = false()}
{def $description = false()}
{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
{if is_set($cNode.node_id)}
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
{/if}
	<head>
		<title>{$title|wash()}</title>
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
		<script type="text/javascript" src={concat( 'javascript/', $js_fichier )|ezdesign}></script>
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