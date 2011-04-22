{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<div class="warning">
<h2>{"Are you sure you want to remove %1 from node %2?"|i18n("design/standard/node",,hash("%1",$object.name|wash,"%2",$node.object.name|wash))}</h2>
<ul>
    <li>{"Removing this assignment will also remove its %1 children."|i18n("design/standard/node",,hash("%1",$ChildObjectsCount))}</li>
</ul>
</div>

<p><b>{"Note:"|i18n("design/standard/node")}</b> {"Removed nodes can be retrieved later. You will find them in the trash."|i18n("design/standard/node")}</p>
<br/>


<form enctype="multipart/form-data" method="post" action={concat("/content/removenode/",$object.id,"/",$edit_version,"/",$node.node_id,"/")|ezurl}>

<h1>{"Removing node assignment of %1"|i18n("design/standard/node",,array($object.name|wash))}</h1>

<input type="hidden" name=RemoveNodeID value={$node.parent_node_id} />
<div class="buttonblock">
{include uri="design:gui/button.tpl" name=Store id_name=ConfirmButton value="Confirm"|i18n("design/standard/node")}
{include uri="design:gui/button.tpl" name=Discard id_name=CancelButton value="Cancel"|i18n("design/standard/node")}
</div>
</form>
