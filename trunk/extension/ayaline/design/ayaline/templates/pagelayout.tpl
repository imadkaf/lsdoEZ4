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
{else}
	{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
{/if}
{if ezhttp('topics', 'session', 'hasVariable')}
	{def $topicIds = ezhttp('topics', 'session')}
{else}
	{def $topicIds = array()}
{/if}
{def $topicsList = fetch('content','node', hash('node_id',  ezini('NodeSettings','topicListNode','content.ini')))}
{def $curLang = ezini( 'RegionalSettings', 'Locale' )}
{def $nameRubric = ''}
{def $i=0}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
{include uri="design:page_head.tpl"}
	<body>
		<div id="global-page">
			<div id="header">
{include uri='design:full/diaporama.tpl'}
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
	{foreach $rNode.data_map.header_menu.content.main_node.children as $sMenu}
		<li>{node_view_gui content_node=$sMenu view='menu'}</li>
	{/foreach}
{*Gestion des langues*}
								<li class="langue">
									<label for="langue" class="none">{"Langue"|i18n("ayaline/langue")}</label>
									<fieldset class="conteneurSelect" id="langue">
										<div class="inputsSelect">
											<p onclick="showHideSelect('listeSelect1')" class="selects"><span class="Flag_{$curLang|extract_left( 2 )}"></span></p>
											<ul id="listeSelect1">
	{foreach ezini( 'RegionalSettings', 'urlList' ) as $language => $url }
												<li><a onclick="validAndHide('DE', this, 'countryCode', 'p')" href="http://{$url}"><span class="Flag_{$language|extract_left( 2 )}"></span></a></li>
	{/foreach}
											</ul>
										</div>
										<input type="hidden" name="countryCode" />
									</fieldset>
								</li>
{*Gestion des saisons*}
	{foreach $attributes as $attribute}
		{if eq($attribute.identifier,ezini('ClassAttributeSettings','ClassAttributeSeasonIdentifier','content.ini') )}
			{set $nbSaison = $attribute.content.options|count}
			{if $nbSaison}
				{set $nbSaison = $nbSaison|sub(1)}
								<li class="last">
										<ul>
	    		{foreach $attribute.content.options as $key=>$saison}
											<li class="img{$saison.id}{if $key|eq($nbSaison)} last{/if}"><form method="post" action={"/saisons/edit/"|ezurl}><input type="hidden" value={$module_result.uri|ezurl} name="RedirectURI" /><input type="hidden" value="{$saison.id}" name="season_id" /><input{if $saison.id|eq($saisonId)} class="actif"{/if} type="submit" value="" name="" title="{$saison.name}" /></form></li>
				{/foreach}
										</ul>
								</li>
			{/if}
	    {/if}
	{/foreach}
							</ul>
{/if}
							<div class="search">
								<form action={"/content/search/"|ezurl} method="get">
									<label for="Search" class="none">Votre recherche</label>
									<div id="ezautocomplete2">
										<input type="text" name="SearchText" onblur="if(this.value=='')this.value='Votre recherche'" onfocus="if(this.value=='Votre recherche')this.value=''" value="Votre recherche" id="Search" />
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
							<div class="menu">
								<ul>
	{def $mainMenuShowed = false()}
	{foreach $rNode.data_map.main_menu.content.main_node.children as $key => $sMenu sequence array( 'bottom', 'bottom-2', '' ) as $menuStyle}
									<li class="rubrique{$key}">
										<a class="element" href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}><span></span></a>
	{*
		Gestion des sous-menu du menu général
	*}
										<div class="ss-menu">
{if $key|eq(0)}
											<ul class="top">
		{foreach $topicsList.children as $topic}
		{node_view_gui content_node=$topic view=line topicIds=$topicIds redirectURI=$module_result.uri|ezurl}
		{/foreach}
											</ul>
											<div class="clear"></div>
{/if}
											<ul class="{$menuStyle}">
		{foreach $sMenu.children as $nodeSeason}
{*			Sélection de la saison souhaitée*}
			{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
				{if $nodeSeason.data_map.title.value.0|eq($saisonId)}
					{foreach $nodeSeason.children as $subKey => $nodeSub_menu sequence array( '', 'right' ) as $style}
						{set $nameRubric = $nodeSub_menu.name}
						{if ezini('classList','HomeMainMenu','content.ini')|contains($nodeSub_menu.class_identifier)}
							{if $key|eq(2)}
{*								Gestion du menu à la une*}							
								{switch match=$subKey}
									{case match=0}
											<li>
												<div class="border">
										{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassMainMenuIdentifier','content.ini'))}
													{node_view_gui content_node=$nodeSub_menu view=main_focus_menu name=$nameRubric}
										{else}
											<span>Vous devez placer un contenu de type {ezini('ClassSettings','ClassMainMenuIdentifier','content.ini')} à cet emplacement.</span>
										{/if}
												</div>
									{/case}
									{case match=1}
										{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassEmbedCodeIdentifier','content.ini'))}
												{node_view_gui content_node=$nodeSub_menu view=main_focus_menu name=$nameRubric}
										{else}
											<span>Vous devez placer un contenu de type {ezini('ClassSettings','ClassEmbedCodeIdentifier','content.ini')} à cet emplacement.</span>
										{/if}
											</li>
									{/case}
									{case match=2}
											<li class="right">
										{if $nodeSub_menu.class_identifier|eq(ezini('ClassSettings','ClassSubMenuIdentifier','content.ini'))}
												{node_view_gui content_node=$nodeSub_menu.data_map.content.content.main_node view=main_focus_menu name=$nameRubric}
										{else}
											<span>Vous devez placer un contenu de type {ezini('ClassSettings','ClassSubMenuIdentifier','content.ini')} à cet emplacement.</span>
										{/if}
											</li>
									{/case}
								{/switch}
							{else}
{*								Gestion de l'affichage des items en fonction des thèmes*}
								{if $topicIds|count}
									{if $nodeSub_menu.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
										{if $nodeSub_menu.data_map.content.content.main_node.data_map.topics.content.relation_list|count}
											{foreach $nodeSub_menu.data_map.content.content.main_node.data_map.topics.content.relation_list as $relation}
												{foreach $topicIds as $topicId}
													{if $relation.node_id|eq($topicId)}
														{set $mainMenuShowed = true()}
														{if 1|eq($topicIds|count)}
															{set $nameRubric = $nodeSub_menu.data_map[concat('title_topic_', $topicId)].value}
														{/if}
														{break}
													{/if}
												{/foreach}
											{/foreach}
										{else}
											{set $mainMenuShowed = true()}
										{/if}
									{else}
										{set $mainMenuShowed = true()}
									{/if}
								{else}
									{set $mainMenuShowed = true()}
								{/if}
								{if $mainMenuShowed}
									{set $i=inc( $i )}
													<li class="{$style}{if or($i|eq(1), $i|eq(2))} first{/if}">
	{node_view_gui content_node=$nodeSub_menu.data_map.content.content.main_node view=main_menu name=$nameRubric}
													</li>
									{set $mainMenuShowed = false()}
								{/if}
							{/if}
						{/if}
					{/foreach}
					{break}	
				{/if}
			{/if}
		{/foreach}
											</ul>
										</div>
									</li>
	{/foreach}
								</ul>
							</div>
{/if}
						</div>	
						<div class="clear"></div>				
					</div>
				</div>
{include uri='design:parts/diaporama.tpl'}
			</div>
			<div class="clear"></div>
{if is_set($cNode.node_id)}
	{if ne($cNode.node_id, 2)}
				<p class="fil-ariane">
		{foreach $module_result.path as $Path}
			{if $Path.url}
					<a href={$Path.url_alias|ezroot}>{$Path.text|wash}</a> >
			{else}
					<strong>{$Path.text|wash}</strong>
			{/if}
		{/foreach}
				</p>
	{/if}
{/if}
			
			<div class="content">
{$module_result.content}
{include uri="design:page_footer.tpl"}
			</div>
		</div>
	</body>
</html>
{undef $cNode $rNode $attributes $nbSaison $saison $curLang $topicsList $nameRubric $i}