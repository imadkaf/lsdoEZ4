<div class="content-view-embed">
    <div class="class-folder">
		<div class="content-body">
			{let attribute=$object.data_map.file}
				{if $attribute.content}
					<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>{*$attribute.content.original_filename|wash(xhtml)*}<b>{$object.name|wash}</b></a> {*$attribute.content.filesize|si(byte)*}
				{/if}
			{/let}
			{attribute_view_gui attribute=$object.data_map.description}
		</div>
   	</div>
</div>
<br />
