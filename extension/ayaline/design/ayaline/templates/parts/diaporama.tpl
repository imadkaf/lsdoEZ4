{* Récupération du diaporama associé à la page courante *}
{def $diaporamas=array()}
{if is_set($cNode.node_id)}
	{set $diaporamas=fetch( 'content', 'reverse_related_objects',
	                     hash( 'object_id',            $cNode.contentobject_id,
	                           'attribute_identifier', 'diaporama/pages_cibles' ) )}
{/if}
{if $diaporamas|count}
				<!-- Slideshow controls -->
				<div id="headernav-outer">						
					<div class="btns-carres" id="headernav">
						<a class="btn" id="back" href="#"><span></span></a>
						<a class="btn" id="control" href="#"><span></span></a>
						<a class="btn" id="next" href="#"><span></span></a>
					</div>
				</div>
				<!-- jQuery handles for the text displayed on top of the images -->
				<div id="headertxt">
					<p class="caption">
						<span id="firstline"></span>
						<a href="#" id="secondline" target="_top"></a>
					</p>
				</div>
{/if}
{undef $diaporamas}