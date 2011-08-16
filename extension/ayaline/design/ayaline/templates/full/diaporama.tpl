{def $url = ""}

{def $diaporamas1 = array()}
{def $diaporamas2 = array()}

{def $diapos = ""}

{*** Cas du diaporama associé à la page courante ***}
{if is_set($cNode.node_id)}
	{set $diaporamas1=fetch('content', 'reverse_related_objects', hash( 'object_id',$cNode.contentobject_id, 'attribute_identifier', 'diaporama/pages_cibles' ) )}
{/if}

{if $diaporamas1|count}
	{* Récupération des diapos du diaporama *}
	{def $diapos1=fetch('content','list',hash('parent_node_id',$diaporamas1.0.main_node_id, 'class_filter_type' , 'include', 'class_filter_array' , array('diapo')))}
	
	{* Si le diaporama n'est pas vide *}
	{if $diapos1|count}
		{set $diapos = $diapos1}
	{/if}
{/if}

{*** Cas du diaporama de la saison courante ***}
{if eq($diapos, "")}
	{def $nodeSeasons1 = fetch(content, node, hash(node_id,ezini('NodeSettings','SeasonListNode','content.ini')))}
	{foreach $nodeSeasons1.children as $nodeSeason1}
		{if and($nodeSeason1.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')),is_set($nodeSeason1.data_map.title.value.0))}
			{if $nodeSeason1.data_map.title.value.0|eq($saisonId)}
				{set $diaporamas2 = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $nodeSeason1.contentobject_id, 'attribute_identifier', 'diaporama/pages_cibles' ) )}
			{/if}
		{/if}
	{/foreach}
	{if $diaporamas2|count}
		{* Récupération des diapos du diaporama *}
		{def $diapos2=fetch('content','list',hash('parent_node_id', $diaporamas2.0.main_node_id, 'class_filter_type' , 'include', 'class_filter_array' , array('diapo')))}
		
		{* Si le diaporama n'est pas vide *}
		{if $diapos2|count}
			{set $diapos = $diapos2}
		{/if}
	{/if}
{/if}

{*
Test1 : {$diapos.0.data_map.nouvel_onglet.content} : Fin Test1
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
Test2 : {$diapos.1.data_map.nouvel_onglet.content} : Fin Test2
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
Test3 : {$diapos.1.data_map.nouvel_onglet.content} : Fin Test3
*}

{*** Traitement diaporama ***}
{if ne($diapos, "")}
	{literal}
	<script type="text/javascript">	
				// Speed of the automatic slideshow
				var slideshowSpeed = 6000;
	
				//Path of images folder
				var imagesPath = {/literal}{''|ezimage}{literal};
	
				// Variable to store the images we need to set as background
				// which also includes some text and url's.
				var photos = [ 
		{/literal}
		{foreach $diapos as $diapo}
			{if $diapo.data_map.url_interne.has_content}
				{set $url = $diapo.data_map.url_interne.content.main_node.url_alias|ezurl(no, full)}
			{else}
				{set $url = $diapo.data_map.url_externe.content}
			{/if}
			{ldelim}
					"title" : "{$diapo.data_map.titre.content}",
					"image" : "{$diapo.data_map.image.content.original.full_path}",
					"url" : "{$url}",
					"firstline" : "{$diapo.data_map.titre.content}",
					"secondline" : "{$diapo.data_map.accroche.content}",
					"nouvelonglet" : "{$diapo.data_map.nouvel_onglet.content}"
			{rdelim},
		{/foreach}
		{literal}
				];
	
				$(document).ready(function() {
					// Backwards navigation
					$("#back").click(function() {
						stopAnimation();
						navigate("back");
					});
					
					// Forward navigation
					$("#next").click(function() {
						stopAnimation();
						navigate("next");
					});
					
					var interval;
					$("#control").toggle(function(){
						stopAnimation();
					}, function() {
						// Change the background image to "pause"
						$(this).css({ "background-image" : "url(" + imagesPath + "btn_pause.png)" });
						
						// Show the next image
						navigate("next");
						
						// Start playing the animation
						interval = setInterval(function() {
							navigate("next");
						}, slideshowSpeed);
					});
								
								
					var activeContainer = 1;	
					var currentImg = 0;
					var animating = false;
					var navigate = function(direction) {
						// Check if no animation is running. If it is, prevent the action
						if(animating) {
							return;
						}
						
						// Check which current image we need to show
						if(direction == "next") {
							currentImg++;
							if(currentImg == photos.length + 1) {
								currentImg = 1;
							}
						} else {
							currentImg--;
							if(currentImg == 0) {
								currentImg = photos.length;
							}
						}
						
						// Check which container we need to use
						var currentContainer = activeContainer;
						if(activeContainer == 1) {
							activeContainer = 2;
						} else {
							activeContainer = 1;
						}
						
						showImage(photos[currentImg - 1], currentContainer, activeContainer);
						
					};
					
					var currentZindex = -1;
					var showImage = function(photoObject, currentContainer, activeContainer) {
						if (photoObject) {
							animating = true;
							
							// Make sure the new container is always on the background
							currentZindex--;
							
							// Set the background image of the new active container
							if (photoObject.image) {
								$("#headerimg" + activeContainer).css({
									"background-image" : "url(" + photoObject.image + ")",
									"display" : "block",
									"z-index" : currentZindex
								});
							}
							
							// Hide the header text
							$("#headertxt").css({"display" : "none"});
							
							// Set the new header text
							$("#firstline").html(photoObject.firstline);
							$("#secondline")
								.attr("href", photoObject.url)
								.html(photoObject.secondline);
							if(photoObject.nouvelonglet == 1){
								$("#secondline").attr("target", "_blank");
							}
							else{
								$("#secondline").attr("target", "_top");
							}
							$("#pictureduri")
								.attr("href", photoObject.url)
								.html(photoObject.title);
							
							
							// Fade out the current container
							// and display the header text when animation is complete
							$("#headerimg" + currentContainer).fadeOut(function() {
								setTimeout(function() {
									$("#headertxt").css({"display" : "block"});
									animating = false;
								}, 500);
							});
						}
					};
					
					var stopAnimation = function() {
						// Change the background image to "play"
						$("#control").css({ "background-image" : "url(" + imagesPath + "btn_play.png)" });
						
						// Clear the interval
						clearInterval(interval);
					};
					
					// We should statically set the first image
					navigate("next");
					
					// Start playing the animation
					interval = setInterval(function() {
						navigate("next");
					}, slideshowSpeed);
					
					//Menu left
					$("ul.menu-left > li").click(function(){
						$("ul.menu-left > li.actif").removeClass("actif");
						$(this).addClass("actif");
					});
					
				});
			</script>
	{/literal}
	<!-- jQuery handles to place the header background images -->
	<div id="headerimgs">
	<div id="headerimg1" class="headerimg"></div>
	<div id="headerimg2" class="headerimg"></div>
	</div>
	<!---->



{*** Cas image ***}
{else}
	{def $imageEntete = array()}
	{def $defaultDiapo = false()}
	{def $img_attribute = array()}
	{def $pNode = array()}
	{def $continue = true()}
	{if is_set($cNode.node_id)}
		{set $imageEntete = fetch('content', 'reverse_related_objects', hash( 'object_id',$cNode.contentobject_id, 'attribute_identifier', 'image_entete/pages_cibles' ) )}
	{/if}
	{if $imageEntete|count}
		{set $img_attribute = $imageEntete.0.data_map.image}
	{else}
		{if and($cNode, $cNode.parent)}
			{set $pNode = $cNode.parent}
		{else}
			{set $pNode = $previousNode}
		{/if}
		{if $pNode}
			{while $continue}
				{if ne($pNode.node_id, ezini('Noeuds','home','ayaline.ini'))}
					{set $imageEntete = fetch('content', 'reverse_related_objects', hash( 'object_id',$pNode.contentobject_id, 'attribute_identifier', 'image_entete/pages_cibles' ) )}
					{if $imageEntete|count}
						{set $img_attribute = $imageEntete.0.data_map.image}
						{set $continue = false()}
						{break}
					{/if}
					{set $pNode = $pNode.parent}
				{else}
					{set $continue = false()}
				{/if}
			{/while}
		{/if}
		{if eq(0, $img_attribute|count)}
			{set $defaultDiapo = true()}
		{/if}
	{/if}
	
	{if $defaultDiapo}
		{def $nodeSeasons = fetch(content, node, hash(node_id, ezini('NodeSettings','SeasonListNode','content.ini')))}
		{foreach $nodeSeasons.children as $nodeSeason}
			{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
				{if	$nodeSeason.data_map.title.value.0|eq($saisonId)}
					{if	$nodeSeason.children|count}
						{foreach $nodeSeason.children.0.data_map as	$attribute}
							{if $attribute.data_type_string|eq('ezimage')}
								{set $img_attribute = $attribute}
								{break}
							{/if}
						{/foreach}
					{/if}
				{/if}
			{/if}
		{/foreach}
	{/if}

	<div id="headerdiapos">
		{attribute_view_gui attribute=$img_attribute img_class='headerdiapo' image_class='diapo_header' dimension=false()}
	</div>
	<script type="text/javascript">
		var obj = document.getElementById('header');
		obj.style.height = "300px";
	</script>
	
	{undef $defaultDiapo $img_attribute}
	
{/if}

{undef $diapos $url}
