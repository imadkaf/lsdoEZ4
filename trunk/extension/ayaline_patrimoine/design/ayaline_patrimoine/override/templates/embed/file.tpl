{let attribute=$object.data_map.file}
{if $attribute.content}
    <a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>
        {$object.data_map.file.content.mime_type|mimetype_icon('small')}
        {$object.name|wash(xhtml)}
    </a>
{/if}
{/let}