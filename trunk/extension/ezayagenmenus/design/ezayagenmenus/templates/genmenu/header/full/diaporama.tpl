{def $hostname = ezayagenmenus_get_hostname()}
{def $configNode = ezayagenmenus_get_config_node()}

{def $bgImg = false()}
{if and(is_set($configNode.data_map.header_bg_image),$configNode.data_map.header_bg_image.has_content)}
    {set $bgImg = $configNode.data_map.header_bg_image.content.main_node}
{else}
    {set $bgImg = fetch( 'content', 'tree', hash(  'parent_node_id', ezini('NodeSettings','MediaRootNode','content.ini'),
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array('image_entete_defaut') ) )}
    {set $bgImg = cond(is_set($bgImg.0), $bgImg.0,false())}
{/if}
{def $img_attribute = $bgImg.data_map.image}

<div id="headerdiapos" style="background-image: url('{concat($hostname,$img_attribute.content.original.url|ezroot('no'))}'); height: {$img_attribute.content.original.height}px;"></div>

{undef $hostname $configNode $bgImg}
