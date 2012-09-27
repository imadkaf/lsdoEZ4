{def $view_fonce = ezini( 'Class_suggestion', 'Value_view_mab_fonce', 'ayaline_patrimoine.ini' )}
{def $class_quizz = ezini( 'Class_suggestion', 'Class_quizz', 'ayaline_patrimoine.ini' )}
{* On défini la cible pour le lien *}
{def $targeturl = ""}
{if $child_node.data_map.url_cible.content|begins_with('http')}
	{set $targeturl = "_blank"}
{else}
	{undef $targeturl}
{/if}

{* L'affichage est différent suivant le choix fait par l'utilisateur : foncé ou clair et si elle est affichée depuis un quizz ou non *}
{if $child_node.data_map.view.value.0|eq($view_fonce)}
	{if $child_node.parent.class_identifier|eq($class_quizz)}
	<div class="instant-gagnant">
		<h2>{$child_node.name|wash}</h2>
		<span class="diaporama-gagnat ui-link">
		{attribute_view_gui attribute=$child_node.data_map.visuel image_class='imageSuggestion'}
		</span>
		<div class="contenu-gagnant">
			{attribute_view_gui attribute=$child_node.data_map.text}
			{if is_set($targeturl)}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='voir-lots ui-link' target=$targeturl}
			{else}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='voir-lots ui-link' rel='external'}
			{/if}
		</div>
	</div>
	{else}
	<div class="agenda">
		<h2>{$child_node.name|wash}</h2>
		{attribute_view_gui attribute=$child_node.data_map.visuel image_class='imageSuggestion'}
		<div class="contenu-agenda">
			{attribute_view_gui attribute=$child_node.data_map.text}
			{if is_set($targeturl)}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='plus-info-agenda ui-link' target=$targeturl}
			{else}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='plus-info-agenda ui-link' rel='external'}
			{/if}
		</div>
	</div>
	{/if}
{else}
	{if $child_node.parent.class_identifier|eq($class_quizz)}
	<div class="tirage-au-sort">
		<h2>{$child_node.name|wash}</h2>
		{attribute_view_gui attribute=$child_node.data_map.visuel image_class='imageSuggestion'}
		<div class="contenu-tirage-au-sort">
			{attribute_view_gui attribute=$child_node.data_map.text}
			{if is_set($targeturl)}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='tirage-au-sort ui-link' target=$targeturl}
			{else}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='tirage-au-sort ui-link' rel='external'}
			{/if}
		</div>
	</div>
	{else}
	<div class="suggestions">
		<h2>{$child_node.name|wash}</h2>
		<span class="diaporama-gagnat ui-link">
		{attribute_view_gui attribute=$child_node.data_map.visuel image_class='imageSuggestion'}
		</span>
		<div class="contenu-suggestions">
			{attribute_view_gui attribute=$child_node.data_map.text}
			{if is_set($targeturl)}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='plus-info-suggestions ui-link' target=$targeturl}
			{else}
				{attribute_view_gui attribute=$child_node.data_map.url_cible class='plus-info-suggestions ui-link' rel='external'}
			{/if}
		</div>
	</div>
	{/if}
{/if}

{undef $view_fonce, $class_quizz}