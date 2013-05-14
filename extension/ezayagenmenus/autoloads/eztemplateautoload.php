<?php

// Operator autoloading

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] =
        array('script' => 'extension/ezayagenmenus/autoloads/ezayagenmenusautoload.php',
            'class' => 'EZaYaGenMenusAutoload',
            'operator_names' => array(
                'ezayagenmenus_get_config_node',
                'ezayagenmenus_get_hostname',
                'ezayagenmenus_str_replace'
            )
);
?>