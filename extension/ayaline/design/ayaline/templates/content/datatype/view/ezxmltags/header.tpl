{set $classification = cond( and(is_set( $align ), $align ), concat( $classification, ' text-', $align ), $classification )}

{if is_set($anchor_name)}<a name="{$anchor_name|wash}" />{/if}

<a name="eztoc{$toc_anchor_name}" id="eztoc{$toc_anchor_name}"></a>

{switch name=sw match=$level}
	{case match=1}
		<h2 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h2>
	{/case}
	{case match=2}
		<h3 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h3>
	{/case}
	{case match=3}
		<h4 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h4>
	{/case}
	{case match=4}
		<h5 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h5>
	{/case}
	{case match=5}
		<h6 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h6>
	{/case}
	{case match=6} {* html does not have h7 *}
		<h6 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h6>
	{/case}
	{case}
		<h2 class="titre-normal{if $classification|trim} {$classification|wash}{/if}">{$content}</h2>
	{/case}
{/switch}
