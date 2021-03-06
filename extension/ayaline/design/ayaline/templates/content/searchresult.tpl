{def $use_url_translation=ezini('URLTranslator','Translation')|eq('enabled')}

{if $search_result}
	<table class="list" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><th>{"Score"|i18n("design/standard/content/search")}</th><th></th>
	    <th>{"Name"|i18n("design/standard/content/search")}</th>
	    <th width="1">{"Class"|i18n("design/standard/content/search")}</th>
	</tr>
	<tr>
	    {foreach $search_result as $result
	             sequence array('bglight','bgdark') as $bgColor}
	        {node_view_gui view=search sequence=$bgColor use_url_translation=$use_url_translation content_node=$result}
	        {delimiter}
	         </tr>
	         <tr>
	        {/delimiter}
	    {/foreach}
	</tr>
	</table>
{/if}
