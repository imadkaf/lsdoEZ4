{def $cache_hash = array($module_result.uri)}
{foreach ezhttp().get|merge(ezhttp().post) as $req_param_key => $req_param_val}
	{if $req_param_val|get_type|begins_with('array')}
		{foreach $req_param_val as $req_param_val_key => $req_param_val_val}
			{if $req_param_val_val|get_type|begins_with('array')}
				{set $cache_hash = $cache_hash|append(concat($req_param_key, '[', $req_param_val_key, ']', '=>', $req_param_val_val|implode('_')))}
			{else}
				{set $cache_hash = $cache_hash|append(concat($req_param_key, '[', $req_param_val_key, ']', '=>', $req_param_val_val))}
			{/if}
		{/foreach}
	{else}
		{set $cache_hash = $cache_hash|append(concat($req_param_key, '=>', $req_param_val))}
	{/if}
{/foreach}
{foreach ezhttp().session as $session_key => $session_val}
	{if or($session_key|begins_with('sit_'), $session_key|eq('saison'), $session_key|eq('eZUserLoggedInID'))}
		{set $cache_hash = $cache_hash|append(concat($session_key, '=>', $session_val))}
	{elseif $session_key|eq('topics')}
		{set $cache_hash = $cache_hash|append(concat($session_key, '=>', $session_val|implode('_')))}
	{/if}
{/foreach}

{def $timestamp=currentdate()}

