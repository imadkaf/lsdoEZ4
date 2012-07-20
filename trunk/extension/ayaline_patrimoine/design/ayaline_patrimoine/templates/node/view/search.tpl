<div class="bloc-pertinence-global">
	<span>Pertinence :</span> 
	<div class="bloc-pertinence">
		<div style="width: {$node.score_percent|wash}%;">&nbsp;</div>
	</div>
	{$node.score_percent|wash}%
	<div class="modification">Dernière modification : <span class="date">{$node.object.modified|l10n( 'shortdate' )}</span></div>
	<div class="clear"></div>
</div>
<a href="{$node.global_url_alias}" rel='external'><h3>{striptags($node.name|wash)}</h3></a>
<p>{striptags($node.highlight)}</p>
