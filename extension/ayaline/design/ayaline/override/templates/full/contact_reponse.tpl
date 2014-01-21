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
{def $infocomp = $maCollection.data_map.votre_message.content|explode('\r\n')}
{def $incinfo = 1}


<script type="text/javascript">
	_gaq.push(['_trackEvent', 'Contact',{concat("'",$maCollection.data_map.ville.content,"'")}]);
</script>

<script type="text/javascript">
	var data = [
		{ldelim}name : 'appKey', value : "bf8ca33ac809ad76792402300d8c2dd3"{rdelim},
        {ldelim}name : 'group', value : "3"{rdelim},
        {ldelim}name : 'sqli_intitule', value : "[Formulaire de contact Web]"{rdelim},
        {ldelim}name : 'sqli_modecontact', value : "Web"{rdelim},
        {ldelim}name : 'sqli_etatdemande', value : "A traiter"{rdelim},
        {ldelim}name : 'sqli_raisonsocial', value : "{$maCollection.data_map.societe.content}"{rdelim},
        {ldelim}name : 'sqli_prenom', value : "{$maCollection.data_map.sqli_prenom.content}"{rdelim},
        {ldelim}name : 'sqli_nom', value : "{$maCollection.data_map.sqli_nom.content}"{rdelim},
        {ldelim}name : 'sqli_email', value : "{$maCollection.data_map.sqli_email.content}"{rdelim},
        {ldelim}name : 'sqli_telephone', value : "{$maCollection.data_map.sqli_telephone.content}"{rdelim},
        {ldelim}name : 'sqli_fax', value : ""{rdelim},
        {ldelim}name : 'sqli_mobile', value : ""{rdelim},
        {ldelim}name : 'sqli_adresse', value : "{$maCollection.data_map.sqli_adresse.content}"{rdelim},
        {ldelim}name : 'sqli_adressecomp', value : ""{rdelim},
        {ldelim}name : 'sqli_codepostal', value : "{$maCollection.data_map.sqli_codepostal.content}"{rdelim},
        {ldelim}name : 'sqli_commune', value : "{$maCollection.data_map.ville.content}"{rdelim},
        {ldelim}name : 'sqli_pays', value : "France"{rdelim},
	{foreach $infocomp as $key => $value}
		{if $value|ne('')}
		{ldelim}name : "{concat('sqli_infocomp_',$incinfo)}", value : "{$value}"{rdelim},
		{set $incinfo = $incinfo|inc}
		{/if}
	{/foreach}
        {ldelim}name : 'sqli_objetdem', value : "{$maCollection.data_map.votre_message.content|explode('\r\n')|implode(' ')}"{rdelim},
        {ldelim}name : 'sqli_civilite', value : "{$civilite}"{rdelim},
        {ldelim}name : 'sqli_modereponse', value : "Courrier"{rdelim},
        {ldelim}name : 'sqli_urlsiteweb', value : ""{rdelim},
    {if and(eq($maCollection.data_map.animations_actualites.content, 0), eq($maCollection.data_map.bons_plans_sejours.content, 0))}
		{ldelim}name : 'sqli_contactemail', value : "1"{rdelim},
	{/if}
    {if ne($maCollection.data_map.animations_actualites.content, 0)}
        {ldelim}name : 'sqli_campagneid[{ezini("WebForm", "IdNewsletters1", "ayaline.ini")}]', value : "1"{rdelim},
    {/if}
	{if ne($maCollection.data_map.bons_plans_sejours.content, 0)}
        {ldelim}name : 'sqli_campagneid[{ezini("WebForm", "IdNewsletters2", "ayaline.ini")}]', value : "1"{rdelim},
    {/if}
        {ldelim}name : 'sqli_typeform', value : "Demandes d'informations"{rdelim}
	];
	
	$.post(
		"{ezini('WebForm', 'UrlWebForm', 'ayaline.ini')}",
		data
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