{def $nodePlan = fetch('content', 'tree', hash('parent_node_id', ezini('NodeSettings', 'RootNode', 'content.ini'),
												'class_filter_type', 'include',
												'class_filter_array', array('site_map'),
												'limit', 1))}

<div class="titre-basique">
	<h2>Page introuvable</h2>
</div>

<div class="detail-rubrique">
	<p>
		La page que vous avez demandée n'existe pas ou est momentanément indisponible.<br/>
		Veuillez nous excuser de la gêne occasionnée.
	</p>
	<br />
	
	<p>Nous vous conseillons :</p>
	<ul>
		<li style="padding:0px;"><a href={''|ezurl()}>L'accueil du site</a></li>
		{if $nodePlan|count|gt(0)}
			{set $nodePlan=$nodePlan.0}
			<li><a href={$nodePlan.url_alias|ezurl}>Le plan du site</a></li>
		{/if}
	</ul>
</div>
