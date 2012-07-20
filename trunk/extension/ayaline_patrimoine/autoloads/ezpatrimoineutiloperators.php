<?php

class eZPatrimoineUtils{

	var $Operators;

	function eZPatrimoineUtils(){

		$this->Operators = array (
			'striptags'
		);

	}

	function &operatorList(){

		return $this->Operators;

	}

	function namedParameterPerOperator(){

		return true;

	}

	function namedParameterList(){

		return array(			    
			    'striptags'=>array('needle'=>array('type'=>'string',
									 'required'=>true,
									 'default'=>""))
			);

	}

	function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace,
			    &$currentNamespace, &$operatorValue, &$namedParameters){

		   switch($operatorName){

			    case 'striptags': {

				$operatorValue = $this->striptags(
					$namedParameters['needle']);

			}

			    break;


		 }

	}

	

	function striptags($needle) {
			return strip_tags($needle);
	}

}

?>
