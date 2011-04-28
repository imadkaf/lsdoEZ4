{* Faq list view *}
{*$node|attribute(show, 1)*}

<strong class="faq_question">{$node.name|wash}</strong>

<div class="faq_response">{attribute_view_gui attribute=$node.object.data_map.response}</div>