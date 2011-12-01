<div class="content-view-full">

	<h2 class="bloc-liste-h2">{$node.name|wash()}</h2>

	<div class="survey-view">
		<div class="block page-contact">
			<div class="message">
				{default collection = cond($collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
				                          				   fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}
				
					{set-block scope=global variable=title}{'Form %formname'|i18n('design/standard/content/form',,hash('%formname',$node.name|wash))}{/set-block}
					
					<h2>{"Your message was sent"|i18n("ayaline")}.</h2><br />
					
					<p>{"The team of the tourist office of Sables d'Olonne will bring to you an answer as soon as possible"|i18n("ayaline")}.</p>
				{/default}
			</div>
			<br />
			
			<p>{"We thank you for your comprehension and let us invite you to continue your consultation of the site while clicking here"|i18n("ayaline")} :</p><br />
			
			<div class="retour-home">
				<a href={ezurl()}>{"Home"|i18n("ayaline")}</a>
			</div>
			
			{if $error}
				{if $error_existing_data}
					<p>{'You have already submitted this form. The previously submitted data was:'|i18n('design/standard/content/form')}</p>
				{/if}
			{/if}
		</div>
	</div>
</div>
