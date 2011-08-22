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
			{if $node.data_map.short_description.value.is_empty|not}
				<p class="chapeau">{attribute_view_gui attribute = $node.data_map.description}</p>
			{/if}
			
			<br /><br />
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>
