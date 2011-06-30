{def $nodePlan = fetch('content', 'tree', hash('parent_node_id', ezini('Noeuds', 'home', 'ayaline.ini'),
												'class_filter_type', 'include',
												'class_filter_array', array('site_map'),
												'limit', 1))}

<div class="bloc-left-bis">
	<div class="bloc-type padding-35px-32px">
		<h2 class="bloc-liste-h2">Page introuvable</h2>
		<p class="clear" style="margin-bottom: 20px;"></p>
		
		<p>
			La page que vous avez demandée n'existe pas ou est momentanément indisponible.<br/>
			Veuillez nous excuser de la gêne occasionnée.
		</p>
		<br />
		
		<p>Nous vous conseillons :</p>
		<ul>
			<li style="padding:0px;">- <a href={''|ezurl()}>L'accueil du site</a></li>
			{if $nodePlan|count|gt(0)}
				{set $nodePlan=$nodePlan.0}
				<li>- <a href={$nodePlan.url_alias|ezurl}>Le plan du site</a></li>
			{/if}
		</ul>
		
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/les_plus_consultes.tpl'}
</div>
