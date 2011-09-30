<div class="bloc-left-bis">
	<div class="bloc-type padding-35px-32px">
		<h2 class="bloc-liste-h2">
			{attribute_view_gui attribute = $node.data_map.title}
		</h2>
		<p class="clear"></p>
	
		<p class="chapeau">
			{attribute_view_gui attribute = $node.data_map.short_description}
		</p>

		{def $limit = 9}
		{def $offset = 0}
		{if $view_parameters.offset|gt(0)}
			{set $offset = $view_parameters.offset}
		{/if}

		{def $children = fetch( 'content','list',hash( 'parent_node_id', $node.node_id,
														'sort_by', $node.sort_array,
														'class_filter_type' , 'include',
														'class_filter_array', array('image'),
														'limit',$limit,
	              										'offset',$offset))}

		{def $childrencount = fetch( 'content','list_count',hash( 'parent_node_id', $node.node_id,
																	'sort_by', $node.sort_array,
																	'class_filter_type' , 'include',
																	'class_filter_array', array('image')))}

		{def $compteurlistephototheque = 1}

		{if $children|count}
			<ul class="liste phototheque">
				{foreach $children as $enfants sequence array( '', '', 'last' ) as $style}
					<li class="{$style}">
						<h3 class="bloc-liste-h3">
							{$enfants.name}
						</h3>
						
						<a href={$enfants.data_map.image.content.original.url|ezurl} class="galeriephototheque">{attribute_view_gui attribute=$enfants.data_map.image image_class='phototheque'}</a>
						
						<div class="phototheque image"><a href={concat("content/download/", $enfants.contentobject_id, "/", $enfants.data_map.image.id, "/version/", $enfants.data_map.image.version, "/file/", $enfants.data_map.image.content.original_filename|urlencode)|ezurl}>> Télécharger</a></div>
						
					</li>
					{if and($node.children|count|gt($compteurlistephototheque), $style|eq('last'))}
						</ul>
						<ul class="liste phototheque">
					{/if}
					{set $compteurlistephototheque = $compteurlistephototheque|inc}
				{/foreach}
			</ul>
			
			{literal}
			<script type="text/javascript">
				$(function() {
					$('a.galeriephototheque').lightBox({
						imageLoading: {/literal}{'lightbox/lightbox-ico-loading.gif'|ezimage}{literal},
						imageBtnClose: {/literal}{'lightbox/lightbox-btn-fermer.gif'|ezimage}{literal},
						imageBtnPrev: {/literal}{'lightbox/lightbox-btn-prec.gif'|ezimage}{literal},
						imageBtnNext: {/literal}{'lightbox/lightbox-btn-suiv.gif'|ezimage}{literal},
						imageBlank: {/literal}{'lightbox/lightbox-blank.gif'|ezimage}{literal}
					});
				});
			</script>
			{/literal}
		{/if}
		
		{include name=navigator
			uri='design:navigator/google.tpl'
		    page_uri=$node.url_alias
		    item_count=$childrencount
		    view_parameters=$view_parameters
		    item_limit=$limit}
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/liste_mises_en_avant.tpl'}
</div>

<script type="text/javascript">
	equilibre = true;
	$(window).load(equilibrerHauteursBlocs);
</script>