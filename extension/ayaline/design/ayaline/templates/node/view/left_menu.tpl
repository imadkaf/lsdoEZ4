								<span>{if is_set($name)}{$name|wash}{else}{$node.name|wash}{/if}</span>
								<ul class="s-menu">
{foreach $node.children as $child}
									<li><a href={$child.url_alias|ezurl}>{$child.name|wash}</a></li>
{/foreach}
								</ul>