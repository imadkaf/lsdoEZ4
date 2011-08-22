<div class="bloc-left-bis">
	<div class="bloc-type padding-35px-32px">
		<form method="post" action={"/user/login/"|ezurl} class="user-login">
			<div class="maincontentheader">
				<h2>Accès à l'espace presse</h2>
			</div>
			<br />
			<div class="maincontentheader">
				Pour accéder à l'espace presse, il est nécessaire de s'authentifier. Pour cela, renseigner les champs ci-dessous avec les accès qui vous ont été fournis.
				Si vous ne disposez pas d'accès vous pouvez en faire la demande au niveau du formulaire de contact. 
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
			
			{if $User:redirect_uri}
			<input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
			{else}
				{* Espace presse *}
				{def $pageEspace = fetch('content','tree', hash(
													'parent_node_id', 2,
													'class_filter_type' , 'include', 
													'limitation' , array(), 
													'class_filter_array' , array('espace_presse')))}
				<input type="hidden" name="RedirectURI" value="/{$pageEspace[0].url_alias|wash}" />
			{/if}
			
			{section show=and( is_set( $User:post_data ), is_array( $User:post_data ) )}
			  {section name=postData loop=$User:post_data }
			     <input name="Last_{$postData:key}" value="{$postData:item}" type="hidden" /><br/>
			  {/section}
			{/section}
			<br /><br />
		</form>
	</div>
</div>

<div class="bloc-right-bis">
	{include uri='design:parts/reserver.tpl'}
	{include uri='design:parts/les_plus_consultes.tpl'}
</div>
