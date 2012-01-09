{def $search=false()}
{if $use_template_search}
    {set $page_limit=10}
    {set $search=fetch(content,search,
                       hash(text,$search_text,
                            section_id,$search_section_id,
                            subtree_array, ezini('Subtree_search','TabSearch','ayaline.ini'),
                            limitation, array(),
		                    ignore_visibility, false,
                            sort_by,array('modified',false()),
                            offset,$view_parameters.offset,
                            limit,$page_limit))}
    {set $search_result=$search['SearchResult']}
    {set $search_count=$search['SearchCount']}
    {def $search_extras=$search['SearchExtras']}
    {set $stop_word_array=$search['StopWordArray']}
    {set $search_data=$search}
{/if}

{def $searchSpellCheck = fetch( ezfind, search, 
								hash( query, $search_text|wash, 
								spell_check, array( true(), 'default' )
								) )}

<div class="bloc-left-bis">
	<div class="bloc-type padding-35px-32px">
	
		<form action={"/content/search/"|ezurl} method="get">
			<h2 class="bloc-liste-h2">{"Search"|i18n("design/base")}</h2>
			<p class="clear"></p><br />
			
			<div id="ezautocomplete">
			    <input class="halfbox" type="text" size="20" name="SearchText" id="recherche" value="{$search_text|wash}" />
			    <input class="button" name="SearchButton" type="submit" value="{'Search'|i18n('design/base')}" />
			    <div id="ezautocompletecontainer"></div>
		    </div>
		    <br /><br />
		    
		    {if $searchSpellCheck.SearchExtras.spellcheck_collation|ne('')}
				<p class="bloc-similaire">{"Similar search"|i18n("ayaline")} : <a href={concat('/content/search?SearchText=',$searchSpellCheck.SearchExtras.spellcheck_collation)|ezurl}>{$searchSpellCheck.SearchExtras.spellcheck_collation}</a></p>
			{/if}
			
			{if $stop_word_array}
			    <p>
				    {"The following words were excluded from the search"|i18n("design/base")}:
				    {foreach $stop_word_array as $stopWord}
				        {$stopWord.word|wash}
				        {delimiter}, {/delimiter}
				    {/foreach}
			    </p>
			{/if}
		
			{switch name=Sw match=$search_count}
				{case match=0}
					<div class="warning">
						<h3>{'No results were found when searching for "%1"'|i18n("design/base",,array($search_text|wash))}</h3>
					  	{if $search_extras.hasError}
					    	{$search_extras.error|wash}
					  	{/if}
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
						<h3>{'Search for "%1" returned %2 matches'|i18n("design/base",,array($search_text|wash,$search_count))} :</h3>
					</div>
			  	{/case}
			{/switch}
		
			{*<table style="width: 100%;margin-bottom:2ex;margin-top:2ex;">*}
			<ul class="list-result-search">
				{if $search_result }
				    {foreach $search_result as $result
				             sequence array('bglight','bgdark') as $bgColor}
				        {*<tr class="{$bgColor}">*}
				        <li>
				        	{node_view_gui view=search sequence=$bgColor content_node=$result}
				        </li>
				        {*</tr>*}
				    {/foreach}
				{/if}
			</ul>
			{*</table>*}
		
			{include name=Navigator
			         uri='design:navigator/google.tpl'
			         page_uri='/content/search'
			         page_uri_suffix=concat('?SearchText=',$search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)))
			         item_count=$search_count
			         view_parameters=$view_parameters
			         item_limit=$page_limit}
		</form>

		
		<script type="text/javascript">
			jQuery('#ezautocompletecontainer').css('width', jQuery('input#recherche').width());
			var ezAutoHeader = eZAJAXAutoComplete();
			ezAutoHeader.init({ldelim}
			    url: "{'ezjscore/call/ezfind::autocomplete'|ezurl('no')}",
			    inputid: 'recherche',
			    containerid: 'ezautocompletecontainer',
			    minquerylength: {ezini( 'AutoCompleteSettings', 'MinQueryLength', 'ezfind.ini' )},
			    resultlimit: {ezini( 'AutoCompleteSettings', 'Limit', 'ezfind.ini' )}
			{rdelim});
		</script>
		
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
</div>
