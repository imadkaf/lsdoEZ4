{* S'il ya un champ email dans le formulaire, on le prend comme email d'envoi *}
{foreach $collection.attributes as $att}
	{if eq($att.contentobject_attribute.contentclass_attribute_identifier,'email')}
		{set-block scope=root variable=email_sender}{$att.data_text}{/set-block}
	{/if}
{/foreach}
{* Sujet *}
{if ezini_hasvariable('CollectedInfoMail','PrefixSubject','site.ini')}
	{*set-block scope=root variable=subject}{ezini('CollectedInfoMail','PrefixSubject','site.ini')|wash()}{$collection.object.name|wash)}{/set-block*}
	{set-block scope=root variable=subject}{ezini('CollectedInfoMail','PrefixSubject','site.ini')|wash()}{/set-block}
{else}
	{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name|wash))}{/set-block} 
{/if}
{* Email destinataire *}
{if $node.object.class_identifier|eq('contact')}
	{if ezini_hasvariable('CollectedInfoMail','Receivercontact','site.ini')}
		{set-block scope=root variable=email_receiver}{ezini('CollectedInfoMail','Receivercontact','site.ini')}{/set-block}
	{/if}
{elseif }
	{if ezini_hasvariable('CollectedInfoMail','Receiverquestion','site.ini')}
		{set-block scope=root variable=email_receiver}{ezini('CollectedInfoMail','Receiverquestion','site.ini')}{/set-block}
	{/if}
{/if}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr" xml:lang="fr">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
	</head>
	<body bgcolor="#ffffff" text="#000000">
	
	<p>Bonjour,</p>
	
	<p>{"The following information was collected"|i18n("design/standard/content/edit")}:<br/>
	{section name=Attribute loop=$collection.attributes}
		- <b>{$Attribute:item.contentclass_attribute_name|wash} : </b>{attribute_result_gui view=info attribute=$Attribute:item}<br/>
	{/section}
	</p>
	
	<p>--<br/>	
	Ce courriel a été envoyé automatiquement depuis le site internet de l'Office de Tourisme des Sables d'Olonne</p>
	
	</body>
</html>