<h2 class="bloc-accueil-h2">
	{attribute_view_gui attribute = $node.data_map.title}
</h2>

<a class="float-d" href="{attribute_view_gui attribute = $node.data_map.adresse_flux_rss_blog}">
	<img alt="Flux RSS" src={"rss.gif"|ezimage} />
</a>
<p class="clear"></p>

<h3 class="bloc-accueil-h3">
	{attribute_view_gui attribute = $node.data_map.sub_title}
</h3>

{* Utilisation de l'extention ezfeedparse *}
{cache-block ignore_content_expiry expiry=7200}
{def $feed = ''}
{set $feed = fetch( feed, parse, hash( 'rss_url', $node.data_map.adresse_flux_rss_blog.content ) )}
{def $limit = $node.data_map.nb_flux.content}

{if ne($feed, '')}
	<ul>
		{foreach $feed.item as $item max $limit}
		    <li>
		    	{if is_set($item.enclosure.0.url)}
		        	<a href={$item.link.0.href|ezurl} target="_blank"><img width="130" src={$item.enclosure.0.url|ezurl} alt="{$item.title.text|wash}" /></a>
		        {/if}
		        <div style="margin-left:144px">
		        <h4 style="font-size:12px; text-transform:none;"><a href={$item.link.0.href|ezurl} target="_blank">{$item.title.text}</a></h4>
		        
		        <p style="line-height: 13px;">{$item.description.text|word_cut(22)}...</p>
		        </div>
		    </li>
		{/foreach}
	</ul>
{else}
	<br />{"The informations are not available"|i18n("ayaline")}.<br /><br /><br />
{/if}

{undef $feed}
{/cache-block}

<p class="lien-bas">
	<a class="type4" href="{attribute_view_gui attribute = $node.data_map.adresse_blog}">{"Learn more"|i18n("ayaline")}</a>
</p>
