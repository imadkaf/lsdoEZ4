<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">

			<h2 class="bloc-liste-h2">
				{attribute_view_gui attribute = $node.data_map.title}
			</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
				{attribute_view_gui attribute = $node.data_map.short_description}
			</p>



{* Exemple du site : Europe en France

{literal}
	<script type="text/javascript" src="/extension/europe_en_france/design/europe_en_france/javascript/carte_cliquable.js"></script>
{/literal}

<div id="content-page">
	<div class="top-content-page">
		{include uri='design:parts/fil_ariane.tpl' }
		{include uri='design:parts/tooltip.tpl' }
	</div>
	<h2>{attribute_view_gui attribute=$node.data_map.titre}</h2>
	
	{if $node.data_map.description.has_content}
		{attribute_view_gui attribute=$node.data_map.description}
	{/if}
	{if $node.data_map.videos.has_content}
		{foreach $node.data_map.videos.content.relation_list as $key=>$video}
			{def $video=fetch('content', 'node', hash('node_id', $video.node_id))}
			<div class="video_contenu_libre">
				{attribute_view_gui attribute=$video.data_map.embed_code}
			</div>
			{undef $video}
		{/foreach}
	{/if}
	
	{if $node.data_map.embed_code.has_content}
		<div class="video_contenu_libre">
			{$node.data_map.embed_code.content}
		</div>
	{/if}
	
	{if $node.data_map.description2.has_content}
		{attribute_view_gui attribute=$node.data_map.description2}
	{/if}

	{def $config_sites_regions=fetch('content', 'tree', hash('parent_node_id', 2,
															'class_filter_type', include,
															'class_filter_array', array('config_sites_regions')
														))}
	{def $liste_sites=fetch('content', 'node', hash('node_id', $config_sites_regions[0].node_id))}
	
	{def $pages_carte_cliquable=ezini('PagesCarteCliquable','PageId','europe_en_france.ini')}

	{if $pages_carte_cliquable|contains($node.node_id)}
		{def $tab_coord_regions=ezini('CoordonneesRegions', 'Coordonnees', 'europe_en_france.ini')}
		<div class="Map MapContainer">
			<div style="background-image:url(/extension/europe_en_france/design/europe_en_france/images/transparent.gif);" class="Map" id="area_image">
				<img src={'transparent.gif'|ezimage()} alt="" usemap="#france_map">	
			</div>	
		</div>

		<map name="france_map">
			{def $compteur=1}
			{foreach $liste_sites.data_map as $attribut}
				{if $attribut.contentclass_attribute_identifier|ne('titre')}
					<area shape="poly" title="{$attribut.contentclass_attribute_name}" coords={$tab_coord_regions[$compteur]} {if $attribut.has_content} href="{$attribut.content}" target="_blank" onmouseover="change_image({$compteur})" onmouseout="hide_image({$compteur})"{/if}>
					{set $compteur=$compteur|inc()}
				{/if}
			{/foreach}
		</map>
	{/if}
	
	{include uri='design:parts/addthis.tpl'}
</div>

*}