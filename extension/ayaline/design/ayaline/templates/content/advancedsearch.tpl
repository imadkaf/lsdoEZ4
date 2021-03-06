{set-block scope=root variable=cache_ttl}0{/set-block}
{def $search=false()}
{if $use_template_search}
    {set $page_limit=10}
    {switch match=$search_page_limit}
	    {case match=1}
	        {set $page_limit=5}
	    {/case}
	    {case match=2}
	        {set $page_limit=10}
	    {/case}
	    {case match=3}
	        {set $page_limit=20}
	    {/case}
	    {case match=4}
	        {set $page_limit=30}
	    {/case}
	    {case match=5}
	        {set $page_limit=50}
	    {/case}
	    {case/}
    {/switch}
    {set $search=fetch(content,search,
                       hash(text,$search_text,
                            section_id,$search_section_id,
                            subtree_array, ezini('Subtree_search','TabSearch','ayaline.ini'),
                            class_id,$search_contentclass_id,
                            class_attribute_id,$search_contentclass_attribute_id,
                            offset,$view_parameters.offset,
                            publish_date,$search_date,
                            limit,$page_limit))}
    {set $search_result=$search['SearchResult']}
    {set $search_count=$search['SearchCount']}
    {def $search_extras=$search['SearchExtras']}
    {set $stop_word_array=$search['StopWordArray']}
    {set $search_data=$search}
{/if}

