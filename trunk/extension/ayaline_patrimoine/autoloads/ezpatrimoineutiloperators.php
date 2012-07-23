<?php

class eZPatrimoineUtils{

	var $Operators;

	function eZPatrimoineUtils(){

		$this->Operators = array (
			'striptags','getcookie'
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
									 'default'=>"")),
				'getcookie'=>array()
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
			    
			    case 'getcookie': {
				$operatorValue = $this->getcookie();
			}
			    break;


		 }

	}

	

	function striptags($needle) {
			return strip_tags($needle);
	}
	
	function getcookie() {
		//var_dump($_COOKIE['popin']);
		if(!isset($_COOKIE['popin'])){
			return true;
		}elseif(isset($_COOKIE['popin'])){
			return false;
		}
	}

}

?>
