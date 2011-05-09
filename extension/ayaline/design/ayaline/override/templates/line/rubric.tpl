<li>
	<h3 class="small-space">
		<a href={$node.url_alias|ezurl}>{attribute_view_gui attribute = $node.data_map.title}</a>
		{*
		<span class="none">Visites, excursions</span>
		<a href="#"><img alt="" src="images/visites-excursions2.png" /></a>
		*}
	</h3>
	
	{attribute_view_gui attribute = $node.data_map.thumbnail}
	{*<img alt="" src="images/illustration30.png" />*}
	
	<p>
		{attribute_view_gui attribute = $node.data_map.short_description}
	</p>
	
	<p class="lien-bas">
		<a href={$node.url_alias|ezurl}>En savoir plus</a>
	</p>
</li>
