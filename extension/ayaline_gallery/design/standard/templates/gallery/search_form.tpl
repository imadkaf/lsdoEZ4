<form name="search_gallery" method="post" action={$node.url_alias|ezurl}>
	<label for="gallery_keyword">Rechercher : </label><input type="text" id="gallery_keyword" name="gallery_keyword" />	
	
	{if $rubriques|count|gt(0)}
	<label for="gallery_type">Dans : </label>
	<select id="gallery_type" name="gallery_type" >
		<option value="{$node.node_id}">Tous</option>
		{foreach $rubriques as $rubrique}
			<option value="{$rubrique.node_id}">{$rubrique.name|wash}</option>
		{/foreach}
	</select>
	{/if}
	
	<input type="submit" value="Rechercher" class="button" />
</form>
