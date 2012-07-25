<div id="jp_container_1" class="jp-video jp-video-360p">
	<div class="jp-type-single">
		<div id="{concat($node.class_identifier,$node.node_id)}" class="jp-jplayer video_interne"></div>
		<div class="jp-gui">
			<div class="jp-video-play">
				<a href="javascript:;" class="jp-video-play-icon" tabindex="1">play</a>
			</div>
			<div class="jp-interface">
				<div class="jp-progress">
					<div class="jp-seek-bar">
						<div class="jp-play-bar"></div>
					</div>
				</div>
				<div class="jp-current-time"></div>
				<div class="jp-duration"></div>
				<div class="jp-controls-holder">
					<ul class="jp-controls">
						<li><a href="javascript:;" class="jp-play" tabindex="1">play</a>
						</li>
						<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a>
						</li>
						<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="jp-no-solution">
			<span>Update Required</span> To play the media you will need to
			either update your browser to a recent version or update your <a
				href="http://get.adobe.com/flashplayer/" target="_blank">Flash
				plugin</a>.
		</div>
	</div>
</div>
<div class="titre-video">{attribute_view_gui attribute=$node.data_map.titre_video}</div>
<script type="text/javascript">  
{literal}
var id_div =  {/literal}"{concat($node.class_identifier,$node.node_id)}"{literal};
//var id_div = $(".video_interne").attr("id");
var div = '#'+id_div;

$(div).jPlayer({
ready: function(){
			$(this).jPlayer("setMedia", {{/literal}
			{if $node.data_map.fichier_video.content.mime_type_part|eq('ogg')}
				"ogv": {concat('content/download/',$node.data_map.fichier_video.contentobject_id,'/',$node.data_map.fichier_video.id,'/file/',$node.data_map.fichier_video.content.original_filename)|ezurl},
			{else}
				"m4v": {concat('content/download/',$node.data_map.fichier_video.contentobject_id,'/',$node.data_map.fichier_video.id,'/file/',$node.data_map.fichier_video.content.original_filename)|ezurl},
			{/if}
				"poster": {$node.data_map.visuel.content.original.full_path|ezurl}
				{literal}
			});
		},{/literal}
		swfPath: {"javascript"|ezdesign},{literal}
		supplied: "ogv, m4v",
		size: {
			width: "320px",
			height: "241px",
			cssClass: "jp-video-360p"
		}
});{/literal}</script>
