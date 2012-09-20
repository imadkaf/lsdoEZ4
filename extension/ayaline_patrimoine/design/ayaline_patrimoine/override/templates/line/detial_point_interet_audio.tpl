<a href={$node.url_alias|ezurl()} rel="external" >
    <span class="cliquer play-audio"></span>
    {attribute_view_gui attribute=$node.data_map.visuel image_class='imageLargeLibre'}
</a>
<div class="titre-video">{$node.name|wash('xhtml')}</div>
