{if $attribute.content}
	{* Gestion des tags google analytics*}
	
	{def $gTags=$attribute.data_text|explode(';')}
	<a href={concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl} onClick="_gaq.push(['_trackEvent','{$gTags[0]}','{$gTags[1]}','{$gTags[2]}']);">{$attribute.content.original_filename|wash( xhtml )}</a>
{/if}