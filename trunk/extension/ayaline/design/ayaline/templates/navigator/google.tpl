{default page_uri_suffix=false()
         left_max=7
         right_max=6
         view_name='default'}
{default name=ViewParameter
         page_uri_suffix=false()
         left_max=$left_max
         right_max=$right_max}

{let page_count=int( ceil( div( $item_count,$item_limit ) ) )
      current_page=min($:page_count,
                       int( ceil( div( first_set( $view_parameters.offset, 0 ),
                                       $item_limit ) ) ) )
      item_previous=sub( mul( $:current_page, $item_limit ),
                         $item_limit )
      item_next=sum( mul( $:current_page, $item_limit ),
                     $item_limit )

      left_length=min($ViewParameter:current_page,$:left_max)
      right_length=max(min(sub($ViewParameter:page_count,$ViewParameter:current_page,1),$:right_max),0)
      view_parameter_text=""
      offset_text=eq( ezini( 'ControlSettings', 'AllowUserVariables', 'template.ini' ), 'true' )|choose( '/offset/', '/(offset)/' )}
{* Create view parameter text with the exception of offset *}
{section loop=$view_parameters}
 {section-exclude match=$:key|eq('offset')}
 {section-exclude match=$:item|eq('')}
 {set view_parameter_text=concat($:view_parameter_text,'/(',$:key,')/',$:item)}
{/section}
		{section show=$:page_count|gt(1)}
{switch match=$view_name}
	{case match='rubric'}
{*Pagination pour la page http://dev.lnet.fr/sdo/site/visites-excursions.html*}
							<div class="pagination no-margin">
						     {switch match=$:item_previous|lt(0) }
						       {case match=0}
								<p class="float-g"><a href={concat($page_uri,$:item_previous|gt(0)|choose('',concat($:offset_text,$:item_previous)),$:view_parameter_text,$page_uri_suffix)|ezurl}>&lt; {"Page précédente"|i18n("ayaline/pagePrecedente")}</a></p>
						       {/case}
						       {case match=1}
						       {/case}
						     {/switch}
								<ul class="pagin">
							{if $:current_page|gt($:left_max)}
									<li><a href={concat($page_uri,$:view_parameter_text,$page_uri_suffix)|ezurl}>1</a></li>
								{if sub($:current_page,$:left_length)|gt(0)}
									<li>...</li>
								{/if}
							{/if}
									<li class="actif">{$:current_page|inc}</li>
							{if $:page_count|gt(sum($:current_page,$:right_max,1))}
								{if sum($:current_page,$:right_max)|lt($:page_count)}
									<li>...</li>
								{/if}
									<li><a href={concat($page_uri,$:page_count|dec|gt(0)|choose('',concat($:offset_text,mul($:page_count|dec,$item_limit))),$:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_count}</a></li>
							{/if}
								</ul>
						    {switch match=$:item_next|lt($item_count)}
						      {case match=1}
								<p class="float-d"><a href={concat($page_uri,$:offset_text,$:item_next,$:view_parameter_text,$page_uri_suffix)|ezurl}>{"Page suivante"|i18n("ayaline/pageSuivante")} &gt;</a></p>
						      {/case}
						      {case}
						      {/case}
						    {/switch}
							</div>
	{/case}
	{case}
		
		
		
		<div class="pagenavigator">
		<p>
		
		     {switch match=$:item_previous|lt(0) }
		       {case match=0}
		      <span class="previous"><a href={concat($page_uri,$:item_previous|gt(0)|choose('',concat($:offset_text,$:item_previous)),$:view_parameter_text,$page_uri_suffix)|ezurl}><span class="text">&lt;&nbsp;{"Page pr&eacute;c&eacute;dente"|i18n("design/standard/navigator")}</span></a></span>
		       {/case}
		       {case match=1}
		       {/case}
		     {/switch}
		
		
		<span class="pages">
		{if $:current_page|gt($:left_max)}
		<a href={concat($page_uri,$:view_parameter_text,$page_uri_suffix)|ezurl}>1</a>
		{if sub($:current_page,$:left_length)|gt(1)}
		...
		{/if}
		{/if}
		
		    {section loop=$:left_length}
		        {let page_offset=sum(sub($ViewParameter:current_page,$ViewParameter:left_length),$:index)}
		          <span class="other"><a href={concat($page_uri,$:page_offset|gt(0)|choose('',concat($:offset_text,mul($:page_offset,$item_limit))),$ViewParameter:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_offset|inc}</a></span>
		        {/let}
		    {/section}
		
		        <span class="current">{$:current_page|inc}</span>
		
		    {section loop=$:right_length}
		        {let page_offset=sum($ViewParameter:current_page,1,$:index)}
		          <span class="other"><a href={concat($page_uri,$:page_offset|gt(0)|choose('',concat($:offset_text,mul($:page_offset,$item_limit))),$ViewParameter:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_offset|inc}</a></span>
		        {/let}
		    {/section}
		
		{if $:page_count|gt(sum($:current_page,$:right_max,1))}
		{if sum($:current_page,$:right_max,2)|lt($:page_count)}
		<span class="other">...</span>
		{/if}
		<span class="other"><a href={concat($page_uri,$:page_count|dec|gt(0)|choose('',concat($:offset_text,mul($:page_count|dec,$item_limit))),$:view_parameter_text,$page_uri_suffix)|ezurl}>{$:page_count}</a></span>
		{/if}
		
		</span>
		
		
		    {switch match=$:item_next|lt($item_count)}
		      {case match=1}
		        <span class="next"><a href={concat($page_uri,$:offset_text,$:item_next,$:view_parameter_text,$page_uri_suffix)|ezurl}><span class="text">{"Page suivante"|i18n("design/standard/navigator")}&nbsp;&gt;</span></a></span>
		      {/case}
		      {case}
		      {/case}
		    {/switch}
		
		</p>
		<div class="break"></div>
		</div>
		
	{/case}
{/switch}
		{/section}
 {/let}
{/default}
{/default}