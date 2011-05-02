{def $title = concat($cNode.name|wash(), " - Les Sables d'Olonne - Site officiel de l'office de tourisme des Sables d'Olonne")}
{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
	<head>
		<title>{$title|wash()}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
{* Javascript *}
{foreach ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) as $js_fichier }
		<script type="text/javascript" src={concat( 'javascripts/', $js_fichier )|ezdesign}></script>
{/foreach}
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
{undef $title $googleAccountKey}