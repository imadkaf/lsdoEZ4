<?php
 
// Include the super class file
include_once( "kernel/classes/ezdatatype.php" );
 
// Define the name of datatype string
define( "EZ_DATATYPESTRING_REFERENCEMENT", "ezreferencement" );
 
class eZReferencementType extends eZDataType
{
   /*!
    Construction of the class, note that the second parameter in eZDataType 
    is the actual name showed in the datatype dropdown list.
   */
   function eZReferencementType()
   {
       $this->eZDataType( EZ_DATATYPESTRING_REFERENCEMENT, "Aide au référencement" );
   }
 
   function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
   {
       return EZ_INPUT_VALIDATOR_STATE_ACCEPTED;
   }
 
   function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
   {
        $classAttribute =& $contentObjectAttribute->contentClassAttribute();
        $classContent = $classAttribute->content();
        $field1 = $http->postVariable( $base . "_referencement_title_" . $contentObjectAttribute->attribute( "id" ) );
        $field2 = $http->postVariable( $base . "_referencement_keyword_" . $contentObjectAttribute->attribute( "id" ) );
        $field3 = $http->postVariable( $base . "_referencement_description_" . $contentObjectAttribute->attribute( "id" ) );
		 $metas  = '#metatitle#' . $field1 . '#/metatitle#';
		$metas .= '#metakw#' . $field2 . '#/metakw#';
		$metas .= '#metadesc#' . $field3 . '#/metadesc#';
        $contentObjectAttribute->setAttribute( "data_text", $metas );
        return true;
   }
 

   function storeObjectAttribute( $contentObjectattribute )
   {
   }

   function objectAttributeContent( $contentObjectAttribute )
   {
        $data = $contentObjectAttribute->attribute( "data_text" );
		$pattern = '{#metatitle#(.*)#/metatitle##metakw#(.*)#/metakw##metadesc#(.*)#/metadesc#}';
		$tbReference = array();
		$tbMatch = array('metatitle', 'metakw', 'metadesc');
		foreach ($tbMatch as $elem) {
			$pattern = "{#$elem#(.*)#/$elem#}";
			if (preg_match ( $pattern, $data, $tbTmp)>0) {
				$tbReference[] = $tbTmp[1];
			} else {
				$tbReference[] = '';
			}
		}
        return $tbReference;
   }
 

   function metaData( $contentObjectAttribute )
   {
       return $contentObjectAttribute->attribute( "data_text" );
   }

   function title( $contentObjectAttribute, $name = null )
   {
       return $contentObjectAttribute->attribute( "data_text" );
   }
}
 
eZDataType::register( EZ_DATATYPESTRING_REFERENCEMENT, "ezreferencementtype" );
 
?>