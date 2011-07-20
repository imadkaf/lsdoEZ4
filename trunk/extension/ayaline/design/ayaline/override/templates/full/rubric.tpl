{if eq($node.class_identifier, $node.parent.object.class_identifier)}
	{node_view_gui content_node=$node view='full_left_menu' view_parameters=$view_parameters}
{else}
				<div class="bloc-left-bis">
					<div class="bloc-type padding-35px-32px">
						<h2 class="bloc-liste-h2">
							{attribute_view_gui attribute = $node.data_map.title}
						</h2>
						<p class="clear"></p>
						<p class="chapeau">
							{attribute_view_gui attribute = $node.data_map.short_description}
						</p>

{def $compteurlisterubrique = 1}

						<ul class="liste">
{foreach $node.children as $enfants sequence array( '', '', 'last' ) as $style}
							<li class="{$style}">
								{node_view_gui content_node=$enfants view='line'}
							</li>
	{if and($node.children|count|gt($compteurlisterubrique), $style|eq('last'))}
						</ul>
						<ul class="liste">
	{/if}
	{set $compteurlisterubrique = $compteurlisterubrique|inc}
{/foreach}
						</ul>
					</div>
				</div>
				<div class="bloc-right-bis">
{include uri='design:parts/reserver.tpl'}
{include uri='design:parts/liste_mises_en_avant.tpl'}
				</div>
				
				<script type="text/javascript">
					$(window).load(equilibrerHauteursBlocs);
				</script>
{/if}
