<div class="recherche">
	<div class="search">
		<form action={"/content/search/"|ezurl} method="get" class="form-recherche">
			<label class="none" for="recherche">Votre recherche</label>
			<table>
				<td><input type="search" id="Search" value="Recherche" name="SearchText" onblur="{literal}if(this.value==''){this.value='Recherche';}{/literal}" onfocus="{literal}if(this.value=='Recherche'){this.value='';}{/literal}" /></td>
				<td><input type="submit" value="OK" data-role="button" data-theme="b" data-inline="true" /></td>
			</table>
		</form>
	</div>
</div>
