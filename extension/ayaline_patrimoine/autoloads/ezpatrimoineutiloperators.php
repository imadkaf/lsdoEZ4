<?php

class eZPatrimoineUtils {

    var $Operators;

    function eZPatrimoineUtils() {

        $this->Operators = array(
            'striptags', 'getcookie', 'getlist_instantsgagnants', 'supp_br','is_mobile'
        );
    }

    function &operatorList() {

        return $this->Operators;
    }

    function namedParameterPerOperator() {

        return true;
    }

    function namedParameterList() {

        return array(
            'striptags' => array('needle' => array('type' => 'string',
                    'required' => true,
                    'default' => "")),
            'getcookie' => array(),
            'getlist_instantsgagnants' => array(),
            'supp_br' => array('needle' => array('type' => 'string',
                    'required' => true,
                    'default' => "")),
            'is_mobile' => array()
        );
    }

    function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters) {

        switch ($operatorName) {

            case 'striptags': {

                    $operatorValue = $this->striptags(
                            $namedParameters['needle']);
                }

                break;

            case 'getcookie': {
                    $operatorValue = $this->getcookie();
                }
                break;
            case 'getlist_instantsgagnants': {
                    $operatorValue = $this->getlist_instantsgagnants();
                }
                break;
            case 'supp_br': {

                    $operatorValue = $this->supp_br($namedParameters['needle']);
                }
                break;
            case 'is_mobile': {
                    $operatorValue = $this->is_mobile();
                }
                break;
        }
    }

    function striptags($needle) {
        return strip_tags($needle);
    }

    function getcookie() {
        //var_dump($_COOKIE['popin']);
        if (!isset($_COOKIE['popin'])) {
            return true;
        } elseif (isset($_COOKIE['popin'])) {
            return false;
        }
    }

    function getlist_instantsgagnants() {
        return QuizzInstantGagnantManagement::getListInstantsGagnants();
    }

    function supp_br($needle) {
        $result = preg_replace('/<br.*>/iU', ' ', $needle);
        while (preg_match('/  /', $result))
            $result = preg_replace('/  /', ' ', $result);
        return $result;
    }

    function is_mobile() {
        //User agent
        $ua = $_SERVER['HTTP_USER_AGENT'];
        //test si il s'agit d'un mobile
        return preg_match('/iphone/i', $ua) || preg_match('/android/i', $ua) || preg_match('/blackberry/i', $ua);
    }

}

?>
