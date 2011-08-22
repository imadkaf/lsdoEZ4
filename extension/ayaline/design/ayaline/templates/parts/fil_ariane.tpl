{if $module_result.uri|eq('/user/login')}
		<p class="fil-ariane"><a href="/">Les Sables d'Olonne</a> > <strong>Connexion</strong></p>
{/if}
{if $cNode|is_set()}
	{if ne($cNode.node_id, ezini('NodeSettings', 'RootNode', 'content.ini'))}
		<p class="fil-ariane">
		{foreach $module_result.path as $Path}
			{if or($Path.url_alias, $Path.url)}
					<a href={$Path.url_alias|ezurl}>{$Path.text|wash}</a> >
			{else}
					<strong>{$Path.text|wash}</strong>
			{/if}
		{/foreach}
		</p>
	{/if}
{/if}