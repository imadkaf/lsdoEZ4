{def $node_id = $module_result.node_id}
{def $node=fetch( 'content', 'node', hash( 'node_id', $node_id ) )} 

{* Récupération du diaporama associé à la page courante *}
{def $diaporamas=fetch( 'content', 'reverse_related_objects',
                     hash( 'object_id',            $node.contentobject_id,
                           'attribute_identifier', 'diaporama/pages_cibles' ) )}

{def $diaporamasCount = $diaporamas|count()}

{foreach $diaporamas as $diaporama}
	{* Récupération des diapos du diaporama *}
    {def $nbDiapos=fetch('content','list_count',hash('parent_node_id',  $diaporama.main_node_id,
													 'class_filter_type' , 'include',
													 'class_filter_array' , array('diapo')))}
{/foreach}

{if and(ne($diaporamasCount,0),ne($nbDiapos,0))}
	{* Si un diaporama est associé à la page courante *}
	
	<div id="header-image">
		{foreach $diaporamas as $diaporama}
			{* Récupération des diapos du diaporama *}
		    {def $diapos=fetch('content','list',hash('parent_node_id',  $diaporama.main_node_id,
															 'class_filter_type' , 'include',
															 'class_filter_array' , array('diapo')))}
			
			{def $countDiapos = $diapos|count()}
			
			{* Si le diaporama associé à la page courante ne contient qu'une seule image, cette image s'affiche de façon statique *}
			{if eq($countDiapos,1)}
			
				{foreach $diapos as $diapo}

					{literal}
					<style type="text/css">
						#headerimg1 { 
							background-image: url({/literal}{$diapo.data_map.image.content.original.full_path}{literal}); 
						}
					</style>
					{/literal}
					
					<div id="header-diapo">
						<!-- jQuery handles to place the header background images -->
						<div id="headerimgs">
							<div id="headerimg1" class="headerimg"></div>
						</div>
						<!-- jQuery handles for the text displayed on top of the images -->
						<div id="headertxt">
							<p class="caption">
								<span id="firstline">{$diapo.data_map.titre.content}</span>
								{if $diapo.data_map.url_interne.has_content}
									<p id="secondline"><a href="{$diapo.data_map.url_interne.content.main_node.url_alias|ezurl(no, full)}">{$diapo.data_map.accroche.content}</a></p>
								{elseif $diapo.data_map.url_externe.has_content}
									<p id="secondline"><a href="{$diapo.data_map.url_externe.content}">{$diapo.data_map.accroche.content}</a></p>
								{else}
									<p id="secondline">{$diapo.data_map.accroche.content}</p>
								{/if}
							</p>
							
							{* 
								Bloc "Pictured" : n'est pas affiché pour le moment. 
								Pour afficher ce bloc : - créer un attribut dans la classe diapo qui sera le libellé du lien,
													 	- remplacer [VALEUR DU NOUVEL ATTRIBUT] par la valeur de cet attribut,
													 	- décommenter ce code :
								
								{if $diapo.data_map.url_interne.has_content}
									<p class="pictured">
										Pictured:
										<a href="{$diapo.data_map.url_interne.content.main_node.url_alias|ezurl(no, full)}" id="pictureduri"> [VALEUR DU NOUVEL ATTRIBUT] </a>
									</p>
								{elseif $diapo.data_map.url_externe.has_content}
									<p class="pictured">
										Pictured:
										<a href="{$diapo.data_map.url_externe.content}}" id="pictureduri"> [VALEUR DU NOUVEL ATTRIBUT] </a>
									</p>
								{/if}
							*}
							
						</div>
					</div>

				{/foreach}
			
			{*Si le diaporama associé à la page courante contient plusieurs images, affichage du diaporama dans le header*}
			{else}
				{* Définition du background du header pour la première diapo *}											 
				{literal}
				<style type="text/css">
					
					#headerimg1 { 
						background-image: url({/literal}{$diapos.0.data_map.image.content.original.full_path}{literal}); 
					}
					#headerimg2 { 
						background-image: url({/literal}{$diapos.1.data_map.image.content.original.full_path}{literal}); 
					}
					
				</style>
				{/literal}
				
				<div id="header-diapo">
					<!-- jQuery handles to place the header background images -->
					<div id="headerimgs">
						<div id="headerimg1" class="headerimg"></div>
						<div id="headerimg2" class="headerimg"></div>
					</div>
					<!-- Slideshow controls -->
					<div id="headernav-outer">
						{* 
							Pour modifier le style des boutons de contrôle : modifier la classe du div #headernav 
							+ modifier dans le javascript l'image appelée au moment du Change the background image to "pause"
							+ modifier dans le javascript l'image appelée au moment du Change the background image to "play"
						*}
						<div id="headernav" class="btns-carres">
							<a href="#" id="back" class="btn"><span></span></a>
							<a href="#" id="control" class="btn"><span></span></a>
							<a href="#" id="next" class="btn"><span></span></a>
						</div>
					</div>
					<!-- jQuery handles for the text displayed on top of the images -->
					<div id="headertxt">
						<p class="caption">
							<span id="firstline"></span>
							<p id="secondline"></p>
						</p>
						
						{* 
							Bloc "Pictured" : n'est pas affiché pour le moment.
							Pour afficher ce bloc : - créer un attribut dans la classe diapo qui sera le libellé du lien,
													- ajouter une ligne au tableau photos pour stocker la valeur de cet attribut (dans le javascript),
													- ajouter un test dans le javascript au moment du $("#pictureduri").attr("href", photoObject.url)... 
													  pour déterminer si la diapo en cours a cet attribut de renseigner et si on doit afficher ou non
													  ce bloc,
													- décommenter ce code : 
													 	
							<p class="pictured">
								Pictured:
								<a href="#" id="pictureduri"></a>
							</p>
						*}
						
					</div>
				</div>
						
				{* Construction du script qui permet l'enchaînement des images *}
				<script type="text/javascript">
					// Speed of the automatic slideshow
					var slideshowSpeed = 6000;
					
					// Variable to store the images we need to set as background
					// which also includes some text and url's.
					
					{* Tableau permettant de stocker les informations de chaque diapo *}
					{def $nbDiapos = $diapos|count()}
					var photos = [ 
					{foreach $diapos as $key=>$diapo}
						{def $url = ""}
						{if $diapo.data_map.url_interne.has_content}
							{set $url = $diapo.data_map.url_interne.content.main_node.url_alias|ezurl(no, full)}
						{else}
							{set $url = $diapo.data_map.url_externe.content}
						{/if}
						{literal}{{/literal}
							"title" : "{$diapo.data_map.titre.content}",
							"image" : "{$diapo.data_map.image.content.original.full_path}",
							"url" : "{$url}",
							"firstline" : "{$diapo.data_map.titre.content}",
							"secondline" : "{$diapo.data_map.accroche.content}",
							"nouvelonglet" : "{$diapo.data_map.nouvel_onglet.content}"
						{literal}}{/literal}
						{if ne($key,$nbDiapos|dec())},{/if}
						{undef $url}
					{/foreach}
					];
					
					$(document).ready(function() {ldelim}
		
					// Backwards navigation
					$("#back").click(function() {ldelim}
						stopAnimation();
						navigate("back");
					{rdelim});
					
					// Forward navigation
					$("#next").click(function() {ldelim}
						stopAnimation();
						navigate("next");
					{rdelim});
					
					var interval;
					$("#control").toggle(function(){ldelim}
						stopAnimation();
					{rdelim}, function() {ldelim}
						// Change the background image to "pause"
						$(this).find("span").css({ldelim} "background-image" : "url('extension/ez_aya_diaporama/design/standard/images/carousel-pause.png')" {rdelim});
						
						// Show the next image
						navigate("next");
						
						// Start playing the animation
						interval = setInterval(function() {ldelim}
							navigate("next");
						{rdelim}, slideshowSpeed);
					{rdelim});
					
					
					var activeContainer = 1;	
					var currentImg = 0;
					var animating = false;
					var navigate = function(direction) {ldelim}
						// Check if no animation is running. If it is, prevent the action
						if(animating) {ldelim}
							return;
						{rdelim}
						
						// Check which current image we need to show
						if(direction == "next") {ldelim}
							currentImg++;
							if(currentImg == photos.length + 1) {ldelim}
								currentImg = 1;
							{rdelim}
						{rdelim} else {ldelim}
							currentImg--;
							if(currentImg == 0) {ldelim}
								currentImg = photos.length;
							{rdelim}
						{rdelim}
						
						// Check which container we need to use
						var currentContainer = activeContainer;
						if(activeContainer == 1) {ldelim}
							activeContainer = 2;
						{rdelim} else {ldelim}
							activeContainer = 1;
						{rdelim}
						
						showImage(photos[currentImg - 1], currentContainer, activeContainer);
						
					{rdelim};
					
					var currentZindex = -1;
					var showImage = function(photoObject, currentContainer, activeContainer) {ldelim}
						animating = true;
						
						// Make sure the new container is always on the background
						currentZindex--;
						
						// Set the background image of the new active container
						$("#headerimg" + activeContainer).css({ldelim}
							"background-image" : "url(" + photoObject.image + ")",
							"display" : "block",
							"z-index" : currentZindex
						{rdelim});
						
						// Hide the header text
						$("#headertxt").css({ldelim}"display" : "none"{rdelim});
						
						// Set the new header text
						$("#firstline").html(photoObject.firstline);
						if(photoObject.url != "") {ldelim}
							$("#secondline").html('<a href="' + photoObject.url + '">' + photoObject.secondline + '</a>');
							if(photoObject.nouvelonglet == 1) {ldelim}
								$("#secondline").find("a").attr("target", "_blank")
							{rdelim}
						{rdelim} else {ldelim}
							$("#secondline").html(photoObject.secondline);
						{rdelim}
						
						// Code qui permet de mettre à jour le bloc "Pictured" (à modifier si on veut afficher ce bloc)
						$("#pictureduri")
							.attr("href", photoObject.url)
							.html(photoObject.title);
						
						// Fade out the current container
						// and display the header text when animation is complete
						$("#headerimg" + currentContainer).fadeOut(function() {ldelim}
							setTimeout(function() {ldelim}
								$("#headertxt").css({ldelim}"display" : "block"{rdelim});
								animating = false;
							{rdelim}, 500);
						{rdelim});
					{rdelim};
					
					var stopAnimation = function() {ldelim}
						// Change the background image to "play"
						$("#control").find("span").css({ldelim} "background-image" : "url('extension/ez_aya_diaporama/design/standard/images/carousel-play.png')" {rdelim});
						
						// Clear the interval
						clearInterval(interval);
					{rdelim};
					
					// We should statically set the first image
					navigate("next");
					
					// Start playing the animation
					interval = setInterval(function() {ldelim}
						navigate("next");
					{rdelim}, slideshowSpeed);
					
				{rdelim});

				</script>
				
			{/if}
		{/foreach}
	</div>
	
{else}
	{* 
		Si aucun diaporama n'est associé à la page courante : header "normal".
		Pour insérer le header par défaut (celui des pages n'ayant pas de diaporama),
		insérer le code du header ici ou faire un include.
	*}
	
	<div id="default-header">Header</div>
	
{/if}