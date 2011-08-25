{* Récuperation des variables session *}
{if ezhttp('saison', 'session', 'hasVariable')}
	{def $saisonId = ezhttp('saison', 'session')}
{else}
	{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
{/if}
{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
	{def $topicIds = ezhttp('topics', 'session')}
{else}
	{def $topicIds = array(ezini('NodeSettings','topicDefaut','content.ini'))}
{/if}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{include uri='design:parts/menu_gauche_interne.tpl'}
	</div>

	<div class="bloc-right-in-bis">
		{*** Liste des fils de la rubrique ***}
		{* Initialisations pour la pagination *}
		{def $nb_max = 4}
		{def $offset = 0}
		{if $view_parameters.offset|gt(0)}
			{set $offset = $view_parameters.offset}
		{/if}
	
		{*** Traitement pour recuperer les fils a afficher ***}
		{* Liste totale des fils *}
		{def $childrenTotal = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
															'sort_by', $node.sort_array,
															'class_filter_type' , 'include',
															'class_filter_array', array('rubric', 'sit_liste')))}
		
		{* Tableau qui contiendra les fils a afficher *}
		{def $childrenAssocie = array()}
		
		{def $childAjoute = false()}
		{def $affichageListeSIT = ''}
	
		{* Ajout des fils a afficher *}
		{foreach $childrenTotal as $children}
			{* Si le noeud possede l'attribut topics *}
			{if is_set($children.data_map.topics)}
				{* Pour chaque theme associe *}
				{foreach $children.data_map.topics.content.relation_list as $relation1}
					{* Si le fils n'est pas deja ajoute *}
					{if ne($childAjoute, true())}
						{* Si un theme associe correspond a un theme selectionne *}
						{if $relation1.node_id|eq($topicIds.0)}
							{set $childrenAssocie = $childrenAssocie|append($children)}
							{set $childAjoute = true()}
						{/if}
					{/if}
				{/foreach}
			{else}
				{* Si le noeud est de type liste_sit *}
				{if eq($children.object.class_identifier, ezini('ClassSettings','ClassListeSIT','content.ini'))}
					{* On recupere ses themes associes *}
					{set $affichageListeSIT = fetch('content', 'reverse_related_objects', hash( 'object_id', $children.contentobject_id, 'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
					{set $affichageListeSIT = $affichageListeSIT.0}
					{* Pour chacun de ses themes associes *}
					{foreach $affichageListeSIT.data_map.topics.content.relation_list as $relation2}
						{* Si le fils n'est pas deja ajoute *}
						{if ne($childAjoute, true())}
							{* Si un theme associe correspond a un theme selectionne *}
							{if $relation2.node_id|eq($topicIds.0)}
								{set $childrenAssocie = $childrenAssocie|append($children)}
								{set $childAjoute = true()}
							{/if}
						{/if}
					{/foreach}
				{/if}
			{/if}
			
			{set $childAjoute = false()}
		{/foreach}
		
		<div class="bloc-type">
			<h2 class="bloc-liste-h2">
				{if is_set($nameRubricSelected)}
					{$nameRubricSelected|wash}
				{else}
					{attribute_view_gui attribute = $node.data_map.title}
				{/if}
			</h2>
			<p class="clear"></p>
			
			<p class="chapeau">
				{attribute_view_gui attribute = $node.data_map.short_description}
			</p>
			
			{def $compteurlisterubrique2 = 1}
			<ul class="list">
				{foreach $childrenAssocie as $enfants sequence array( 'first', '' ) as $style offset $offset max $nb_max}
					<li class="{$style}">
						{node_view_gui content_node=$enfants view='line'}
					</li>
					{if and($childrenAssocie|count|gt($compteurlisterubrique2), $style|ne('first'))}
						</ul>
						<ul class="list">
					{/if}
					{set $compteurlisterubrique2 = $compteurlisterubrique2|inc}
				{/foreach}
			</ul>
			
			{* Affichage de la pagination *}
			{include 
				uri='design:navigator/google.tpl' 
				page_uri=$node.url_alias
				item_count=$childrenAssocie|count
				view_parameters=$view_parameters 
				item_limit=$nb_max
			}
		</div>
	</div>
	{*** Fin liste des fils de la rubrique ***}
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>

{literal}
	<script type="text/javascript">
		$(window).load(equilibrerHauteursBlocs);
	</script>
{/literal}
