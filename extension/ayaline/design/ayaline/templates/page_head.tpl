<head>
	<title>Accueil &ndash; Les Sables d'Olonne</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	{* Styles *}
	{foreach ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ) as $css_fichier }
	<link rel="stylesheet" type="text/css" media="all" href={concat( 'stylesheets/', $css_fichier )|ezdesign} />
	{/foreach}
	<script src={"javascripts/jquery.js"|ezdesign} type="text/javascript"></script>
	<script src={"javascripts/scripts.js"|ezdesign} type="text/javascript"></script>

	<!--[if IE 6]>
		<link rel="stylesheet" type="text/css" href={"stylesheets/main_ie6.css"|ezdesign} media="all" />
	<![endif]-->
	<!--[if IE 8]>
		<link rel="stylesheet" type="text/css" href={"stylesheets/main_ie8.css"|ezdesign} media="all" />
	<![endif]-->
	
	{* Head template *}
	{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
	{literal}
	<script type="text/javascript">
	
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', '{/literal}{$googleAccountKey}{literal}']);
	
	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
	</script>
	{/literal}
	{undef $googleAccountKey}
	
</head>