{def $cNode = array()}
{if is_set($module_result.node_id)}
	{set $cNode = fetch(content, node, hash(node_id, $module_result.node_id))}
{/if}
{def $rNode = fetch('content','node', hash('node_id',  ezini('NodeSettings','RootNode','content.ini')))}
{def $attributes=fetch( 'class', 'attribute_list', hash( 'class_id', ezini('ClassSettings','ClassSeasonId','content.ini') ) )}
{def $nbSaison = 0}
{def $saison = array()}
{*Gestion du menu déroulant*}
{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonId = ezhttp('saison', 'session')}
	{def $saisonEnSession = true()}
{else}
	{*si pas de saison sélectionné : c'est l'été la saison par défaut *}
	{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
	{def $saisonEnSession = false()}
{/if}
{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
	{def $topicIds = ezhttp('topics', 'session')}
{else}
	{def $topicIds = array(ezini('NodeSettings','TopicDefaut','content.ini'))}
{/if}
{* récupération des themes (mer / ville / plage / nature dans le dossier Configuration Generale -> Themes *}
{def $topicsList = fetch('content','node', hash('node_id',  ezini('NodeSettings','topicListNode','content.ini')))}

{def $curLang = ezini( 'RegionalSettings', 'Locale' )}
{def $nameRubric = ''}
{def $diaporamas = array()}
{def $i=0}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
{include uri="design:header.tpl"}
	<body>
		<div id="global-page">
			<div id="header">
{cache-block keys=$cache_hash}
{include uri='design:full/diaporama.tpl'}
{/cache-block}
				<div class="header-in">
					<div class="header-content">
						<h1>
							<span class="style-png">							
								<a href={$rNode.url_alias|ezurl}>
									<img class="home-title" src="/makeImage/makeImage.php?lsdo=o1&amp;t={$rNode.data_map.title.data_text}" alt="{$rNode.data_map.title.data_text}" />
									<br />
									<img src={"logo_accueil.png"|ezimage} alt="" />
									<img class="home-grip" src="/makeImage/makeImage.php?lsdo=o2&amp;t={$rNode.data_map.grip.data_text}" alt="{$rNode.data_map.grip.data_text}" />
								</a>
							</span>
						</h1>
						<div class="header-in-right">
{if $rNode.data_map.header_menu.has_content}
							<ul class="list-top">
								<li class="first">{$timestamp|datetime(custom, '%l %d %F %Y')}</li>
								{if ne($current_user.contentobject_id, $anonymous_user_id)}
									<li style="margin-right: 10px;"><a href={'user/logout'|ezurl}>{"Logout"|i18n("ayaline")}</a></li>
								{/if}
{cache-block keys=$cache_hash}
	{foreach $rNode.data_map.header_menu.content.main_node.children as $sMenu}
		<li>{node_view_gui content_node=$sMenu view='menu'}</li>
	{/foreach}
{/cache-block}
{*Gestion des langues*}
								<li class="langue">
									<label for="langue" class="none">{"Langue"|i18n("ayaline/langue")}</label>
									<fieldset class="conteneurSelect" id="langue">
										<div class="inputsSelect">
											<!-- <p onclick="showHideSelect('listeSelect1')" class="selects"><span class="Flag_{$curLang|extract_left( 2 )}"></span></p>-->
											<ul id="listeSelect1">
	{foreach ezini( 'RegionalSettings', 'UrlList' ) as $language => $url}
												<li><a href="http://{$url}"><span class="Flag_{$language|extract_left( 2 )}"></span></a></li>
	{/foreach}
											</ul>
										</div>
										<input type="hidden" name="countryCode" />
									</fieldset>
								</li>
								
								<div id="google_translate_element" style="float:left; margin:0px 15px 0px 0px; width: 196px;"></div>
								<script>
								{literal}
									function googleTranslateElementInit() {
									  new google.translate.TranslateElement({
									    pageLanguage: 'fr',
										autoDisplay: false,
									    layout: google.translate.TranslateElement.InlineLayout.SIMPLE
									  }, 'google_translate_element');
									}
								{/literal}
								</script>
								<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

{*Gestion des saisons*}
{cache-block keys=$cache_hash}
	{foreach $attributes as $attribute}
		{if eq($attribute.identifier,ezini('ClassAttributeSettings','ClassAttributeSeasonIdentifier','content.ini') )}
			{set $nbSaison = $attribute.content.options|count}
			{if $nbSaison}
				{set $nbSaison = $nbSaison|sub(1)}
								<li class="last">
										<ul>
	    		{foreach $attribute.content.options as $key=>$saison}
											<li class="img{$saison.id}{if $key|eq($nbSaison)} last{/if}"><form method="post" action={"/saisons/edit/"|ezurl}><input type="hidden" value={$module_result.uri|ezurl} name="RedirectURI" /><input type="hidden" value="{$saison.id}" name="season_id" /><input{if and($saisonEnSession,$saison.id|eq($saisonId))} class="actif"{/if} type="submit" value="" name="{$saison.name}" title="{concat($saison.name,' picto')|i18n('ayaline')}" /></form></li>
				{/foreach}
										</ul>
								</li>
			{/if}
	    {/if}
	{/foreach}
{/cache-block}

								<li class="icone-aide-saison">
									<img alt="{'Navigation Helper'|i18n('ayaline')}" src={"aide-navigation.png"|ezimage}>
								</li>
							</ul>
{/if}
							<div class="search">
								<form action={"/content/search/"|ezurl} method="get">
									<label for="Search" class="none">{"Your search"|i18n("ayaline")}</label>
									<div id="ezautocomplete2">
										<input type="text" name="SearchText" onblur="if(this.value=='')this.value='{"Your search"|i18n("ayaline")}'" onfocus="if(this.value=='{"Your search"|i18n("ayaline")}')this.value=''" value="{"Your search"|i18n("ayaline")}" id="Search" />
										<button type="submit"><span class="none">OK</span></button>
										<div id="ezautocompletecontainer2"></div>
									</div>
									
								</form>
								
								{ezscript_require( array('ezjsc::yui2', 'ezajax_autocomplete.js') )}
								<script type="text/javascript">
									jQuery('#ezautocompletecontainer2').css('width', jQuery('input#Search').width());
									var ezAutoHeader = eZAJAXAutoComplete();
									ezAutoHeader.init({ldelim}
									    url: "{'ezjscore/call/ezfind::autocomplete'|ezurl('no')}",
									    inputid: 'Search',
									    containerid: 'ezautocompletecontainer2',
									    minquerylength: {ezini( 'AutoCompleteSettings', 'MinQueryLength', 'ezfind.ini' )},
									    resultlimit: {ezini( 'AutoCompleteSettings', 'Limit', 'ezfind.ini' )}
									{rdelim});
								</script>
								
							</div>
							<div class="clear"></div>

{if $rNode.data_map.main_menu.has_content}
	{include uri='design:parts/menu_header.tpl'}
{/if}

						</div>	
						<div class="clear"></div>				
					</div>
				</div>
{cache-block keys=$cache_hash}
{include uri='design:parts/diaporama.tpl'}
{/cache-block}
			</div>
			<div class="clear"></div>
			{include uri='design:parts/fil_ariane.tpl'}
			<div class="content">
{def $additional_cache_hash = array()}
{if and($cNode|is_set, $cNode.object.content_class.identifier|eq('sit_liste'))}
	{if and($cNode.object.data_map.criteres_tri_principaux.content|is_set, or($cNode.object.data_map.criteres_tri_principaux.content|contains('a2'), $cNode.object.data_map.criteres_tri_principaux.content|contains('d2')))}
		{set $additional_cache_hash = $additional_cache_hash|append(rand())}
	{/if}
{/if}
{cache-block keys=$cache_hash|merge($additional_cache_hash)}
{* Popup d'aide des saisons *}
<div id="dialog" title="{'Navigation Helper'|i18n('ayaline')}" class="none">
	{attribute_view_gui attribute = $rNode.data_map.aide_saison}
</div>
{* Fin popup *}
{$module_result.content}
{/cache-block}
{cache-block keys=$cache_hash}
{include uri="design:page_footer.tpl"}
{/cache-block}
{undef $additional_cache_hash}
			</div>
		</div>
		<script type="text/javascript">
		{literal}
		/*$('.content img').lazyload({effect: "fadeIn"});*/
		if (typeof equilibre != 'undefined') {
			$('.content img').load(function () {
				equilibrerHauteursBlocs();
			});
		}
		{/literal}
		</script>
{def $googleAccountKey = ezini('TagsGA','googleAccountKey','ezurlga.ini')}
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
	</body>
</html>
{undef $cNode $rNode $attributes $nbSaison $saison $curLang $topicsList $nameRubric $i $cache_hash}