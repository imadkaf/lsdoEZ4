<div class="bloc-pertinence-global">
	<span>Pertinence :</span> 
	<div class="bloc-pertinence">
		<div style="width: {$node.score_percent|wash}%;">&nbsp;</div>
	</div>
	{$node.score_percent|wash}%
	<div class="clear"></div>
</div>
<a href={$node.url_alias|ezurl} rel='external'><h3>{supp_br($node.name)|wash}</h3></a>
<p>{striptags($node.highlight)}</p>
