{def $actif= false()}
{foreach $module_result.path as $Path offset 2}
	{if eq($Path.url_alias,false())}
		{set $actif = true()}
	{/if}
{/foreach}
<div id="Header" {if eq($actif,false())}style="border-bottom: 5px solid #7b5e51;"{/if} {if and(eq($actif,true()),ge($module_result.path|count,4))}style="border-bottom: 5px solid #98E2CC;"{/if}>

	<div id="bandeau-site">
		<h1>
			<a href="/" class="logo-site" rel='external'>{attribute_view_gui attribute=$nodeConfigGeneral.data_map.logo_site}</a> 
			<a href="/" class="accroche-site" rel='external'>
			<span>{attribute_view_gui attribute=$nodeConfigGeneral.data_map.titre_site}</span>
			<span class="aligne-centre">{attribute_view_gui attribute=$nodeConfigGeneral.data_map.sous_titre_site}</span> 
			</a> 
			<span class="clear-tout"></span>
		</h1>
	</div>
	<div class="TopNavBar">
		<div class="menu">
		{if $nodeConfigGeneral.data_map.onglets_bandeau_haut_page.has_content}
		{def $onglet = false()}
			{foreach $nodeConfigGeneral.data_map.onglets_bandeau_haut_page.value.relation_list as $onglet}
				{set $onglet = fetch(content, node, hash(node_id, $onglet.node_id))}
				<a href={$onglet.url_alias|ezurl} class="ui-link item1" {if eq($actif,false())}style="background: #7b5e51"{/if} {if and(eq($actif,true()),ge($module_result.path|count,4))}style="background: #98E2CC;"{/if} rel='external'>				
					{if eq($onglet.class_identifier,'smp_liste_circuits')}
						{striptags($onglet.data_map.titre_page.value)}
					{elseif eq($onglet.class_identifier,'smp_circuit')}
						{striptags($onglet.data_map.titre_circuit.value)}
					{elseif eq($onglet.class_identifier,'smp_point_interet')}
						{striptags($onglet.data_map.titre_point_interet.value)}
					{elseif eq($onglet.class_identifier,'smp_contenu_libre')}
						{striptags($onglet.data_map.titre.value)}
					{elseif eq($onglet.class_identifier,'smp_accueil')}
						{striptags($onglet.data_map.titre.value)}
					{/if}
				</a>			
			{/foreach}
			{undef $onglet}
		{/if}
		</div>
		<div class="clear"></div>
	</div>
</div>