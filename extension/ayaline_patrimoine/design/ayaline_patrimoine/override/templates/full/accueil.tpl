<div class="contenu page-standard">
	{if $node.data_map.visuel.has_content}
		{attribute_view_gui attribute=$node.data_map.visuel image_class='original'}
	{/if}
	<h1 class="titre-principal">{$node.data_map.titre.value}</h1>
	<div class="border-left-5px-general">
		<div class="background-white">
			{if $node.data_map.accroche.has_content}
				<div class="accroche_contenu_libre introduction-page-standard">
					{attribute_view_gui attribute=$node.data_map.accroche}
		    	</div>
		    {/if}
		    <div class="arrier-plan-marron">
		    		{attribute_view_gui attribute=$node.data_map.texte_riche}
			</div>
    	</div>
    </div>
</div>