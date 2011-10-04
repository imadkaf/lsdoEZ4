<div class="content-view-full">
	<h2 class="bloc-liste-h2">{$node.name|wash()}</h2>
	
	<div class="survey-view">
		<div class="block page-contact">
			{if $node.data_map.description.has_content}	
				<p class="chapeau">
					{attribute_view_gui attribute = $node.data_map.description}
				</p>
			{/if}
		
			<form action={'content/action'|ezurl} method="post">
				{if and($validation, $validation.processed, $validation.attributes|count|gt(0))}
					<div class="bloc-error">
						<div class="block">
							<h2>Veuillez remplir les champs suivants :</h2>
						</div><br />
						<ul>
							{foreach $validation.attributes as $item}
								<li><span class="label-erreur"><b>{$item.name|wash()} :&nbsp;</b></span>{$item.description|wash()}</li>
							{/foreach}
						</ul>
					</div>
				{/if}

				<div class="block">
					<h2>Votre message</h2>
				</div>
				<div class="block">
					<label class="lsdo-label">{$node.data_map.votre_message.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.votre_message}
				</div>
				
				<div class="block">
					<br />
					<h2>Vos informations</h2>
				</div>
				<div class="block civilite">					
					{attribute_view_gui attribute = $node.data_map.sqli_civilite}
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
					<label class="lsdo-label non-textarea">{$node.data_map.societe.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.societe}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_adresse.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_adresse}
				</div>
				
				<div class="block deux-colonnes float-g">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_codepostal.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_codepostal}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.ville.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.ville}
				</div>
				
				<div class="block deux-colonnes float-g">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_telephone.contentclass_attribute_name|wash()} :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_telephone}
				</div>
				
				<div class="block deux-colonnes droite">
					<label class="lsdo-label non-textarea">{$node.data_map.sqli_email.contentclass_attribute_name|wash()}<strong class="required">*</strong> :</label>
					{attribute_view_gui attribute = $node.data_map.sqli_email}
				</div>
				
				<div class="block">
					<br />
					<h2>Vos services</h2>
				</div>
				<div class="block checkbox-column">
					{attribute_view_gui attribute = $node.data_map.animations_actualites}
					<label>{$node.data_map.animations_actualites.contentclass_attribute_name|wash()}</label>
				</div>
				<div class="block checkbox-column">
					{attribute_view_gui attribute = $node.data_map.bons_plans_sejours}
					<label>{$node.data_map.bons_plans_sejours.contentclass_attribute_name|wash()}</label>
				</div>

				<div class="block">
					<br />
					<h2>Code de sécurité (CAPTCHA)<strong class="required">*</strong></h2>
				</div>
				<div class="block recaptcha-droite">
					<p class="text-captcha">Saisir le code ci-dessous. Si vous ne pouvez lire toutes les lettres ou chiffres, <a href="javascript:Recaptcha.reload ();">Cliquez ici</a>.</p>
					<br />
					{attribute_view_gui attribute = $node.data_map.recapture}
				</div>
				
				<div class="block button">
					<input name="TopLevelNode" value="{$node.node_id}" type="hidden" />
					<input name="ContentNodeID" value="{$node.node_id}" type="hidden" />
					<input name="ContentObjectID" value="{$node.object.id}" type="hidden" />
					<input class="button-effacer" type="image" src={"effacer.png"|ezimage} name="reset" value="Effacer" onclick="this.form.reset(); return false;" />
					<input class="button-envoyer" type="image" src={"envoyer.png"|ezimage} name="ActionCollectInformation" value="Envoyer" />
				</div>

				<strong class="required">* </strong>Champs obligatoires.

				<div class="block border-haut">
					{attribute_view_gui attribute = $node.data_map.informations}
				</div>
			
			</form>
		</div>
	</div>
</div>
