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
				{$node.name}
			</h2>
			<p class="clear"></p>
			<br /><br />

			{def $affListeSITPlan = ''}

			{if $menuItemsArray|count}
				<ul class="sitemap-content-list">
					{foreach $menuItemsArray as $menuItem}
						<li class="sitemap-li-first-level-content-list">
							{* Cas d'une liste SIT *}
							{if eq($menuItem.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
								{set $affListeSITPlan = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $menuItem.contentobject_id,
																											'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
								{set $affListeSITPlan = $affListeSITPlan.0}
								<a href={$menuItem.url_alias|ezurl()}>{$affListeSITPlan.name}</a>
							{else}
								<a href={$menuItem.url_alias|ezurl()}>{$menuItem.name}</a>
							{/if}
							
							{* menu : level 2 *}
							{set $sousMenuItemsArray = fetch_alias('sitemap',hash('parent_node_id', $menuItem.node_id))}
							
							{if $sousMenuItemsArray|count}
								<ul>
									{foreach $sousMenuItemsArray as $sousMenuItem}
										<li>
											{* Cas d'une liste SIT *}
											{if eq($sousMenuItem.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
												{set $affListeSITPlan = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $sousMenuItem.contentobject_id,
																															'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
												{set $affListeSITPlan = $affListeSITPlan.0}
												<a href={$sousMenuItem.url_alias|ezurl()}>{$affListeSITPlan.name}</a>
											{else}
												<a href={$sousMenuItem.url_alias|ezurl()}>{$sousMenuItem.name}</a>
											{/if}
										
											{* menu : level 3 *}
											{set $sousSousMenuItemsArray = fetch_alias('sitemap',hash('parent_node_id', $sousMenuItem.node_id))}
											
											{if $sousSousMenuItemsArray|count}
												<ul>
													{foreach $sousSousMenuItemsArray as $sousSousMenuItem}
														<li>
															{* Cas d'une liste SIT *}
															{if eq($sousSousMenuItem.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
																{set $affListeSITPlan = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $sousSousMenuItem.contentobject_id,
																																			'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
																{set $affListeSITPlan = $affListeSITPlan.0}
																<a href={$sousSousMenuItem.url_alias|ezurl()}>{$affListeSITPlan.name}</a>
															{else}
																<a href={$sousSousMenuItem.url_alias|ezurl()}>{$sousSousMenuItem.name}</a>
															{/if}
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