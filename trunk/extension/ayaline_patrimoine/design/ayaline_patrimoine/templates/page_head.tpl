{* Récupération des informations pour les balises META *}
{def $referencement = false()}
{def $title = false()}
{def $keywords = false()}
{def $description = false()}
{if is_set($cNode.data_map.referencement)}
    {set $referencement = $cNode.data_map.referencement}
{if $referencement.content[0]|trim|ne('')}{set $title = $referencement.content[0]|trim}{/if}
{if $referencement.content[1]|trim|ne('')}{set $keywords = $referencement.content[1]|trim}{/if}
{if $referencement.content[2]|trim|ne('')}{set $description = $referencement.content[2]|trim}{/if}
{/if}
	<head>
		{* Titre de la page *}
		{if $title|trim|ne('')}
		    <title>{$title|wash()} | D'Code Les Sables</title>
		{else}
		    {if is_set($cNode.node_id)}
		        {set $title = supp_br($cNode.name)}
		        <title> {if $title|ne(false())}{$title|wash} | Site mobile découverte du patrimoine des Sables d'Olonne{/if}</title>
		    {else}
		        <title>{ezini('SiteSettings', 'SiteName' ,'site.ini')} | Site mobile découverte du patrimoine des Sables d'Olonne</title>
		    {/if}
		{/if}


		<!-- METAS -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta name="viewport" content="width=device-width, user-scalable=no" />
		{* Balises META *}
		<meta name="description" content="{$description|wash}" />
		<meta name="keywords" content="{$keywords|wash}" />

<link type="image/x-icon" href={'favicon.ico'|ezimage()} rel="icon" />
<!-- STYLESHEET -->
{foreach ezini( 'StylesheetSettings', 'CSSFileListPatrimoine', 'design.ini' )|unique as $css_fichier }
		<link rel="stylesheet" type="text/css" href={concat('stylesheets/', $css_fichier )|ezdesign} media="all" />
{/foreach}
<!-- JAVASCRIPT -->
<script src={'javascript/klass.min.js'|ezdesign}></script>
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


{if eq($cNode.class_identifier,'smp_accueil')}
	{if getcookie()}
	<script type="text/javascript" src={'javascript/ajouter_ecran_accueil.js'|ezdesign}></script>
	{/if}
{/if}
{if $module_result.content_info.class_identifier|eq(ezini('Class_declinaison', 'Class_circuit' ,'ayaline_patrimoine.ini'))}
	{def $circuitNode = fetch(content, node, hash(node_id, $module_result.node_id))}
	{def $fichiercss = $circuitNode.data_map.declinaison_circuit.content.current.data_map.fichier_css.value|trim|wash}
	<link rel="stylesheet" type="text/css" href={concat('stylesheets/', $fichiercss)|ezdesign} media="all" />
{elseif $module_result.content_info.class_identifier|eq(ezini('Class_declinaison', 'Class_PI' ,'ayaline_patrimoine.ini'))}
	{def $circuitNode = fetch(content, node, hash(node_id, $module_result.content_info.parent_node_id))}
	{def $fichiercss = $circuitNode.data_map.declinaison_circuit.content.current.data_map.fichier_css.value|trim|wash}
	<link rel="stylesheet" type="text/css" href={concat('stylesheets/', $fichiercss)|ezdesign} media="all" />
{/if}
<script>
    {literal}
    
           $(document).live("mobileinit", function(){
               $.mobile.ajaxLinksEnabled = false;
               $.mobile.ajaxFormsEnabled = false;
               $.mobile.ajaxEnabled = false;
           });    
               {/literal}
       </script>
	</head>
{undef $title $referencement $description $keywords}