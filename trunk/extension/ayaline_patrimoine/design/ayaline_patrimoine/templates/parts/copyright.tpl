<div class="copyright">
                <div class="menu-bas-page">
                    <p>{$nodeConfigGeneral.data_map.texte_pied_page.value}</p>
                    {if $nodeConfigGeneral.data_map.liens_pied_page.has_content}
	                    <p class="bold">
	                    {def $lien = false()}
		                    {foreach $nodeConfigGeneral.data_map.liens_pied_page.value.relation_list as $lien}
								{set $lien = fetch(content, node, hash(node_id, $lien.node_id))}
								{if eq($lien.class_identifier,'smp_raccourci')}
									<a href="{$lien.data_map.adress_page_cible.value}" target="_blank" rel='external'>
								{striptags($lien.data_map.titre.value)}</a><br>
								{else}
		                    		<a href={$lien.url_alias|ezurl} rel='external'>
		                    		{attribute_view_gui attribute=$lien.data_map.titre}</a><br>		                    	
								{/if}
							{/foreach}
							{undef $lien}
	                    </p>
                    {/if}
                </div>
                <div class="realisation-ayaline">
                    <a href="http://www.ayaline.com" target="_blank"> 
                        Réalisation&nbsp;:<span class="cache">aYaline</span>
                        <br>
                        <img src={concat('images/ayaline.png')|ezdesign} alt="">
                    </a>
                </div>
                <div class="clear-tout"></div>
</div>