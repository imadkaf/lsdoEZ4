<div class="content-view-full">
	<h2 class="bloc-liste-h2">{$node.name|wash()}</h2>
	
	<div class="survey-view">
		<div class="block page-contact">
			{if $node.data_map.description.has_content}	
				{attribute_view_gui attribute = $node.data_map.description}
			{/if}
		
			<form action={'content/action'|ezurl} method="post">
				{if and($validation, $validation.processed, $validation.attributes|count|gt(0))}
					<div class="bloc-error">
						<div class="block">
							<h2>{"Please fill the following fields"|i18n("ayaline")} :</h2>
						</div><br />
						<ul>
							{foreach $validation.attributes as $item}
								<li><span class="label-erreur"><b>{$item.name|wash()} :&nbsp;</b></span>{$item.description|wash()}</li>
							{/foreach}
						</ul>
					</div>
				{/if}
				
				<div class="block">
					<br />
					<h2>{"Your informations"|i18n("ayaline")}</h2>
				</div>
								
				<div class="block deux-colonnes float-g">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_prenom.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_prenom}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_nom.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_nom}
				</div>
				
				<div class="block deux-colonnes float-g">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_email.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_email}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.societe.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.societe}
				</div>
				
				<div class="block deux-colonnes float-g">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_adresse.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_adresse}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_codepostal.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_codepostal}
				</div>
				
				<div class="block deux-colonnes float-g">
					<label class="lsdo-label non-textarea">{$node.data_map.ville.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.ville}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_telephone.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_telephone}
				</div>
				
				<div class="block">
					<br />
					<h2>{"Your services"|i18n("ayaline")}</h2>
				</div>
				<div class="block checkbox-column">
					{attribute_view_gui attribute = $node.data_map.animations_actualites}
					<label>{$node.data_map.animations_actualites.contentclass_attribute_name|wash()}</label>
				</div>
				<div class="block checkbox-column">
					{attribute_view_gui attribute = $node.data_map.bons_plans_sejours}
					<label>{$node.data_map.bons_plans_sejours.contentclass_attribute_name|wash()}</label>
				</div>
				
				<div class="block button">
					<input name="TopLevelNode" value="{$node.node_id}" type="hidden" />
					<input name="ContentNodeID" value="{$node.node_id}" type="hidden" />
					<input name="ContentObjectID" value="{$node.object.id}" type="hidden" />
					<input class="button-submit-effacer" type="reset" name="reset" value="{'Reset'|i18n("ayaline")}" />
					<input class="button-submit-valider" type="submit" name="ActionCollectInformation" value="{'Send'|i18n("ayaline")}" />
				</div>
				<div class="clear-both"></div>

				<strong class="required">* </strong>{"Required field"|i18n("ayaline")}.	<br/>	<br/>	
				{if $node.data_map.mentions_legales.has_content}	
				<div>
					{attribute_view_gui attribute = $node.data_map.mentions_legales}
				</div>
				{/if}
			</form>
		</div>
	</div>
</div>
