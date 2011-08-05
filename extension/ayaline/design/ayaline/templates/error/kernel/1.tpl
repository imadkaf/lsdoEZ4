<div class="bloc-left-bis">
	<div class="bloc-type padding-35px-32px">
		<h2 class="bloc-liste-h2">{"Access denied"|i18n("design/standard/error/kernel")}</h2>
		<p class="clear" style="margin-bottom: 20px;"></p>
		
		<p>
			{"You do not have permission to access this area."|i18n("design/standard/error/kernel")}
		</p>
		<p>
			{"Possible reasons for this are"|i18n("design/standard/error/kernel")}:
		</p>

		<ul>
		    {if ne($current_user.contentobject_id,$anonymous_user_id)}
		    	<li>- {"Your current user does not have the proper privileges to access this page."|i18n("design/standard/error/kernel")}</li>
		    {else}
		    	<li>- {"You are currently not logged in to the site, to get proper access create a new user or login with an existing user."|i18n("design/standard/error/kernel")}</li>
		    {/if}
		    <li>- {"You misspelled some parts of your URL, try changing it."|i18n("design/standard/error/kernel")}</li>
		</ul>
		
		{if is_set($module_required)}
			<p>{"Permission required"|i18n("design/standard/error/kernel")}</p>
		
			<ul>
				<li>{"Module : "|i18n("design/standard/error/kernel")}{$module_required} </li>
				<li>{"Function : "|i18n("design/standard/error/kernel")}{$function_required}</li>
			</ul>
		{/if}
		<br /><br />
		
		{if eq($current_user.contentobject_id,$anonymous_user_id)}
		    {if $embed_content}
		    	{*$embed_content*}
		    	{include uri='design:parts/login_embed.tpl'}
		    {else}
		        <form method="post" action={"/user/login/"|ezurl}>
			        <p>{"Click the Login button to login."|i18n("design/standard/error/kernel")}</p>
			        
			        <div class="buttonblock">
			        	<input class="button" type="submit" name="LoginButton" value="{'Login'|i18n('design/standard/error/kernel','Button')}" />
			        </div>
			
			        <input type="hidden" name="Login" value="" />
			        <input type="hidden" name="Password" value="" />
			        <input type="hidden" name="RedirectURI" value="{$redirect_uri}" />
		        </form>
		    {/if}
		{/if}
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/les_plus_consultes.tpl'}
</div>
