<?php
/*!
  \class   TemplateWord_cutOperator templateword_cutoperator.php
  \ingroup eZTemplateOperators
  \brief   Prend en charge l'opérateur de templates word_cut. En utilisant word_cut, vous pouvez limiter une chaîne en nombre de mot
  \version 1.0
  \date    Lundi 16 Avril 2007 2:20:27 pm
  \author  Administrator User

  

  Exemple:
\code
{$string|word_cut(15)|wash}
\endcode
*/

class TemplateWord_cutOperator
{
    /*!
      Constructeur, par défaut ne fait rien.
    */
    function TemplateWord_cutOperator()
    {
    }
   
   /*
     This function cuts a string at word boundary
   */
   function wordCut( $str, $cnt ) {
		return implode(' ', array_slice( preg_split( ',\s+,', $str, -1, PREG_SPLIT_NO_EMPTY ), 0, $cnt));
	}

  /*!
    This function cuts a string at word boundary
  */
    function charCut( $str, $cnt ) {
		$tryRet = $ret = '';
		$a = preg_split( ',\s+,', $str, -1, PREG_SPLIT_NO_EMPTY );
		foreach( $a as $w ) {
			$tryRet .= $w.' ';
			if ( mb_strlen( $tryRet ) > $cnt )
				return rtrim( $ret );
			$ret = $tryRet; }
		return $ret;
	}
     /*!
     return an array with the template operator name.
    */
    function operatorList()
    {
        return array( 'word_cut','char_cut' );
    }
    /*!
     	return true to tell the template engine that the parameter list exists per operator type,
        this is needed for operator classes that have multiple operators.
    */
    function namedParameterPerOperator()
    {
        return true;
    }    
    
   /*!
     See eZTemplateOperator::namedParameterList
    */
    function namedParameterList()
    {
        return array( 'word_cut' => array( 'first_param' => array( 'type' => 'int',
                                                                   'required' => false,
                                                                   'default' => 10 )),
				'char_cut' => array( 'first_param' => array( 'type' => 'int',
                                                                   'required' => false,
                                                                   'default' => 20 )));
    }
    /*!
     Exécute la fonction PHP correspondant à l'opérateur "cleanup" et modifie \a $operatorValue.
    */
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $firstParam = $namedParameters['first_param'];
        
        switch ( $operatorName )
        {
            case 'word_cut':
            {
		$operatorValue = $this->wordCut( $operatorValue,  $firstParam);
            } break;
	    case 'char_cut':
            {
		$operatorValue = $this->charCut( $operatorValue,  $firstParam);
            } break;
	
        }
    }
}

?>
