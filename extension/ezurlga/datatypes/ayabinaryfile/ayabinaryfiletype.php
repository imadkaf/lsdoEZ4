<?php
 
// Include the super class file
include_once( "kernel/classes/ezdatatype.php" );
 
class ayaBinaryFileType extends eZBinaryFileType
{
    const MAX_FILESIZE_VARIABLE = '_ayabinaryfile_max_filesize_';

	const DATA_TYPE_STRING = 'ayabinaryfile';

   /*!
    Construction of the class, note that the second parameter in eZDataType 
    is the actual name showed in the datatype dropdown list.
   */
   function ayaBinaryFileType()
   {
        $this->eZDataType( self::DATA_TYPE_STRING, ezpI18n::tr( 'kernel/classes/datatypes', "file GA", 'Datatype name' ),
                           array( 'serialize_supported' => true ) );
   }
   
	/*!
     Fetches the http post var integer input and stores it in the data instance.
    */
    function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
    {
        eZBinaryFileType::checkFileUploads();
		
		$file = false;
         if ( eZHTTPFile::canFetch( $base . "_data_binaryfilename_" . $contentObjectAttribute->attribute( "id" ) )){ 

			$binaryFile = eZHTTPFile::fetch( $base . "_data_binaryfilename_" . $contentObjectAttribute->attribute( "id" ) );

			$contentObjectAttribute->setContent( $binaryFile );

			if ( $binaryFile instanceof eZHTTPFile )
			{
				$contentObjectAttributeID = $contentObjectAttribute->attribute( "id" );
				$version = $contentObjectAttribute->attribute( "version" );

				/*
				$mimeObj = new  eZMimeType();
				$mimeData = $mimeObj->findByURL( $binaryFile->attribute( "original_filename" ), true );
				$mime = $mimeData['name'];
				*/

				$mimeData = eZMimeType::findByFileContents( $binaryFile->attribute( "original_filename" ) );
				$mime = $mimeData['name'];

				if ( $mime == '' )
				{
					$mime = $binaryFile->attribute( "mime_type" );
				}
				$extension = eZFile::suffix( $binaryFile->attribute( "original_filename" ) );
				$binaryFile->setMimeType( $mime );
				if ( !$binaryFile->store( "original", $extension ) )
				{
					eZDebug::writeError( "Failed to store http-file: " . $binaryFile->attribute( "original_filename" ),
										 "eZBinaryFileType" );
					return false;
				}

				$binary = eZBinaryFile::fetch( $contentObjectAttributeID, $version );
				if ( $binary === null )
					$binary = eZBinaryFile::create( $contentObjectAttributeID, $version );

				$orig_dir = $binaryFile->storageDir( "original" );
				
				$category = $http->postVariable( $base . '_ayabinaryfile_category_' . $contentObjectAttribute->attribute( 'id' ) );
				$action = $http->postVariable( $base . '_ayabinaryfile_action_' . $contentObjectAttribute->attribute( 'id' ) );
				$label = $http->postVariable( $base . '_ayabinaryfile_label_' . $contentObjectAttribute->attribute( 'id' ) );
				
				$binary->setAttribute( "contentobject_attribute_id", $contentObjectAttributeID );
				$binary->setAttribute( "version", $version.'/'.$category.';'.$action.';'.$label);
				$binary->setAttribute( "filename", basename( $binaryFile->attribute( "filename" ) ) );
				$binary->setAttribute( "original_filename", $binaryFile->attribute( "original_filename" ) );
				$binary->setAttribute( "mime_type", $mime );

				$binary->store();

				$filePath = $binaryFile->attribute( 'filename' );
				$fileHandler = eZClusterFileHandler::instance();
				$fileHandler->fileStore( $filePath, 'binaryfile', true, $mime );
				$contentObjectAttribute->setContent( $binary );
				$file = true;
			}
		}
		/** Gestion des google tags **/
		if( 	$http->hasPostVariable( $base . '_ayabinaryfile_category_' . $contentObjectAttribute->attribute( 'id' ) ) and
				$http->hasPostVariable( $base . '_ayabinaryfile_action_' . $contentObjectAttribute->attribute( 'id' ) ) and
				$http->hasPostVariable( $base . '_ayabinaryfile_label_' . $contentObjectAttribute->attribute( 'id' ) ) 
			){
		
			$category = $http->postVariable( $base . '_ayabinaryfile_category_' . $contentObjectAttribute->attribute( 'id' ) );
			$action = $http->postVariable( $base . '_ayabinaryfile_action_' . $contentObjectAttribute->attribute( 'id' ) );
			$label = $http->postVariable( $base . '_ayabinaryfile_label_' . $contentObjectAttribute->attribute( 'id' ) );
			
			$contentObjectAttribute->setAttribute( "data_text",  $category.';'.$action.';'.$label);
			return true;
			
		}elseif($file){
			return true;
		}
		
		return false;
    }

    /*!
     Does nothing, since the file has been stored. See fetchObjectAttributeHTTPInput for the actual storing.
    */
    function storeObjectAttribute( $contentObjectAttribute )
    {
    }

    function customObjectAttributeHTTPAction( $http, $action, $contentObjectAttribute, $parameters )
    {
        ayaBinaryFileType::checkFileUploads();
        if( $action == "delete_binary" )
        {
            $contentObjectAttributeID = $contentObjectAttribute->attribute( "id" );
            $version = $contentObjectAttribute->attribute( "version" );
            $this->deleteStoredObjectAttribute( $contentObjectAttribute, $version );
        }
    }
}
 
eZDataType::register( ayaBinaryFileType::DATA_TYPE_STRING, "ayaBinaryFileType" );
 
?>