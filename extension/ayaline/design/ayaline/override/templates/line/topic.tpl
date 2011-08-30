{* affichage des thèmes dans le menu Découvrir du haut *}
												<li{if $topicIds|contains($node.node_id)} class="actif"{/if}>
													<form method="post" action={"/themes/edit/"|ezurl}>
														<input type="hidden" value={if is_set($redirectURI)}{$redirectURI}{else}{$node.url_alias|ezurl}{/if} name="RedirectURI" />
														<input type="hidden" value="{$node.node_id}" name="topic_id" />
														<input type="submit" name="{$node.name}" value="{$node.name}" />
													</form>
												</li>