<div id="audio-view">
	<div class="titre-video">{attribute_view_gui attribute=$node.data_map.titre_audio}</div>
	<div id="jpId"></div>
	<div id="jp_container_1" class="jp-audio">
		<div class="jp-type-single">
			<div class="jp-gui jp-interface">
				<ul class="jp-controls">
					<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
					<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
					<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
				</ul>
				<div class="jp-progress">
					<div class="jp-seek-bar">
						<div class="jp-play-bar"></div>
					</div>
				</div>
				<div class="jp-time-holder">
					<div class="jp-current-time"></div>
					<div class="jp-duration"></div>

					<ul class="jp-toggles">
						<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
						<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
					</ul>
				</div>
			</div>
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
				{rdelim});
			{rdelim},
			swfPath: {'javascript'|ezdesign},
			supplied: "mp3",
			wmode: "window",
			cssSelectorAncestor: "#jp_container_1",
			cssSelector: {ldelim}
				videoPlay: '.jp-video-play',
				play: '.jp-play',
				pause: '.jp-pause',
				stop: '.jp-stop',
				repeat: '.jp-repeat',
				repeatOff: '.jp-repeat-off'
			{rdelim}
		{rdelim});
	{rdelim});
</script>