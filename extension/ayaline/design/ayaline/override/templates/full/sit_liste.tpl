{def $nbPubs = 5}

{set-block scope=global variable=cache_ttl}0{/set-block}

<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{sit_recherche()}
	</div>

	<div class="bloc-right-in-bis">
		<div class="bloc-type{if eq($node.data_map.categorie.data_text, '1')} padding-lr{/if}">
			{* Récuperation des variables session *}
			{if ezhttp('saison', 'session', 'hasVariable')}
				{def $saisonId = ezhttp('saison', 'session')}
			{else}
				{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
			{/if}
			{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
				{def $topicId = ezhttp('topics', 'session')}
			{else}
				{def $topicId = array(ezini('NodeSettings','topicDefaut','content.ini'))}
			{/if}
			
			{def $affichageListeSIT = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id,
																							'attribute_identifier', 'affichage_liste_sit/liaison_liste' ) )}
			{set $affichageListeSIT = $affichageListeSIT.0}
			
			<h2 class="bloc-liste-h2">
				{def $titreListe = ''}
				{* Si le pere de la liste est Decouvrir ou Sejourner *}
				{if or(eq($node.parent.node_id, ezini('Noeuds','decouvrir','ayaline.ini')), eq($node.parent.node_id, ezini('Noeuds','sejourner','ayaline.ini')))}
					{* Recuperation de objets associes a la liste *}
					{def $objetsAsso = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
					{* Pour chaque objet associe *}
					{foreach $objetsAsso as $objetAsso}
						{* test sur le theme : si on est sur le theme par défaut, pas la peine de chercher le titre lié au theme *}
						{if $topicId|ne(ezini('NodeSettings','topicDefaut','content.ini'))}
							{* cas des contenus avec plusieurs emplacements : il faut regarder les différents noeuds *}
							{foreach $objetAsso.assigned_nodes as $rub}
								{* Si le pere de l'objet associe est une saison et qu'il a un titre *}
								{if and($rub.parent.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($rub.parent.data_map.title.value.0))}
									{* Si le pere de l'objet associe correspond a la saison en cours *}
									{if $rub.parent.data_map.title.value.0|eq($saisonId)}
										{* Si le theme en cours n'est pas celui par defaut *}
										{if ne($topicId.0, ezini('NodeSettings','topicDefaut','content.ini'))}
											{* Si l'attribut title_topic du theme en cours n'est pas vide *}
											{if ne($rub.data_map[concat('title_topic_', $topicId.0)].value, '')}
												{set $titreListe = $rub.data_map[concat('title_topic_', $topicId.0)].value}
											{else}
												{set $titreListe = $rub.name}
											{/if}
										{else}
											{set $titreListe = $rub.name}
										{/if}
									{/if}
								{/if}
							{/foreach}
						{/if}
					{/foreach}
				{else}
					{set $titreListe = $affichageListeSIT.name}
				{/if}
				{if ne($titreListe, '')}
					{$titreListe}
				{else} {* Cas ou la rubrique n'est pas associee a la saison selectionnee *}
					{$affichageListeSIT.name}
				{/if}
			</h2>
			<p class="clear"></p>
			
			{if ne($affichageListeSIT.data_map.short_description.content, '')}
				<p class="chapeau-bis">
					{attribute_view_gui attribute=$affichageListeSIT.data_map.short_description}
				</p>
			{else}
				<br />
			{/if}
			
			{if eq($affichageListeSIT.data_map.googlemaps.data_int, '1')}
				{if eq($node.data_map.categorie.data_text, '1')}
					{sit_liste('sit_liste_carte_1')}
				{else}
					{sit_liste('sit_liste_carte')}
				{/if}
			{/if}
			
			{sit_liste()}
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>
