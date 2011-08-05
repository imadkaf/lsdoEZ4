<form method="post" action={"/user/login/"|ezurl} class="user-login">
	<div class="maincontentheader">
		<h2>{"Login"|i18n("design/standard/user")}</h2>
	</div>
	<br />
	
	{if $User:warning.bad_login}
		<div class="warning">
			<b>{"Could not login"|i18n("design/standard/user")}</b>
			<ul>
			    <li>{"A valid username and password is required to login."|i18n("design/standard/user")}</li>
			</ul>
		</div>
		<br />
	{else}
		{if $site_access.allowed|not}
		<div class="warning">
			<b>{"Access not allowed"|i18n("design/standard/user")}</b>
			<ul>
			    <li>{"You are not allowed to access %1."|i18n("design/standard/user",,array($site_access.name))}</li>
			</ul>
		</div>
		<br />
		{/if}
	{/if}
	
	<div class="block">
		<label for="id1">{"Username"|i18n("design/standard/user",'User name')} :</label>
		<input class="halfbox" type="text" size="20" name="Login" id="id1" value="{$User:login|wash}" tabindex="1" />
	</div>
	<br />
	
	<div class="block">
		<label for="id2">{"Password"|i18n("design/standard/user")} :</label>
		<input class="halfbox" type="password" size="20" name="Password" id="id2" value="" tabindex="1" />
	</div>
	
	{if and( ezini_hasvariable( 'Session', 'RememberMeTimeout' ), ezini( 'Session', 'RememberMeTimeout' ) )}
	    <div class="block">
	        <input type="checkbox" tabindex="1" name="Cookie" id="id3" /><label for="id3" style="display:inline;">{"Remember me"|i18n("design/admin/user/login")}</label>
	    </div>
	{/if}
	<br />
	
	<div class="buttonblock">
		<input class="defaultbutton" type="submit" name="LoginButton" value="{'Login'|i18n('design/standard/user','Button')}" tabindex="1" />
		{*<input class="button" type="submit" name="RegisterButton" value="{'Sign Up'|i18n('design/standard/user','Button')}" tabindex="1" />*}
	</div>
	
	{if ezini( 'SiteSettings', 'LoginPage' )|eq( 'custom' )}
	    <p><a href={'/user/forgotpassword'|ezurl}>{'Forgot your password?'|i18n( 'design/standard/user' )}</a></p>
	{/if}
	
	<input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
	
	{section show=and( is_set( $User:post_data ), is_array( $User:post_data ) )}
	  {section name=postData loop=$User:post_data }
	     <input name="Last_{$postData:key}" value="{$postData:item}" type="hidden" /><br/>
	  {/section}
	{/section}
	<br /><br />
</form>
