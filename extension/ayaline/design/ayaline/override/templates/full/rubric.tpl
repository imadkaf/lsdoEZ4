{if eq($node.class_identifier, $node.parent.object.class_identifier)}
	{node_view_gui content_node=$node view='full_left_menu'}
{else}
				<div class="bloc-left-bis">
					<div class="bloc-type padding-35px-32px">
						<h2>
							{attribute_view_gui attribute = $node.data_map.title}
						</h2>
						<p class="clear"></p>
						<p class="chapeau">
							{attribute_view_gui attribute = $node.data_map.short_description}
						</p>
						<ul class="liste">
{foreach $node.children as $enfants sequence array( '', '', 'last' ) as $style}
							<li class="{$style}">
								{node_view_gui content_node=$enfants view='line'}
							</li>
{/foreach}
						</ul>
					</div>
				</div>
				<div class="bloc-right-bis">
{include uri='design:parts/reserver.tpl'}
{include uri='design:parts/les_plus_consultes.tpl'}
{include uri='design:parts/agenda.tpl'}
				</div>
{/if}