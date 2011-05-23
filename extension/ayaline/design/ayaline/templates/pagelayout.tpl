{def $cNode = fetch(content, node, hash(node_id, $module_result.node_id))}
{def $rNode = fetch('content','node', hash('node_id',  ezini('NodeSettings','RootNode','content.ini')))}
{def $attributes=fetch( 'class', 'attribute_list', hash( 'class_id', ezini('ClassSettings','ClassSeasonId','content.ini') ) )}
{def $nbSaison = 0}
{def $saison = array()}
{*Gestion du menu déroulant*}
{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonId = ezhttp('saison', 'session')}
{else}
	{def $saisonId = ezini('main','defaultSeasonId','lsdo.ini')}
{/if}
{if ezhttp('topics', 'session', 'hasVariable')}
	{def $topicIds = ezhttp('topics', 'session')}
{else}
	{def $topicIds = array()}
{/if}
{def $topicsList = fetch('content','node', hash('node_id',  ezini('NodeSettings','topicListNode','content.ini')))}
{def $curLang = ezini( 'RegionalSettings', 'Locale' )}
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
									<img class="home-title" src="/makeImage/makeImage.php?lsdo=o1&t={$rNode.data_map.title.data_text}" alt="{$rNode.data_map.title.data_text}" />
									<br />
									<img src={"logo_accueil.png"|ezimage} alt="" />
									<img class="home-grip" src="/makeImage/makeImage.php?lsdo=o2&t={$rNode.data_map.grip.data_text}" alt="{$rNode.data_map.grip.data_text}" />
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
								<form method="post" action="#">
									<label for="recherche" class="none">Votre recherche</label>
									<input type="text" name="recherche" onblur="if(this.value=='')this.value='Votre recherche'" onfocus="if(this.value=='Votre recherche')this.value=''" value="Votre recherche" id="recherche" />
									<button type="submit"><span class="none">OK</span></button>
								</form>
							</div>
							<div class="clear"></div>
{if $rNode.data_map.main_menu.has_content}
							<div class="menu">
								<ul>
	{def $mainMenuShowed = false()}
	{foreach $rNode.data_map.main_menu.content.main_node.children as $key => $sMenu}
									<li class="rubrique{$key}">
										<a class="element" href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}><span></span></a>
{*
	Gestion des sous-menu du menu général
*}
										<div class="ss-menu">
											<ul class="top">
{foreach $topicsList.children as $topic}
{node_view_gui content_node=$topic view=line topicIds=$topicIds redirectURI=$module_result.uri|ezurl}
{/foreach}
											</ul>
											<div class="clear"></div>
											<ul class="bottom">
{foreach $sMenu.children as $nodeSeason}
	{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
		{if $nodeSeason.data_map.title.value.0|eq($saisonId)}
			{foreach $nodeSeason.children as $nodeRubric sequence array( '', 'right' ) as $style}
				{if $nodeRubric.class_identifier|eq(ezini('ClassSettings','ClassSubMenuIdentifier','content.ini'))}
					{if $topicIds|count}
						{if $nodeRubric.data_map.content.content.main_node.class_identifier|eq(ezini('ClassSettings','ClassRubricIdentifier','content.ini'))}
							{if $nodeRubric.data_map.content.content.main_node.data_map.topics.content.relation_list|count}
								{foreach $nodeRubric.data_map.content.content.main_node.data_map.topics.content.relation_list as $relation}
									{foreach $topicIds as $topicId}
										{if $relation.node_id|eq($topicId)}
											{set $mainMenuShowed = true()}
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
												<li class="{$style}">
{node_view_gui content_node=$nodeRubric.data_map.content.content.main_node view=main_menu}
												</li>
						{set $mainMenuShowed = false()}
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
			
			<div class="content">
{$module_result.content}
{include uri="design:page_footer.tpl"}
			</div>
		</div>
	</body>
</html>
{undef $cNode $rNode $attributes $nbSaison $saison $curLang $topicsList}