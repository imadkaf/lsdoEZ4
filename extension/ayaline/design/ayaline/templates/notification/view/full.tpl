{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<style type="text/css">
			body {ldelim}
				background-color:#fff; 
				color:#000
			{rdelim}
			#global {ldelim}
				font-family:font-family: Arial,Verdana,Helvetica,sans-serif; 
				font-size:12px;
			{rdelim}
		</style>
	</head>
	<body>
		<div id="global">
			<p>
				Bonjour,<br/>
				<br/>
				{if is_set($message)}{$message}{else}Ceci est un test.<br/>Merci de ne pas tenir compte de ce message.{/if}
				<br/>
				<br/>
				Cordialement,
				<br/>
				<br/>
				{ezini( 'MailSettings', 'AdminName' )}.
			</p>
		</div>
	</body>
</html>