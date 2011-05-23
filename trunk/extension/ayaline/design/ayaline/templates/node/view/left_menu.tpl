								<span>{$node.name}</span>
								<ul class="s-menu">
{foreach $node.children as $child}
									<li><a href={$child.url_alias|ezurl}>{$child.name}</a></li>
{/foreach}
								</ul>