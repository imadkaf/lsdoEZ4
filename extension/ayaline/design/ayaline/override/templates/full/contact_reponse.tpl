{def $maCollection = fetch( 'content', 'collected_info_collection', hash( 'collection_id', $collection_id,
																			'contentobject_id', $node.contentobject_id ) ) }
	
{* Récupération de la civilite *}
{def $civilite = ""}
{if eq($maCollection.data_map.sqli_civilite.data_int, 0)}
	{set $civilite = "Monsieur"}
{/if}
{if eq($maCollection.data_map.sqli_civilite.data_int, 1)}
	{set $civilite = "Madame"}
{/if}
{if eq($maCollection.data_map.sqli_civilite.data_int, 2)}
	{set $civilite = "Mademoiselle"}
{/if}

<script type="text/javascript">
	$.post(
		"{ezini('WebForm', 'UrlWebForm', 'ayaline.ini')}",
		{ldelim}
			appKey: "bf8ca33ac809ad76792402300d8c2dd3",
			group: "100",
			sqli_intitule: "[Formulaire de contact Web]",
			sqli_modecontact: "Web",
			sqli_etatdemande: "A traiter",
			sqli_raisonsocial: "{$maCollection.data_map.societe.content}",
			sqli_prenom: "{$maCollection.data_map.sqli_prenom.content}",
			sqli_nom: "{$maCollection.data_map.sqli_nom.content}",
			sqli_email: "{$maCollection.data_map.sqli_email.content}",
			sqli_telephone: "{$maCollection.data_map.sqli_telephone.content}",
			sqli_fax: "",
			sqli_mobile: "",
			sqli_adresse: "{$maCollection.data_map.sqli_adresse.content}",
			sqli_adressecomp: "",
			sqli_codepostal: "{$maCollection.data_map.sqli_codepostal.content}",
			sqli_commune: "{$maCollection.data_map.ville.content}",
			sqli_pays: "",
			sqli_objetdem: "{$maCollection.data_map.votre_message.content}",
			sqli_civilite: "{$civilite}",
			{if and(eq($maCollection.data_map.animations_actualites.content, 0), eq($maCollection.data_map.bons_plans_sejours.content, 0))}
				sqli_contactemail: "1",
			{/if}
			sqli_modereponse: "Courrier",
			sqli_urlsiteweb: "",
			sqli_typeform: "Demandes d'informations"
		{rdelim}
	);
</script>

<div class="content-view-full">

	<h2 class="bloc-liste-h2">{$node.name|wash()}</h2>

	<div class="survey-view">
		<div class="block page-contact">
			<div class="message">
				{default collection = cond($collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
				                          				   fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}
				
					{set-block scope=global variable=title}{'Form %formname'|i18n('design/standard/content/form',,hash('%formname',$node.name|wash))}{/set-block}
					
					<h2>Votre message a bien été transmit.</h2><br />
					
					<p>L'équipe d'administration du site "Les Sables d'Olonne" y apportera une réponse dans les meilleurs délais.</p>
				{/default}
			</div>
			<br />
			
			<p>Nous vous remercions pour votre compréhension et vous invitons à poursuivre votre consultation du site en cliquant ci-après :</p><br />
			
			<div class="retour-home">
				<a href={ezurl()}>Accueil</a>
			</div>
			
			{if $error}
				{if $error_existing_data}
					<p>{'You have already submitted this form. The previously submitted data was:'|i18n('design/standard/content/form')}</p>
				{/if}
			{/if}
		</div>
	</div>
</div>
