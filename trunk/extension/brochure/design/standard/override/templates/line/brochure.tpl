{* Brochure list view *}

<div>
	<strong class="brochure_line_title">{$node.name|wash}</strong>

	<div class="brochure_line_file">{attribute_view_gui attribute=$node.object.data_map.brochure_file}</div>

	<div class="brochure_line_link">{attribute_view_gui attribute=$node.object.data_map.brochure_link}</div>
</div>
