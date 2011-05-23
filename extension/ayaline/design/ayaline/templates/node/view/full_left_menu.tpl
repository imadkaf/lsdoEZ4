{def $nb_max = 4 }
{def $childrenShowed = $node.children|extract($view_parameters.offset,$nb_max)}
			<div class="bloc-left-bis">
				<div class="bloc-left-in-bis">
					<div class="bloc-type">
						<h2 class="menu-gauche-h2">
							{attribute_view_gui attribute = $node.parent.data_map.title}
						</h2>
						<p class="clear"></p>
						<ul class="menu-left">
{foreach $node.parent.children as $childP}
							<li{if eq($childP.node_id,$node.node_id)} class="actif"{/if}>
								<span>{attribute_view_gui attribute = $childP.data_map.title}</span>
								<ul class="s-menu">
	{foreach $childP.children as $child}
									<li><a href={$child.url_alias|ezurl}>{attribute_view_gui attribute = $child.data_map.title}</a></li>
	{/foreach}
								</ul>
							</li>
{/foreach}
						</ul>
					</div>
				</div>
					<div class="bloc-right-in-bis">
						<div class="bloc-type">
							<h2>
								{attribute_view_gui attribute = $node.data_map.title}
							</h2>
							<p class="clear"></p>
							<p class="chapeau">
								{attribute_view_gui attribute = $node.data_map.short_description}
							</p>
							<ul class="list">
{foreach $childrenShowed as $enfants sequence array( 'first', '' ) as $style}
								<li class="{$style}">
									{node_view_gui content_node=$enfants view='line'}
								</li>
{/foreach}
							</ul>
			{* Affichage de la pagination *}
			{include 
				view_name='rubric'
				uri='design:navigator/google.tpl' 
				page_uri=$node.url_alias
				item_count=$node.children|count
				view_parameters=$view_parameters 
				item_limit=$nb_max
				left_max=1
				right_max=1
			}
						</div>
					</div>
				</div>
				<div class="bloc-right-bis">
{include uri='design:parts/reserver.tpl'}
{include uri='design:parts/les_plus_consultes.tpl'}
				</div>