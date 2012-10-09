<div id="audio-view">
	<div class="titre-video">{attribute_view_gui attribute=$node.data_map.titre_audio}</div>
	<div id="jpId"></div>
	<div id="jp_container_1" class="jp-audio">
		{attribute_view_gui attribute=$node.data_map.visuel image_class='imageLargeLibre'}
		<div class="jp-type-single">
			<div class="jp-no-solution">
				<span>Update Required</span>
				To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
			</div>
		</div>
	</div>
</div>
<script>

	$(document).ready(function(){ldelim}
		$("#jpId").jPlayer({ldelim}
			ready: function () {ldelim}
				$(this).jPlayer("setMedia", {ldelim}
					mp3:"{concat( '/content/download/', $node.data_map.fichier.contentobject_id, '/', $node.data_map.fichier.id,'/version/', $node.data_map.fichier.version , '/file/',$node.data_map.fichier.content.original_filename|urlencode )}"
				{rdelim}).jPlayer("play"); // Attempts to Auto-Play the media
			{rdelim},
			swfPath: {'javascript'|ezdesign},
			supplied: "mp3",
			wmode: "window",
			cssSelectorAncestor: "#jp_container_2",
			cssSelector: {ldelim}
				videoPlay: '.jp-video-play',
				play: '.jp-play',
				pause: '.jp-pause',
				stop: '.jp-stop'
			{rdelim}
		{rdelim});
	{rdelim});
</script>