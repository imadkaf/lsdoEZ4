{def $hostnamePrefix = ezayagenmenus_get_hostname()}
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<style type="text/css">
    @import url('{concat($hostnamePrefix,'stylesheets/main.css'|ezdesign('no'))}');
    {*
        @import url('{$hostnamePrefix|concat('stylesheets/ezfind.css'|ezdesign('no'))}');
        @import url('{$hostnamePrefix|concat('stylesheets/ezajax_autocomplete.css'|ezdesign('no'))}');
    *}
</style>
<!--[if IE 6]>
        <link rel="stylesheet" type="text/css" href="{concat($hostnamePrefix,'stylesheets/main_ie6.css'|ezdesign('no'))}" media="all" />
<![endif]-->
<!--[if IE 8]>
        <link rel="stylesheet" type="text/css" href="{concat($hostnamePrefix,'stylesheets/genmenu_ie8.css'|ezdesign('no'))}" media="all" />
<![endif]-->
<script type="text/javascript">
    {literal}
        if (navigator.userAgent.indexOf('iPad') != -1) {
            document.write('<link rel="stylesheet" href="{/literal}{concat($hostnamePrefix,'stylesheets/stylesheet_ipad.css'|ezdesign('no'))}{literal}" type="text/css" />');
        }   
    {/literal}
</script>
{undef $hostnamePrefix}