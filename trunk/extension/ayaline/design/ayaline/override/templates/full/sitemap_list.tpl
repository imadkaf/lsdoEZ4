{set-block scope=root variable=cache_ttl}0{/set-block}

{def $nbPubs = 5}

{* Récupération des sous-contenus (3 niveaux en tout) *}
{def $menuItemsArray = fetch_alias('sitemap',hash('parent_node_id', ezini('NodeSettings', 'RootNode', 'content.ini')))}

{def $sousMenuItemsArray = array()}
{def $sousSousMenuItemsArray = array()}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>

	<div class="bloc-right-in-bis">
		<div class="bloc-type site-map">
			<h2 class="bloc-liste-h2">
				{$node.name|wash}
			</h2>
			<p class="clear"></p>
			<br /><br />

			{if $menuItemsArray|count}
				<ul class="sitemap-content-list">
					{foreach $menuItemsArray as $menuItem}
						{*$menuItem|attribute(show)*}
						{* Cas du noeud A la Une *}
						{if eq($menuItem.node_id, ezini('Noeuds','Alaune','ayaline.ini'))}
							{continue}
						{/if}
						
						<li class="sitemap-li-first-level-content-list">
							<a href={$menuItem.url_alias|ezurl()}>{$menuItem.name|wash}</a>
							
							{* menu : level 2 *}
							{set $sousMenuItemsArray = fetch_alias('sitemap',hash('parent_node_id', $menuItem.node_id))}
							
							{if $sousMenuItemsArray|count}
								<ul>
									{foreach $sousMenuItemsArray as $sousMenuItem}
										<li>
											<a href={$sousMenuItem.url_alias|ezurl()}>{$sousMenuItem.name|wash}</a>
										
											{* menu : level 3 *}
											{set $sousSousMenuItemsArray = fetch_alias('sitemap',hash('parent_node_id', $sousMenuItem.node_id))}
											
											{if $sousSousMenuItemsArray|count}
												<ul>
													{foreach $sousSousMenuItemsArray as $sousSousMenuItem}
														<li>
															<a href={$sousSousMenuItem.url_alias|ezurl()}>{$sousSousMenuItem.name|wash}</a>
														</li>
													{/foreach}
												</ul>
											{/if}
										</li>
									{/foreach}
								</ul>
							{/if}
						</li>
					{/foreach}
				</ul>
			{/if}
		</div>
	</div>
</div>

{undef $menuItemsArray $sousMenuItemsArray $sousSousMenuItemsArray}

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>