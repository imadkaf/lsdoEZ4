<form name="search_gallery" method="post" action={$node.url_alias|ezurl}>
	<label for="gallery_keyword">Rechercher : </label>
	<input type="text" id="gallery_keyword" name="SearchText" />
	
	<button type="submit">
		<span>{"Search"|i18n("ayaline")}</span>
	</button>
</form>
