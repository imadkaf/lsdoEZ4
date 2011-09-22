{def $search=false()}

{def $page_limit=9}

{set $search=fetch('ezfind', 'search',
					hash('query', $search_text,
						'class_id', array('gallery_photo'),
						'sort_by', hash( 'score', 'desc', 'name', 'asc'),
						offset,$view_parameters.offset,
						limit,$page_limit) ) } 

{def $search_result=$search['SearchResult']}
{def $search_count=$search['SearchCount']}
{def $search_data=$search}

<div class="content-view-full">
	<div class="content-search">
	
		<form action={$node.url_alias|ezurl} method="get">
			<h2 class="bloc-liste-h2">{"Search"|i18n("design/base")}</h2><br /><br />
		
		    <input class="halfbox" type="text" size="20" name="SearchText" id="Search" value="{$search_text|wash}" />
		    <input class="button" name="SearchButton" type="submit" value="{'Search'|i18n('design/base')}" />
		    <br /><br />
		
			{switch name=Sw match=$search_count}
				{case match=0}
					<div class="warning">
						<h2>{'No results were found when searching for "%1"'|i18n("design/base",,array($search_text|wash))}</h2>
					</div>
					<p>{'Search tips'|i18n('design/base')}</p>
						<ul>
					    	<li>{'Check spelling of keywords.'|i18n('design/base')}</li>
					        <li>{'Try changing some keywords eg. car instead of cars.'|i18n('design/base')}</li>
					        <li>{'Try more general keywords.'|i18n('design/base')}</li>
					        <li>{'Fewer keywords gives more results, try reducing keywords until you get a result.'|i18n('design/base')}</li>
					    </ul>
			  	{/case}
			  	{case}
			  		<div class="feedback">
						<h2>{'Search for "%1" returned %2 matches'|i18n("design/base",,array($search_text|wash,$search_count))}</h2>
					</div>
			  	{/case}
			{/switch}
		
			{* Ancien affichage des resultats
			<table style="width: 100%;margin-bottom:2ex;margin-top:2ex;">
				{if $search_result }
				    {foreach $search_result as $result
				             sequence array('bglight','bgdark') as $bgColor}
				        <tr class="{$bgColor}">
				        	{node_view_gui view=search sequence=$bgColor content_node=$result}
				        </tr>
				    {/foreach}
				{/if}
			</table>
			*}
			
			<div class="bloc-container recherche">
				{if $search_result }
					{def $compteurRech = 1}
					<ul>
						{foreach $search_result as $result}
							<li>
								<div class="cadre-t">
									<div class="cadre-b">
										<div class="cadre-l">
											<div class="cadre-r">
												<div class="cadre-tl">
													<div class="cadre-tr">
														<div class="cadre-bl">
															<div class="cadre-br">
																<a href={$result.parent.url_alias|ezurl}>{attribute_view_gui attribute=$result.data_map.image}</a>
															</div>
														</div>
													</div>
												</div>									
											</div>
										</div>
									</div>
								</div>
								
								<p><a href={$result.parent.url_alias|ezurl}>{$result.name|wash}</a></p>
		
							</li>
							{if eq($compteurRech|mod(3), 0)}
								<p class="clear"></p>
							{/if}
							
							{set $compteurRech = $compteurRech|inc}
						{/foreach}
					</ul>
					<p class="clear"></p>
				{/if}	        
			</div>
			
			
			
		
			{include name=Navigator
			         uri='design:navigator/google.tpl'
			         page_uri=$node.url_alias
			         page_uri_suffix=concat('?SearchText=',$search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)))
			         item_count=$search_count
			         view_parameters=$view_parameters
			         item_limit=$page_limit}
		</form>
		
	</div>
</div>