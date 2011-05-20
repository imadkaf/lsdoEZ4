{* Sitemap list view *}

{set-block scope=root variable=cache_ttl}0{/set-block}

{* Récupération des sous-contenus (3 niveaux en tout) *}
{def $menuItemsArray = fetch_alias('sitemap',hash('parent_node_id', ezini('NodeSettings', 'RootNode', 'content.ini')))}

{def $sousMenuItemsArray = array()}
{def $sousSousMenuItemsArray = array()}

<div id="sitemap-content-page" class="sitemap-content-page-big">
	<div class="sitemap-top-content-page">
		{include uri='design:parts/fil_ariane.tpl' }
		{include uri='design:parts/tooltip.tpl' }
	</div>
	<h2>{$node.name}</h2>

{if $menuItemsArray|count}
	<ul class="sitemap-content-list">
	{foreach $menuItemsArray as $menuItem}
		<li class="sitemap-li-first-level-content-list">
			<a href={$menuItem.url_alias|ezurl()}>{$menuItem.name|wash()}</a>
			
			{* menu : level 2 *}
			{set $sousMenuItemsArray = fetch_alias('sitemap',hash('parent_node_id', $menuItem.node_id))}
			{if $sousMenuItemsArray|count}
			<ul>
				{foreach $sousMenuItemsArray as $sousMenuItem}
				<li>
					<a href={$sousMenuItem.url_alias|ezurl()}>{$sousMenuItem.name|wash()}</a>
					
					{* menu : level 3 *}
					{set $sousSousMenuItemsArray = fetch_alias('sitemap',hash('parent_node_id', $sousMenuItem.node_id))}
					{if $sousSousMenuItemsArray|count}
					<ul>
						{foreach $sousSousMenuItemsArray as $sousSousMenuItem}
						<li><a href={$sousSousMenuItem.url_alias|ezurl()}>{$sousSousMenuItem.name|wash()}</a></li>
						
						{* menu : level 4 *}
							{* 
								- déclarer un $sousSousSousMenuItemsArray
								- reprendre la portion de code contenu entre les commentaires (* menu : level 3 *) (* /menu : level 3 *)
								- redéfinir les variables utilisées
							*}
						{* /menu : level 4 *}
						{/foreach}
					</ul>
					{/if}
					{* /menu : level 3 *}
				</li>
				{/foreach}
			</ul>
			{/if}
			{* /menu : level 2 *}
		</li>
	{/foreach}
	</ul>
{/if}
</div>
{undef $menuItemsArray $sousMenuItemsArray $sousSousMenuItemsArray}