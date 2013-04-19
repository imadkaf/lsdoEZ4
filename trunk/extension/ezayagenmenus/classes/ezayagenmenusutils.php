<?php

/**
 * Description of eZaYaGenMenusUtils
 *
 * @author mzammouri
 */
class eZaYaGenMenusUtils {

    CONST ROOT_NODE_ID = '2';
    CONST CLASS_CONFIG_IDENTIFIER = 'ezayagenmenus_config';
    CONST INI_FILE_NAME = 'ezayagenmenus';

    public static function getConfigNode() {
        try {
            $contentIni = eZINI::instance('content.ini');
            $_rootNodeIdIni = $contentIni->variable('NodeSettings', 'RootNode');
            $_rootNodeId = is_numeric($_rootNodeIdIni) ? $_rootNodeIdIni : self::ROOT_NODE_ID;
            $_configNode = eZFunctionHandler::execute('content', 'tree', array(
                        'parent_node_id' => $_rootNodeId,
                        'class_filter_type' => 'include',
                        'class_filter_array' => array(self::CLASS_CONFIG_IDENTIFIER),
                        'limit' => 1,
                            )
            );
            if (is_array($_configNode) && isset($_configNode[0])) {
                return $_configNode[0];
            }
        } catch (Exception $exc) {
            //log
            return null;
        }
        return null;
    }

}