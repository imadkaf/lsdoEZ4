{def $cNode = fetch(content, node, hash(node_id, $module_result.node_id))}
{def $rNode = fetch('content','node', hash('node_id',  ezini('NodeSettings','RootNode','content.ini')))}
{def $sMenus = array()}
{def $attributes=fetch( 'class', 'attribute_list', hash( 'class_id', ezini('ClassSettings','ClassSeasonId','content.ini') ) )}
{def $nbSaison = 0}
{*Gestion du menu déroulant*}
{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonId = ezhttp('saison', 'session')}
{else}
	{def $saisonId = -1}
{/if}
{def $curLang = ezini( 'RegionalSettings', 'Locale' )}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
{include uri="design:page_head.tpl"}
	<body>
		<div id="global-page">
			<div id="header">
{include uri='design:full/diaporama.tpl'}
				<div class="header-in">
					<h1>
						<div class="style-png">							
							<a href={$rNode.url_alias|ezurl}>
								<img class="home-title" src="/makeImage/makeImage.php?lsdo=o1&t={$rNode.data_map.title.data_text}" alt="{$rNode.data_map.title.data_text}" />
								<br />
								<img src={"logo_accueil.png"|ezimage} alt="" />
								<img class="home-grip" src="/makeImage/makeImage.php?lsdo=o2&t={$rNode.data_map.grip.data_text}" alt="{$rNode.data_map.grip.data_text}" />
							</a>
						</div>
					</h1>
					<div class="header-in-right">
{if $rNode.data_map.header_menu.has_content}
	{set $sMenus = fetch('content', 'list', hash('parent_node_id', $rNode.data_map.header_menu.content.main_node_id, 'sort_by', $rNode.data_map.header_menu.content.main_node.sort_array))}
						<ul class="list-top">
	{foreach $sMenus as $sMenu}
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
	{set $sMenus = fetch('content', 'list', hash('parent_node_id', $rNode.data_map.main_menu.content.main_node_id, 'sort_by', $rNode.data_map.main_menu.content.main_node.sort_array, 'limit', 3))}
						<div class="menu">
							<ul>
	{foreach $sMenus as $key => $sMenu}
								<li class="rubrique{$key}">
									<a href={$sMenu.data_map.content.content.main_node.url_alias|ezurl}><span></span></a>
								</li>
	{/foreach}
							</ul>
						</div>
{/if}
					</div>					
				</div>
{include uri='design:parts/diaporama.tpl'}
			</div>
			<div class="clear"></div>
			<div class="content">
{$module_result.content}
			</div>
		</div>
	</body>
</html>
{undef $cNode $rNode $sMenus $attributes $nbSaison $saison $curLang}