<div class="content-view-full">

	<form action={"/content/advancedsearch/"|ezurl} method="get">
		<div class="maincontentheader">
			<h2 class="bloc-liste-h2">{"Advanced search"|i18n("design/standard/content/search")}</h2><br /><br />
		</div>
		
		<div class="block">
			<label>{"Search all the words"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
			<input class="box" type="text" size="40" name="SearchText" value="{$full_search_text|wash}" />
		</div>
		<div class="block">
			<label>{"Search the exact phrase"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
			<input class="box" type="text" size="40" name="PhraseSearchText" value="{$phrase_search_text|wash}" />
		</div>
		{*
		<div class="block">
			<label>{"Search with at least one of the words"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
			<input class="box" type="text" size="40" name="AnyWordSearchText" value="" />
		</div>
		*}
		<div class="block">
			<div class="element">
				<label>{"Class"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
				<select name="SearchContentClassID">
					<option value="-1">{"Any class"|i18n("design/standard/content/search")}</option>
					{foreach $content_class_array as $contentClass}
					    <option {cond( $search_contentclass_id|eq( $contentClass.id ), 'selected="selected"', '' )} value="{$contentClass.id}">{$contentClass.name|wash}</option>
					{/foreach}
				</select>
			</div>
			
			<div class="element">
				<label>{"Class attribute"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
				{if $search_contentclass_id|gt(0)}
					<select name="SearchContentClassAttributeID">
						<option value="-1">{"Any attribute"|i18n("design/standard/content/search")}</option>
						{foreach $search_content_class_attribute_array as $classAttribute}
						<option value="{$classAttribute.id}"
						    {cond( eq($search_contentclass_attribute_id,$classAttribute.id), 'selected="selected"', '' )}
						        >{$classAttribute.name|wash}</option>
						{/foreach}
					</select>
					&nbsp;
				{/if}
				<input class="smallbutton" type="submit" name="SelectClass" value="{'Update attributes'|i18n('design/standard/content/search')}"/>
			</div>
			
			<div class="break"></div>
		</div>
		
		<div class="block">
			<div class="element">
				<label>{"In"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
				<select name="SearchSectionID">
					<option value="-1">{"Any section"|i18n("design/standard/content/search")}</option>
					{foreach $section_array as $section}
					<option {cond( eq( $search_section_id, $section.id ), 'selected="selected"', '' )} value="{$section.id}">{$section.name|wash}</option>
					{/foreach}
				</select>
			</div>
			
			<div class="element">
				<label>{"Published"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
				<select name="SearchDate">
					<option value="-1" {if eq($search_date,-1)}selected="selected"{/if}>{"Any time"|i18n("design/standard/content/search")}</option>
					<option value="1" {if eq($search_date,1)}selected="selected"{/if}>{"Last day"|i18n("design/standard/content/search")}</option>
					<option value="2" {if eq($search_date,2)}selected="selected"{/if}>{"Last week"|i18n("design/standard/content/search")}</option>
					<option value="3" {if eq($search_date,3)}selected="selected"{/if}>{"Last month"|i18n("design/standard/content/search")}</option>
					<option value="4" {if eq($search_date,4)}selected="selected"{/if}>{"Last three months"|i18n("design/standard/content/search")}</option>
					<option value="5" {if eq($search_date,5)}selected="selected"{/if}>{"Last year"|i18n("design/standard/content/search")}</option>
				</select>
			</div>
			
			{if $use_template_search}
				<div class="element">
					<label>{"Display per page"|i18n("design/standard/content/search")}</label><div class="labelbreak"></div>
					<select name="SearchPageLimit">
						<option value="1" {if eq($search_page_limit,1)}selected="selected"{/if}>{"5 items"|i18n("design/standard/content/search")}</option>
						<option value="2" {if or(array(1,2,3,4,5)|contains($search_page_limit)|not,eq($search_page_limit,2))}selected="selected"{/if}>{"10 items"|i18n("design/standard/content/search")}</option>
						<option value="3" {if eq($search_page_limit,3)}selected="selected"{/if}>{"20 items"|i18n("design/standard/content/search")}</option>
						<option value="4" {if eq($search_page_limit,4)}selected="selected"{/if}>{"30 items"|i18n("design/standard/content/search")}</option>
						<option value="5" {if eq($search_page_limit,5)}selected="selected"{/if}>{"50 items"|i18n("design/standard/content/search")}</option>
					</select>
				</div>
			{/if}
			
			{foreach $search_sub_tree as $subtree}
				<input type="hidden" name="SubTreeArray[]" value="{$subtree|wash}" />
			{/foreach}
			
			<div class="break"></div>
		</div>
		
		<div class="buttonblock">
			<input class="button" type="submit" name="SearchButton" value="{'Search'|i18n('design/standard/content/search')}" />
		</div>
		<br/>
		
		{switch name=Sw match=$search_count}
			{case match=0}
				<div class="warning">
					<h2>{'No results were found when searching for "%1"'|i18n("design/standard/content/search",,array($search_text|wash))}</h2>
					{if $search_extras.hasError}
						{$search_extras.error|wash}
					{/if}
				</div>
		  	{/case}
		  	{case}
				<div class="feedback">
					<h2>{'Search for "%1" returned %2 matches'|i18n("design/standard/content/search",,array($search_text|wash,$search_count))}</h2>
					<p>{'Core search time: %1 msecs'|i18n( 'ezfind',,array($search_extras.responseHeader.QTime|wash))}</p>
				</div>
		  	{/case}
		{/switch}
		<br />
		
		{include name=Result
		         uri='design:content/searchresult.tpl'
		         search_result=$search_result}
		<br />
		
		{include name=navigator
		         uri='design:navigator/google.tpl'
		         page_uri='/content/advancedsearch'
		         page_uri_suffix=concat('?SearchText=',$search_text|urlencode,'&PhraseSearchText=',$phrase_search_text|urlencode,'&SearchContentClassID=',$search_contentclass_id,'&SearchContentClassAttributeID=',$search_contentclass_attribute_id,'&SearchSectionID=',$search_section_id,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)),$search_sub_tree|gt(0)|choose( '', concat( '&', 'SubTreeArray[]'|urlencode, '=', $search_sub_tree|implode( concat( '&', 'SubTreeArray[]'|urlencode, '=' ) ) ) ),'&SearchDate=',$search_date,'&SearchPageLimit=',$search_page_limit)
		         item_count=$search_count
		         view_parameters=$view_parameters
		         item_limit=$page_limit}
	</form>

	{*<p class="small"><i>{$search_extras.engine}</i></p>*}

</div>
