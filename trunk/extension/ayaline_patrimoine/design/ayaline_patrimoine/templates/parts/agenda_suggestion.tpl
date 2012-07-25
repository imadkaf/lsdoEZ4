{def $view_agenda = ezini( 'Class_suggestion', 'Value_view_agenda', 'ayaline_patrimoine.ini' )}

{* On détermine l'affichage à effectuer en fonction de la sélection:
	- Si la sélection est équivalente à la valeur définie dans le fichier ini ("Agenda" lors de la création de cette tpl) on affiche la vue agenda
	- Dans tous les autres cas, on affiche la vue basique
 *}
{if $child_node.data_map.mode_affichage.value.0|eq($view_agenda)}
<div class="agenda">
	<div class="onlineeditor">
		<h3>Agenda</h3>
		{sit_mise_en_avant($child_node, $child_node.data_map.mode_affichage.value, sit_mise_en_avant_agenda_suggestion)}
	</div>
</div>
{else}
<div class="suggestions">
	<div class="onlineeditor">
		<h3>{attribute_view_gui attribute=$child_node.data_map.title}</h3>
		{sit_mise_en_avant($child_node, $child_node.data_map.mode_affichage.value, sit_mise_en_avant_suggestion)}
	</div>
</div>
{/if}