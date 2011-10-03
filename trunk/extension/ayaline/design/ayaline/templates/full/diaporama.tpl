{def $url = ""}

{if is_set($previousNode)}
	{set $cNode = $previousNode}
{/if}
{*def $diaporamas="" commenté car déclaré dans pagelayout et réutilisé sans parts/diaporama.tpl *}

{def $diapos = ""}

{*** Cas du diaporama associé à la page courante ***}
{if is_set($cNode.node_id)}
	{set $diaporamas=fetch('content', 'reverse_related_objects', hash( 'object_id',$cNode.contentobject_id, 'attribute_identifier', 'diaporama/pages_cibles' ) )}
{/if}

{if $diaporamas|count}
	{* Récupération des diapos du diaporama *}
	{def $diapos1=fetch('content','list',hash('parent_node_id',$diaporamas.0.main_node_id, 'sort_by', $diaporamas.0.main_node.sort_array, 'class_filter_type' , 'include', 'class_filter_array' , array('diapo')))}
	{* Si le diaporama n'est pas vide *}
	{if $diapos1|count}
		{set $diapos = $diapos1}
	{/if}
{/if}

{*** Cas du diaporama de la saison courante ***}
{* le diapo de la saison ne doit s'afficher que pour la page d'accueil car sinon on va le retrouver partout et l'image entete reduite ne servira jamais (puisque que les diaporamas saisons seront configurés) ! *}
{if and(is_set($cNode.node_id),eq($diapos, ""))}
	{if $cNode.node_id|eq(ezini('NodeSettings','RootNode','content.ini'))}
		{def $nodeSeasons1 = fetch(content, node, hash(node_id,ezini('NodeSettings','SeasonListNode','content.ini')))}
		{foreach $nodeSeasons1.children as $nodeSeason1}
			{if and($nodeSeason1.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')),is_set($nodeSeason1.data_map.title.value.0))}
				{if $nodeSeason1.data_map.title.value.0|eq($saisonId)}
					{set $diaporamas = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $nodeSeason1.contentobject_id, 'attribute_identifier', 'diaporama/pages_cibles' ) )}
				{/if}
			{/if}
		{/foreach}
		{undef $nodeSeasons1}
	{/if}
	{if $diaporamas|count}
		{* Récupération des diapos du diaporama *}
		{def $diapos2=fetch('content','list',hash('parent_node_id', $diaporamas.0.main_node_id, 'sort_by', $diaporamas.0.main_node.sort_array, 'class_filter_type' , 'include', 'class_filter_array' , array('diapo')))}
		
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
					"image" : {$diapo.data_map.image.content.original.full_path|ezurl},
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
							$("#headertxt").animate({opacity: 0}, 500);
							
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
									$("#headertxt").animate({opacity: 1}, 500);
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
		{if and($cNode|is_set, $cNode|count|gt(0))}
			{* test sur le noeud : si on est sur l'accueil, on ne récupère pas le noeud parent *}
			{if and($cNode.node_id|ne(ezini('NodeSettings','RootNode','content.ini')), $cNode.parent|is_set)}
				{set $pNode = $cNode.parent}
			{else}
				{set $pNode = $cNode}
			{/if}
		{/if}
		{if and($pNode|is_set, $pNode|count|gt(0))}
			{* Tant qu'on n'est pas sur le noeud 2 (accueil) ou 43 (accueil Media) on remonte au noeud parent pour récupérer l'image de l'entete *}
			{while $continue}	
				{if and(ne($pNode.node_id, ezini('NodeSettings','RootNode','content.ini')), ne($pNode.node_id, ezini('NodeSettings','MediaRootNode','content.ini')))}
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
		{* si pas d'image paramétrée, on prend l'image par défaut de la saison *}
		{if eq(0, $img_attribute|count)}
			{set $defaultDiapo = true()}
		{/if}
	{/if}
	
	{if $defaultDiapo}
		{* on regarde s'il existe une image par défaut (de type 'diapo') pour chaque saison *}
		{def $nodeSeasons = fetch(content, node, hash(node_id, ezini('NodeSettings','SeasonListNode','content.ini')))}
		{foreach $nodeSeasons.children as $nodeSeason}
			{* s'il s'agit de la classe 'saison' et que la valeur de la saison est renseignée *}
			{if and($nodeSeason.object.contentclass_id|eq(ezini('ClassSettings','ClassSeasonId','content.ini')), is_set($nodeSeason.data_map.title.value.0))}
				{* on teste si la valeur de la saison (id de liste déroulante) correspond à la saison en cours *}
				{if	$nodeSeason.data_map.title.value.0|eq($saisonId)}
					{* si la saison a des sous-éléments, on passe 1 à 1 les attributs du 1er sous-élément jusqu'à ce qu'on trouve un élément de type image *}
					
					{* -- TODO -- ne pas passer un à un les attributs mais faire un fetch spécifique sur une image d'entete (ou une image simple) *}
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
		{* si pas d'image par défaut pour la saison, on prend alors l'image par défaut de type 'image_entete_defaut' *}
		{if eq(0, $img_attribute|count)}
			{def $defaultImg = fetch( 'content', 'tree', hash( 'parent_node_id', ezini('NodeSettings','MediaRootNode','content.ini'),
																'class_filter_type', 'include',
           														'class_filter_array', array('image_entete_defaut') ) )}
           	
           	{* on prend la 1ère*}
           	{set $img_attribute = $defaultImg.0.data_map.image}
		{/if}
	{/if}
	<div id="headerdiapos" style='background-image: url({$img_attribute.content.diapo_header.url|ezroot}); height: {$img_attribute.content.diapo_header.height}px'></div>
	{undef $defaultDiapo $img_attribute}
	
{/if}

{undef $diapos $url}
