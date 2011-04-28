<?php
 
// Include the super class file
include_once( "kernel/classes/ezdatatype.php" );
 
class eZURLGaType extends eZDataType
{
	const DATA_TYPE_STRING = 'ezurlga';
   /*!
    Construction of the class, note that the second parameter in eZDataType 
    is the actual name showed in the datatype dropdown list.
   */
   function eZURLGaType()
   {
       $this->eZDataType( self::DATA_TYPE_STRING, "URL GA" );
   }
/*
   function initializeObjectAttribute( $contentObjectAttribute, $currentVersion, $originalContentObjectAttribute )
    {
        if ( $currentVersion != false )
        {
            $dataText = $originalContentObjectAttribute->attribute( "data_text" );
            $url = $originalContentObjectAttribute->attribute( "content" );
            $contentObjectAttribute->setContent( $url );
            $contentObjectAttribute->setAttribute( "data_text", $dataText );
        }
        else
        {
            $contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
            $default = $contentClassAttribute->attribute( 'data_text1' );
            if ( $default !== '' && $default !== NULL )
            {
                $contentObjectAttribute->setAttribute( 'data_text', $default );
            }
        }
    }*/

   function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        /*if ( $http->hasPostVariable( $base . "_ezurl_url_" . $contentObjectAttribute->attribute( "id" ) )  and
             $http->hasPostVariable( $base . "_ezurl_text_" . $contentObjectAttribute->attribute( "id" ) )
           )
        {
            $url = $http->PostVariable( $base . "_ezurl_url_" . $contentObjectAttribute->attribute( "id" ) );
            $text = $http->PostVariable( $base . "_ezurl_text_" . $contentObjectAttribute->attribute( "id" ) );
            if ( $contentObjectAttribute->validateIsRequired() )
                if ( ( $url == "" ) or ( $text == "" ) )
                {
                    $contentObjectAttribute->setValidationError( ezpI18n::tr( 'kernel/classes/datatypes',
                                                                         'Input required.' ) );
                    return eZInputValidator::STATE_INVALID;
                }
            // Remove all url-object links to this attribute.
            eZURLObjectLink::removeURLlinkList( $contentObjectAttribute->attribute( "id" ), $contentObjectAttribute->attribute('version') );
        }
        else if ( $contentObjectAttribute->validateIsRequired() )
        {
            $contentObjectAttribute->setValidationError( ezpI18n::tr( 'kernel/classes/datatypes', 'Input required.' ) );
            return eZInputValidator::STATE_INVALID;
        }
        return eZInputValidator::STATE_ACCEPTED;*/
       return EZ_INPUT_VALIDATOR_STATE_ACCEPTED;
    }
   
   function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
   {
       if ( $http->hasPostVariable( $base . '_ezurlga_url_' . $contentObjectAttribute->attribute( 'id' ) ) and
             $http->hasPostVariable( $base . '_ezurlga_text_' . $contentObjectAttribute->attribute( 'id' ) ) and
             $http->hasPostVariable( $base . '_ezurlga_category_' . $contentObjectAttribute->attribute( 'id' ) ) and
             $http->hasPostVariable( $base . '_ezurlga_action_' . $contentObjectAttribute->attribute( 'id' ) ) and
             $http->hasPostVariable( $base . '_ezurlga_label_' . $contentObjectAttribute->attribute( 'id' ) )
             )
        {
            $url = $http->postVariable( $base . '_ezurlga_url_' . $contentObjectAttribute->attribute( 'id' ) );
            $text = $http->postVariable( $base . '_ezurlga_text_' . $contentObjectAttribute->attribute( 'id' ) );
            $category = $http->postVariable( $base . '_ezurlga_category_' . $contentObjectAttribute->attribute( 'id' ) );
            $action = $http->postVariable( $base . '_ezurlga_action_' . $contentObjectAttribute->attribute( 'id' ) );
            $label = $http->postVariable( $base . '_ezurlga_label_' . $contentObjectAttribute->attribute( 'id' ) );

            /*$contentObjectAttribute->setAttribute( 'data_text', $text );
            $contentObjectAttribute->setAttribute( 'data_category', $category );
            $contentObjectAttribute->setAttribute( 'data_action', $action );
            $contentObjectAttribute->setAttribute( 'data_label', $label );*/
            
			$metas  = '#url#' . $url . '#/url#';
			$metas .= '#text#' . $text . '#/text#';
			$metas .= '#category#' . $category . '#/category#';
			$metas .= '#action#' . $action . '#/action#';
			$metas .= '#label#' . $label . '#/label#';
	        $contentObjectAttribute->setAttribute( "data_text", $metas );
            return true;
        }
        return false;
   }

    function storeObjectAttribute( $attribute )
    {
        /*$urlValue = $attribute->content();
        if ( trim( $urlValue ) != '' )
        {
            $oldURLID = $attribute->attribute( 'data_int' );
            $urlID = eZURL::registerURL( $urlValue );
            $attribute->setAttribute( 'data_int', $urlID );

            if ( $oldURLID && $oldURLID != $urlID &&
                 !eZURLObjectLink::hasObjectLinkList( $oldURLID ) )
                    eZURL::removeByID( $oldURLID );
        }
        else
        {
            $attribute->setAttribute( 'data_int', 0 );
        }*/
    }
    
   function objectAttributeContent( $contentObjectAttribute )
   {
       /* //$url = eZURL::url( $contentObjectAttribute->attribute( 'data_int' ) );
        $url = eZURL::url( $contentObjectAttribute->attribute( 'content' ) );
        return $url;*/
		$data = $contentObjectAttribute->attribute( "data_text" );
		$pattern = '{#url#(.*)#/url##text#(.*)#/text##category#(.*)#/category##action#(.*)#/action##label#(.*)#/label#}';
		$tbReference = array();
		$tbMatch = array('url', 'text', 'category', 'action', 'label');
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

   function category( $contentObjectAttribute, $name = null )
   {
       return $contentObjectAttribute->attribute( "data_category" );
   }

   function action( $contentObjectAttribute, $name = null )
   {
       return $contentObjectAttribute->attribute( "data_action" );
   }

   function label( $contentObjectAttribute, $name = null )
   {
       return $contentObjectAttribute->attribute( "data_label" );
   }
}
 
eZDataType::register( eZURLGaType::DATA_TYPE_STRING, "eZURLGaType" );
 
?>