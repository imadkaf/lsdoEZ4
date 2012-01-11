{def $date_modification = $node.object.modified}
{if not($date_modification)}
{set $date_modification = $node.object.published}
{/if}
<div class="bloc-pertinence-global">
	<span>{"Relevance"|i18n("ayaline")} :</span> 
	<div class="bloc-pertinence">
		<div style="width: {$node.score_percent|wash}%;">&nbsp;</div>
	</div>
	{$node.score_percent|wash}%
	<div class="modification">{"Last change"|i18n("ayaline")} : <span class="date">{$date_modification|l10n( date )}</span></div>
	<div class="clear"></div>
</div>
<a href="{$node.global_url_alias}"><h3>{$node.name|wash}</h3></a>
<p>{$node.highlight}</p>
{undef $date_modification}
