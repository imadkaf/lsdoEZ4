<div class="copyright">
                <div class="menu-bas-page">
                    <p>{$nodeConfigGeneral.data_map.texte_pied_page.value}</p>
                    {if $nodeConfigGeneral.data_map.liens_pied_page.has_content}
	                    <p class="bold">
	                    {def $lien = false()}
		                    {foreach $nodeConfigGeneral.data_map.liens_pied_page.value.relation_list as $lien}
								{set $lien = fetch(content, node, hash(node_id, $lien.node_id))}	
		                    	<a href={$lien.url_alias|ezurl}>{attribute_view_gui attribute=$lien.data_map.titre}</a>		                    	
							{/foreach}
							{undef $lien}
	                    </p>
                    {/if}
                </div>
                <div class="realisation-ayaline">
                    <a href="http://www.ayaline.com" target="_blank"> 
                        Réalisation&nbsp;:<span class="cache">aYaline</span>
                        <br>
                        <img src={concat('images/ayaline.png')|ezdesign} alt=""></a>
                </div>
                <div class="clear-tout"></div>
</div>