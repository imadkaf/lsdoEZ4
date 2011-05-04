{def $menuPiedPage = fetch('content','tree', hash(
											'parent_node_id',  ezini('NodeSettings','RootNode','content.ini'),
											'class_filter_type' , 'include', 
											'class_filter_array' , array('footer_menu')))}
{set $menuPiedPage=$menuPiedPage.0}
{def $liensColonne1 = $menuPiedPage.data_map.content_column_1.content.relation_list}
{def $liensCol1 = ''}
{def $liensColonne2 = $menuPiedPage.data_map.content_column_2.content.relation_list}
{def $liensCol2 = ''}
{def $liensColonne3 = $menuPiedPage.data_map.content_column_3.content.relation_list}
{def $liensCol3 = ''}
{def $liensColonne4 = $menuPiedPage.data_map.content_column_4.content.relation_list}
{def $liensCol4 = ''}
{def $liensColonne5 = $menuPiedPage.data_map.content_column_5.content.relation_list}
{def $liensCol5 = ''}
{def $liensHorizontaux = $menuPiedPage.data_map.menu_h.content.relation_list}
{def $liensHoriz = ''}
				<div class="footer">
					<ul class="niv-1">
						<li class="first">
{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_1}
							<ul class="list-block">
{foreach $liensColonne1 as $itemVar}
	{set $liensCol1 = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
								<li>{node_view_gui content_node=$liensCol1 view='menu'}</li>
{/foreach}
							</ul>
						</li>
						<li class="second">
{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_2}
							<ul class="list-block">
{foreach $liensColonne2 as $itemVar}
	{set $liensCol2 = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
								<li class="parag">{node_view_gui content_node=$liensCol2 view='menu'}</li>
{/foreach}
							</ul>
						</li>
						<li class="third">
{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_3}
							<ul class="list-block">
{foreach $liensColonne3 as $itemVar}
	{set $liensCol3 = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
								<li>{node_view_gui content_node=$liensCol3 view='menu'}</li>
{/foreach}
							</ul>
						</li>
						<li class="fourth">
{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_4}
							<ul class="list-block">
{foreach $liensColonne4 as $itemVar}
	{set $liensCol4 = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
								<li>{node_view_gui content_node=$liensCol4 view='menu'}</li>
{/foreach}
							</ul>
						</li>
						<li class="fifth">
{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_5}
							<ul class="list-block">
{foreach $liensColonne5 as $itemVar}
	{set $liensCol5 = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
								<li>{node_view_gui content_node=$liensCol5 view='menu'}</li>
{/foreach}
							</ul>
						</li>
						<li class="last">
							{attribute_view_gui attribute = $menuPiedPage.data_map.logo image_class='logo_footer' href=ezurl()}
						</li>
					</ul>
					<ul class="niv-2">
{foreach $liensHorizontaux as $keyVar =>$itemVar}
	{set $liensHoriz = fetch('content', 'node', hash('node_id', $itemVar.node_id))}
						<li{if eq($keyVar, 0)} class="first"{/if}>{if ne($keyVar, 0)}-{/if}{node_view_gui content_node=$liensHoriz view='menu'}</li>
	
{/foreach}
					</ul>
				</div>
{undef $menuPiedPage $liensColonne1 $liensCol1  $liensColonne2 $liensCol2 $liensColonne3 $liensCol3 $liensColonne4 $liensCol4 $liensColonne5 $liensCol5 $liensHorizontaux $liensHoriz}