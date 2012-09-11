<div class="recherche accueil">
	<form action={"/content/search/"|ezurl} method="get" class="form-recherche" data-ajax="false">
		<label class="none" for="recherche">Votre recherche</label>
		<table>
			<tr>
				<td><input type="search" id="recherche"
					name="SearchText"
					onfocus="if(this.value=='Recherche'){ldelim}this.value='';{rdelim}"
					onblur="if(this.value==''){ldelim}this.value='Recherche';{rdelim}" value="Recherche"/>
				</td>
				<td>
					<button type="submit" name="SearchButton">OK</button></td>
			</tr>
		</table>
		<div id="ezautocompletecontainer2"></div>
	</form>
	{ezscript_require( array('ezjsc::yui2', 'ezajax_autocomplete.js') )}
	<script type="text/javascript">
									jQuery('#ezautocompletecontainer2').css('width', jQuery('input#recherche').width());
									var ezAutoHeader = eZAJAXAutoComplete();
									ezAutoHeader.init({ldelim}
									    url: "{'ezjscore/call/ezfind::autocomplete'|ezurl('no')}",
									    inputid: 'recherche',
									    containerid: 'ezautocompletecontainer2',
									    minquerylength: {ezini( 'AutoCompleteSettings', 'MinQueryLength', 'ezfind.ini' )},
									    resultlimit: {ezini( 'AutoCompleteSettings', 'Limit', 'ezfind.ini' )}
									{rdelim});
								</script>
</div>
