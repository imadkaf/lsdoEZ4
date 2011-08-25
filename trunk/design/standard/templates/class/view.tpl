{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<div class="maincontentheader">
    <h1>{"Class - %1"|i18n("design/standard/class/view",,array( $class.name|wash) )}</h1>
</div>


<a href={concat( "class/edit/", $class.id )|ezurl}><img class="button" src={"edit.gif"|ezimage} width="16" height="16" alt="{'Edit'|i18n('design/standard/class/view')}" /></a>

<div class="byline">
<p class="date">{"Last modified by %username on %time"|i18n("design/standard/class/view",,
                                                            hash('%username',$class.modifier.contentobject.name|wash,
                                                                 '%time',$class.modified|l10n(shortdatetime)))}</p>
</div>

<table class="layout" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
  <td valign="top">

<div class="block">
    <label>{"Name"|i18n("design/standard/class/view")}</label><div class="labelbreak"></div>
    <p>{$class.name|wash}</p>
</div>

<div class="block">
    <label>{"Identifier"|i18n("design/standard/class/view")}</label><div class="labelbreak"></div>
    <p>{$class.identifier|wash}</p>
</div>

<div class="block">
    <label>{'Description'|i18n( 'design/standard/class/view' )}:</label>
    <p>{$class.description|wash}</p>
</div>

<div class="block">
    <label>{"Object name pattern"|i18n("design/standard/class/view")}</label><div class="labelbreak"></div>
    <p>{$class.contentobject_name|wash}</p>
</div>

<div class="block">
    <label>{"Container"|i18n("design/standard/class/view")}:</label><div class="labelbreak"></div>
    {if $class.is_container|eq(1)}
        {"Yes"|i18n("design/standard/class/view")}
    {else}
        {"No"|i18n("design/standard/class/view")}
    {/if}
</div>

<div class="block">
    <label>{"Objects always available (default value)"|i18n("design/standard/class/view")}:</label><div class="labelbreak"></div>
    {if $class.always_available|eq(0)}
        {"No"|i18n("design/standard/class/view")}
    {else}
        {"Yes"|i18n("design/standard/class/view")}
    {/if}
</div>

<div class="block">
    <label>{"Object count"|i18n("design/standard/class/view")}</label><div class="labelbreak"></div>
    <p>{$class.object_count}</p>
</div>



  </td>

  <td valign="top">

<table class="list" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
    <th colspan="1">{"Member of groups"|i18n("design/standard/class/view")}</th>
</tr>
{section name=InGroups loop=$class.ingroup_list sequence=array(bglight,bgdark)}
<tr>
    <td class="{$InGroups:sequence}" width="99%"><a href={concat( "/class/classlist/", $InGroups:item.group_id )|ezurl}>{$InGroups:item.group_name|wash}</a></td>
</tr>
{/section}
</table>

  </td>
</tr>

</table>


<h2>{"Attributes"|i18n("design/standard/class/view")}</h2>
<table class="class_list" width="100%" cellpadding="0" cellspacing="0" border="0">

{section name=Attributes loop=$attributes sequence=array("bglight","bgdark")}

<tr>
    <td colspan="4"><b>{$:number}. {$:item.name|wash} ({$:item.data_type.information.name|wash}) (id:{$:item.id}) </b></td>
</tr>

<tr>

    <td class="{$Attributes:sequence}">
        <input type="hidden" name="ContentAttribute_id[]" value="{$Attributes:item.id}" />
        <input type="hidden" name="ContentAttribute_position[]" value="{$Attributes:item.placement}" />

        <div class="block">
            <label>{"Name"|i18n("design/standard/class/view")}</label><div class="labelbreak"></div>
            <p>{$Attributes:item.name|wash}</p>
        </div>
    </td>

    <td class="{$Attributes:sequence}">
        <div class="block">
            <label>{"Identifier"|i18n("design/standard/class/view")}</label><div class="labelbreak"></div>
            <p>{$Attributes:item.identifier|wash}</p>
        </div>
    </td>

    <td class="{$Attributes.sequence}">
        <div class="block">
            <label>{'Description'|i18n( 'design/standard/class/view' )}:</label>
            <p>{$Attributes.item.description|wash}</p>
        </div>
    </td>

    <td class="{$Attributes:sequence}" rowspan="2" width="20%" valign="top">

        <div class="block">
            <p>{if $Attributes:item.is_required}{"Is required"|i18n("design/standard/class/view")}{else}{"Is not required"|i18n("design/standard/class/view")}{/if}</p>
        </div>

        {if $Attributes:item.data_type.is_indexable}
        <div class="block">
            <p>{if $Attributes:item.is_searchable}{"Is searchable"|i18n("design/standard/class/view")}{else}{"Is not searchable"|i18n("design/standard/class/view")}{/if}</p>
        </div>
        {else}
        <div class="block">
            <p>{"Is not searchable"|i18n("design/standard/class/view")}</p>
        </div>
        {/if}

        {if $Attributes:item.data_type.is_information_collector}
        <div class="block">
            <p>{if $Attributes:item.is_information_collector}{"Collects information"|i18n("design/standard/class/view")}{else}{"Does not collect information"|i18n("design/standard/class/view")}{/if}</p>
        </div> 
        {else}
        <div class="block">
            <p>{"Does not collect information"|i18n("design/standard/class/view")}</p>
        </div>
        {/if}

        <div class="block">
            <p>{if or( $Attributes.item.can_translate|eq(0), $Attributes.item.data_type.properties.translation_allowed|not )}{'Translation is disabled'|i18n( 'design/standard/class/view' )}{else}{'Translation is enabled'|i18n( 'design/standard/class/view' )}{/if}</p>
        </div>

    </td>

</tr>

<tr>
    <td class="{$Attributes:sequence}" colspan="3">
        {class_attribute_view_gui class_attribute=$Attributes:item}
    </td>
</tr>
{/section}

</table>

<h2>{"Override templates"|i18n("design/standard/class/view")}</h2>
<table class="list" cellspacing="0" cellpadding="0" width="100%">
<tr><th>{"Siteaccess"|i18n("design/standard/class/view")}</th><th>{"Override"|i18n("design/standard/class/view")}</th><th>{"Source template"|i18n("design/standard/class/view")}</th><th>{"Override template"|i18n("design/standard/class/view")}</th><th>{"Edit"|i18n("design/standard/class/view")}</th></tr>
{let test=fetch( class, override_template_list, hash( class_id, $class.id ) )}

{section loop=$test}
<tr><td>{$:item.siteaccess}</td><td>{$:item.block}</td><td><a href={concat( "/setup/templateview/", $:item.source )|ezurl}>{$:item.source}</td><td>{$:item.target}</td><td><a href={concat("/setup/templateedit/",$:item.target)|ezurl}><img src={"edit.gif"|ezimage} alt="Edit" /></a></td></tr>
{/section}

{/let}
</table>
