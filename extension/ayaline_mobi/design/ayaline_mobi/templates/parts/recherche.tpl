<div class="recherche">
	<div class="search">
		<form action={"/content/search/"|ezurl} method="get" class="form-recherche">
			<label class="none" for="recherche">Votre recherche</label>
			<div id="ezautocomplete2">
				<table>
					<td><input type="search" id="Search" value="Recherche" name="recherche" /></td>
					<td><input type="submit" value="OK" data-role="button" data-theme="b" data-inline="true" /></td>
				</table>
				<div id="ezautocompletecontainer2"></div>
			</div>
		</form>
	</div>
</div>
{*
{ezscript_require( array('ezjsc::yui2', 'ezajax_autocomplete.js') )}
<script type="text/javascript">
	jQuery('#ezautocompletecontainer2').css('width', jQuery('input#Search').width());
	var ezAutoHeader = eZAJAXAutoComplete();
	ezAutoHeader.init({ldelim}
	    url: "{'ezjscore/call/ezfind::autocomplete'|ezurl('no')}",
	    inputid: 'Search',
	    containerid: 'ezautocompletecontainer2',
	    minquerylength: {ezini( 'AutoCompleteSettings', 'MinQueryLength', 'ezfind.ini' )},
	    resultlimit: {ezini( 'AutoCompleteSettings', 'Limit', 'ezfind.ini' )}
	{rdelim});
</script>
*}