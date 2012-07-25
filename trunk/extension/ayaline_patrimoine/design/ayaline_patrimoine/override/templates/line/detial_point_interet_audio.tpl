<div id="jp_container_1" class="jp-audio">
	<div class="jp-type-single">
	<div id="{concat($node.class_identifier,$node.node_id)}" class="jp-jplayer"></div>
		<div class="jp-gui jp-interface">
			<ul class="jp-controls">
				<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
				<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
				<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
				<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
				<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
				<li><a href="javascript:;" class="jp-volume-max" tabindex="1"
					title="max volume">max volume</a>
				</li>
			</ul>
			<div class="jp-progress">
				<div class="jp-seek-bar">
					<div class="jp-play-bar"></div>
				</div>
			</div>
			<div class="jp-volume-bar">
				<div class="jp-volume-bar-value"></div>
			</div>
			<div class="jp-time-holder">
				<div class="jp-current-time"></div>
				<div class="jp-duration"></div>
				<ul class="jp-toggles">
					<li><a href="javascript:;" class="jp-repeat" tabindex="1"
						title="repeat">repeat</a>
					</li>
					<li><a href="javascript:;" class="jp-repeat-off" tabindex="1"
						title="repeat off">repeat off</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="jp-title">
			<ul>
				<li>{attribute_view_gui attribute=$node.data_map.titre_audio}</li>
			</ul>
		</div>
		<div class="jp-no-solution">
			<span>Update Required</span> To play the media you will need to
			either update your browser to a recent version or update your <a
				href="http://get.adobe.com/flashplayer/" target="_blank">Flash
				plugin</a>.
		</div>
	</div>
</div>
<script type="text/javascript">  
{literal}
var id_div =  {/literal}"{concat($node.class_identifier,$node.node_id)}"{literal};

var div = '#'+id_div;
$(div).jPlayer({
	ready: function () {
		$(this).jPlayer("setMedia", {{/literal}
			mp3:{concat('content/download/',$node.data_map.fichier.contentobject_id,'/',$node.data_map.fichier.id,'/file/',$node.data_map.fichier.content.original_filename)|ezurl}
			{literal}
		});
	},
	{/literal}
	swfPath: {"javascript"|ezdesign},
	{literal}
	supplied: "mp3",
	wmode: "window"
});
{/literal}</script>

