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
