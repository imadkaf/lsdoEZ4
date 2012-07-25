{def $array_class = ezini( 'Class_suggestion', 'Class', 'ayaline_patrimoine.ini' )}
{def $child_suggest = fetch('content','list',hash('parent_node_id',$cNode.node_id,
                                                'class_filter_type','include',
                                                'class_filter_array', $array_class))}

{def $class_sit = ezini( 'Class_suggestion', 'Class_SIT', 'ayaline_patrimoine.ini' )}

{* On boucle pour afficher tous les enfants *}
{foreach $child_suggest as $child}
	{* L'affichage n'est pas le même s'il s'agit d'un contenu provenant du SIT ou d'un contenu brut *}
	{if $child.class_identifier|eq($class_sit)}
		{include uri="design:parts/agenda_suggestion.tpl" child_node=$child}
	{else}
		{include uri="design:parts/mise_avant_suggestion.tpl" child_node=$child}
	{/if}
{/foreach}

{undef $array_class $child_suggest $class_sit}