<?php

class EZaYaGenMenusAutoload {
    /* !
      Constructor
     */

    function EZaYaGenMenusAutoload() {
        $this->Operators = array(
            'ezayagenmenus_get_config_node',
            'ezayagenmenus_get_hostname',
            'ezayagenmenus_str_replace',
        );
    }

    /* !
      Returns the operators in this class.
     */

    function &operatorList() {
        return $this->Operators;
    }

    /* !
      \return true to tell the template engine that the parameter list
      exists per operator type, this is needed for operator classes
      that have multiple operators.
     */

    function namedParameterPerOperator() {
        return true;
    }

    /* !
      Both operators have one parameter.
      See eZTemplateOperator::namedParameterList()
     */

    function namedParameterList() {

        return array(
            'ezayagenmenus_get_config_node' => array(),
            'ezayagenmenus_get_hostname' => array(),
            'ezayagenmenus_str_replace' => array(
                'search' => array(
                    'type' => 'string',
                    'required' => true,
                    'default' => null
                ),
                'replace' => array(
                    'type' => 'string',
                    'required' => true,
                    'default' => null
                ),
                'subject' => array(
                    'type' => 'string',
                    'required' => true,
                    'default' => null
                )
            )
        );
    }

    /* !
      \Executes the needed operator(s).
      \Checks operator names, and calls the appropriate functions.
     */

    function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters) {
        switch ($operatorName) {

            case 'ezayagenmenus_get_config_node': {
                    $content = $operatorValue;
                    $operatorValue = $this->ezayagenmenus_get_config_node();
                }
                break;
            case 'ezayagenmenus_get_hostname': {
                    $content = $operatorValue;
                    $operatorValue = $this->ezayagenmenus_get_hostname();
                }
                break;
            case 'ezayagenmenus_str_replace': {
                    $content = $operatorValue;
                    $_search = $namedParameters['search'];
                    $_replace = $namedParameters['replace'];
                    $_subject = $namedParameters['subject'];
                    $operatorValue = $this->ezayagenmenus_str_replace($_search, $_replace, $_subject);
                }
                break;
        }
    }

    function ezayagenmenus_get_config_node() {
        return eZaYaGenMenusUtils::getConfigNode();
    }

    function ezayagenmenus_get_hostname() {
        $ezayagenmenusIni = eZINI::instance('ezayagenmenus.ini');
        $hostname = $ezayagenmenusIni->variable('GlobalSettings', 'hostname');

        if (!$hostname) {
            $hostname = eZSys::hostname();
        }
        $hostname = 'http://' . $hostname;
        return $hostname;
    }
    function ezayagenmenus_str_replace($search, $replace, $subject) {
        return str_replace($search, $replace, $subject);
    }

}

?>