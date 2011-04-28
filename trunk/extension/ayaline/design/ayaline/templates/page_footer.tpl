{def $menuPiedPage = fetch('content','tree', hash(
											'parent_node_id',  ezini('NodeSettings','RootNode','content.ini'),
											'class_filter_type' , 'include', 
											'class_filter_array' , array('footer_menu')))}

{set $menuPiedPage=$menuPiedPage.0}  

{def $liensColonne1 = $menuPiedPage.data_map.content_column_1.content.relation_list}
{def $liensColonne2 = $menuPiedPage.data_map.content_column_2.content.relation_list}
{def $liensColonne3 = $menuPiedPage.data_map.content_column_3.content.relation_list}
{def $liensColonne4 = $menuPiedPage.data_map.content_column_4.content.relation_list}
{def $liensColonne5 = $menuPiedPage.data_map.content_column_5.content.relation_list}
{def $liensHorizontaux = $menuPiedPage.data_map.menu_h.content.relation_list}

{*$menuPiedPage.data_map.content_column_3.content.relation_list|attribute(show)*}

<div class="footer">
	<ul class="niv-1">
		<li class="first">
			{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_1}
			<ul class="list-block">
			{def $liensCol1 = ''}
			{foreach $liensColonne1 as $key}
				{set $liensCol1 = fetch('content', 'node', hash('node_id', $key.node_id))}
				<li>
					<ul class="list-inline">
					{$liensCol1.data_map.code.content}
					</ul>
				</li><br />
			{/foreach}
			</ul>
		</li>
		<li class="second">
			{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_2}
			<ul class="list-block">
			{def $liensCol2 = ''}
			{foreach $liensColonne2 as $key}
				{set $liensCol2 = fetch('content', 'node', hash('node_id', $key.node_id))}
				<li class="parag">
					{attribute_view_gui attribute = $liensCol2.data_map.description}
				</li>
			{/foreach}
			</ul>
		</li>

		<li class="third">
			{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_3}
			<ul class="list-block">
			{def $liensCol3 = ''}
			{foreach $liensColonne3 as $key}
				{set $liensCol3 = fetch('content', 'node', hash('node_id', $key.node_id))}
				<li>
					<a href={$liensCol3.url_alias|ezurl}>{attribute_view_gui attribute = $liensCol3.data_map.title}</a>
				</li>
			{/foreach}
			</ul>
		</li>
		<li class="fourth">
			{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_4}
			<ul class="list-block">
			{def $liensCol4 = ''}
			{foreach $liensColonne4 as $key}
				{set $liensCol4 = fetch('content', 'node', hash('node_id', $key.node_id))}
				<li>
					<a href={$liensCol4.url_alias|ezurl}>{attribute_view_gui attribute = $liensCol4.data_map.title}</a>
				</li>
			{/foreach}
			</ul>
		</li>
		<li class="fifth">
			{attribute_view_gui attribute = $menuPiedPage.data_map.title_column_5}
			<ul class="list-block">
			{def $liensCol5 = ''}
			{foreach $liensColonne5 as $key}
				{set $liensCol5 = fetch('content', 'node', hash('node_id', $key.node_id))}
				<li>
					<a href={$liensCol5.url_alias|ezurl}>{attribute_view_gui attribute = $liensCol5.data_map.title}</a>
				</li>
			{/foreach}
			</ul>
		</li>
		<li class="last">
			<a href={ezurl()}>{attribute_view_gui attribute = $menuPiedPage.data_map.logo}</a>
		</li>
	</ul>
	<ul class="niv-2">
	{def $liensHoriz = ''}
	{def $premier = true}
	{foreach $liensHorizontaux as $key}
		{set $liensHoriz = fetch('content', 'node', hash('node_id', $key.node_id))}
		{if eq($premier, true)}
			<li class="first">
				<a href={$liensHoriz.url_alias|ezurl}>{attribute_view_gui attribute = $liensHoriz.data_map.title}</a>
			</li>
			{set $premier = false}
		{else}
			<li>-
				<a href={$liensHoriz.url_alias|ezurl}>{attribute_view_gui attribute = $liensHoriz.data_map.title}</a>
			</li>
		{/if}
	{/foreach}
	</ul>
</div>