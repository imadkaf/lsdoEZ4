{set-block scope=root variable=subject}{"Collected information from %1"|i18n("design/standard/content/edit",,array($collection.object.name|wash))}{/set-block}

{* Use this line to specify the email of receiver, sender and reply-to in the template,
   can read this from the object to make it dynamic pr form
{set-block scope=root variable=email_receiver}nospam@ez.no{/set-block}
{set-block scope=root variable=email_sender}custom_sender@example.com{/set-block}
{set-block scope=root variable=email_reply_to}custom_reply_to@example.com{/set-block}
*}

{set-block scope=root variable=email_receiver}jmace+lsdo@ayaline.com{/set-block}

{* Set this to redirect to another node
{set-block scope=root variable=redirect_to_node_id}2{/set-block}
*}

{"The following information was collected"|i18n("design/standard/content/edit")}:

{section name=Attribute loop=$collection.attributes}
{$Attribute:item.contentclass_attribute_name|wash}:
{attribute_result_gui view=info attribute=$Attribute:item}


{/section}
