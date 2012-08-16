{def $nbPubs = 5}

{* utile pour le tracking Google Analytics *}
{foreach $node.data_map.categorie.class_content.options as $option}
	{if eq($option.id,$node.data_map.categorie.data_text)}
		<script type="text/javascript">categorie="{$option.name}";</script>
	{/if}
{/foreach}


<div class="bloc-left-bis">
	<div class="bloc-left-in-bis">
		{if eq($node.data_map.form_recherche.data_text, 0)}
			{sit_recherche()}
		{/if}
		
		{if eq($node.parent.node_id, ezini('Noeuds','Sejourner','ayaline.ini'))}

			<div>
				{def $listeHebergement = fetch('content','list', hash( 
												'parent_node_id', $node.parent.node_id,
												'sort_by', $node.sort_array,
												'class_filter_type',  'include',
												'class_filter_array', array('sit_liste')))}
				
				{if $listeHebergement|count}
					<ul class="menu-left">

						<li class="actif">
							<span>{"Others housings"|i18n("ayaline")}</span>
							<ul class="s-menu">

							{foreach $listeHebergement as $hbgt}
								<li><a href={$hbgt.url_alias|ezurl}>{$hbgt.name}</a></li>
							{/foreach}
							</ul>
						</li>
					</ul>
				{/if}
				{undef $listeHebergement}
			</div>	
		{else}
			{def $listeRubriques = fetch('content','list', hash( 
											'parent_node_id', $node.parent.node_id,
											'sort_by', $node.sort_array,
											'class_filter_type',  'exclude',
											'class_filter_array', array('sit_mise_en_avant', 'sit_fiche')))}
			
			{if $listeRubriques|count}
				<ul class="menu-left">

					<li class="actif">
						<span>{$node.parent.name}</span>
						<ul class="s-menu">

						{foreach $listeRubriques as $rub}
							<li><a href={$rub.url_alias|ezurl}>{$rub.name}</a></li>
						{/foreach}
						</ul>
					</li>
				</ul>
			{/if}
			{undef $listeRubriques}
		{/if}
	</div>
	
	<div class="bloc-right-in-bis">
		<div class="bloc-type{if ne($node.data_map.categorie.data_text, '4')} padding-lr{/if}">
			{* Récuperation des variables session *}
			{if ezhttp('saison', 'session', 'hasVariable')}
				{def $saisonId = ezhttp('saison', 'session')}
			{else}
				{def $saisonId = ezini('ClassSettings','DefaultSeasonId','content.ini')}
			{/if}
			{if and(ezhttp('topics', 'session', 'hasVariable'),ezhttp('topics', 'session')|count|ne(0))}
				{def $topicId = ezhttp('topics', 'session')}
			{else}
				{def $topicId = array(ezini('NodeSettings','TopicDefaut','content.ini'))}
			{/if}
			
			<h2 class="bloc-liste-h2">
				{def $titreListe = ''}
				{* Si le pere de la liste est Decouvrir ou Sejourner *}
				{if or(eq($node.parent.node_id, ezini('Noeuds','Decouvrir','ayaline.ini')), eq($node.parent.node_id, ezini('Noeuds','Sejourner','ayaline.ini')))}
					{* Recuperation de objets associes a la liste *}
					{def $objetsAsso = fetch('content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'sub_menu/content' ) )}
					{* Pour chaque objet associe *}
					{foreach $objetsAsso as $objetAsso}
						{* test sur le theme : si on est sur le theme par défaut, pas la peine de chercher le titre lié au theme *}
						{if $topicId|ne(ezini('NodeSettings','TopicDefaut','content.ini'))}
							{* cas des contenus avec plusieurs emplacements : il faut regarder les différents noeuds *}
							{foreach $objetAsso.assigned_nodes as $rub}
								{* Si le pere de l'objet associe est une saison et qu'il a un titre *}
								{if and($rub.parent.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($rub.parent.data_map.title.value.0))}
									{* Si le pere de l'objet associe correspond a la saison en cours *}
									{if $rub.parent.data_map.title.value.0|eq($saisonId)}
										{* Si le theme en cours n'est pas celui par defaut *}
										{if ne($topicId.0, ezini('NodeSettings','TopicDefaut','content.ini'))}
											{* Si l'attribut title_topic du theme en cours n'est pas vide *}
											{if ne($rub.data_map[concat('title_topic_', $topicId.0)].value, '')}
												{set $titreListe = $rub.data_map[concat('title_topic_', $topicId.0)].value}
											{else}
												{set $titreListe = $rub.object.name}
											{/if}
										{else}
											{set $titreListe = $rub.object.name}
										{/if}
									{/if}
								{/if}
							{/foreach}
						{/if}
					{/foreach}
				{else}
					{set $titreListe = $node.name|wash}
				{/if}
				{if ne($titreListe, '')}
					{$titreListe}
				{else} {* Cas ou la rubrique n'est pas associee a la saison selectionnee *}
					{$node.name|wash}
				{/if}
			</h2>
			<p class="clear"></p>
			
			{if ne($node.data_map.short_description.content, '')}
				<p class="chapeau-bis">
					{attribute_view_gui attribute=$node.data_map.short_description}
				</p>
			{else}
				<br />
			{/if}
			
			{def $param_url = ''}
			{foreach $view_parameters as $param => $valParam}
				{if $valParam}
					{set $param_url = concat($param_url, '/(', $param, ')/', $valParam)}
				{/if}
			{/foreach}
			{if eq($node.data_map.googlemaps.data_int, '1')}
				{if is_set($view_parameters.goutte)}
					{sit_liste('sit_liste_carte')}
				{/if}
			{/if}
			{def $mise_en_avant = fetch( 'content','list',hash(
				'parent_node_id', $node.node_id,
				'limit', 1,
				'attribute_filter', array(array('sit_mise_en_avant/mode_affichage', '=', '6'))
			))}
			{if eq($view_parameters.recherche,'')}
				{if $mise_en_avant}
					{sit_mise_en_avant($mise_en_avant.0, $mise_en_avant.0.data_map.mode_affichage.value, 'sit_remontee_liste')}
				{/if}
			{/if}
			
			{if eq($node.data_map.googlemaps.data_int, '1')}
				{if is_set($view_parameters.goutte)}
					{*sit_liste('sit_liste_carte')*}
				{else}
					<div class="visualiserCarte">
						<div{if not($mise_en_avant)} class="top40"{/if}>
							<a class="liste-goutte" href={concat($node.url_alias, $param_url, '/(goutte)/1')|ezurl}>
								<img alt="{"View on the map"|i18n("ayaline")}" src={"pictoGmaps.png"|ezimage} width="13px">
								<h3>{"View on the map"|i18n("ayaline")}</h3>
								<div class="clear"></div>
							</a>
						</div>
					</div>
					<div class="clear"></div>
				{/if}
			{/if}
			{undef $mise_en_avant}
			{sit_liste()}
		</div>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/publicites.tpl' nbPubs = $nbPubs}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>
