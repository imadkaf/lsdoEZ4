{def $nbPubs = 5}

{def $nodePhototheque = fetch('content', 'tree', hash('parent_node_id', ezini('Noeuds', 'home', 'ayaline.ini'),
														'class_filter_type', 'include',
														'class_filter_array', array('phototheque'),
														'limit', 1))}

<div class="bloc-left-bis">

	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">
			
			<h2 class="bloc-liste-h2">{$node.name|wash}</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
			{if is_set($node.data_map.short_description)}
				{attribute_view_gui attribute = $node.data_map.short_description}
			{/if}
			</p>
			
			<div class="espace_presse">
				Vous souhaitez accéder à :<br /><br />
				{if $nodePhototheque|count|gt(0)}
					{set $nodePhototheque = $nodePhototheque.0}
					<a href={$nodePhototheque.url_alias|ezurl}>- La photothèque</a><br />
				{/if}
				<a href={''|ezurl()}>- L'accueil</a>
			</div>
			<br /><br />
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>
