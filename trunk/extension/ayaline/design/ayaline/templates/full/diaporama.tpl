{* Récupération du diaporama associé à la page courante *}
{def $diaporamas=fetch( 'content', 'reverse_related_objects',
                     hash( 'object_id',            $cNode.contentobject_id,
                           'attribute_identifier', 'diaporama/pages_cibles' ) )}
{def $url = ""}
{if $diaporamas|count}
	{* Récupération des diapos du diaporama *}
    {def $diapos=fetch('content','list',hash('parent_node_id',  $diaporamas.0.main_node_id,
													 'class_filter_type' , 'include',
													 'class_filter_array' , array('diapo')))}
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
							animating = true;
							
							// Make sure the new container is always on the background
							currentZindex--;
							
							// Set the background image of the new active container
							$("#headerimg" + activeContainer).css({
								"background-image" : "url(" + photoObject.image + ")",
								"display" : "block",
								"z-index" : currentZindex
							});
							
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
	
					function showHideSelect(select)
					{
					    var objSelect = document.getElementById(select);
					    objSelect.style.display = (objSelect.style.display == 'block') ? 'none' : 'block';
					}
					function validAndHide(txt, obj, input, select)
					{
					    document.getElementsByName(input).value = txt;
					    obj.parentNode.parentNode.style.display = 'none';
					    document.getElementById(select).innerHTML = obj.innerHTML;
					}
				</script>
{/literal}
				<!-- jQuery handles to place the header background images -->
				<div id="headerimgs">
					<div id="headerimg1" class="headerimg"></div>
					<div id="headerimg2" class="headerimg"></div>
				</div>
				<!---->
{/if}
{undef $diaporamas $url}