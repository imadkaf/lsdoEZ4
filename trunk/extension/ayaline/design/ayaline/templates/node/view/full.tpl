{def $nbPubs = 5}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type">

			<h2 class="bloc-liste-h2">
				{$node.name}
			</h2>
			<p class="clear"></p>
			
			{if is_set($node.data_map.short_description)}
			<p class="chapeau">
				{attribute_view_gui attribute = $node.data_map.short_description}
			</p>
			{/if}
			
			{foreach $node.data_map as $attribute}
				{if and(ne($attribute.contentclass_attribute.identifier, 'title'), 
						ne($attribute.contentclass_attribute.identifier, 'short_description'), 
						ne($attribute.contentclass_attribute.identifier, 'referencement'),
						ne($attribute.contentclass_attribute.identifier, 'code'))}
					<br /><br />
					{attribute_view_gui attribute = $attribute}
				{/if}
				{if eq($attribute.contentclass_attribute.identifier, 'code')}
					<br /><br />
					{$attribute.content}
				{/if}
			{/foreach}

			<br /><br /><br />
			
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/les_plus_consultes.tpl'}
</div>
