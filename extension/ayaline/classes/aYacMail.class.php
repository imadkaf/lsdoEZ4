<?php


/**
 * 
 * @author gseguin
 *
 */
require_once 'lib/ezutils/classes/ezmail.php';
class aYacMail extends ezMail
{

	//Notification par email
	public function send_mail($datas, $mailTplPath='design:notification/view/full.tpl') {
		// variables diverses
		$hostname = eZSys::hostname();
		$ini =& eZINI::instance();
		$responseArray = array();

		// Récupération des informations
		$subject = '[' . $ini->variable( 'SiteSettings', 'SiteName' ) . '] notification';
		if ( $datas[ 'subject' ] ) {
	        $subject = $datas[ 'subject' ];
		}
		if ( $datas[ 'email' ] )
	        $receiversEmail = $datas[ 'email' ];
		$tbReceivers_tmp = split("\n", $receiversEmail);
		$tbReceivers = array();
		foreach ($tbReceivers_tmp as $elem) {
			$elem = trim($elem);
			if ($elem) {
				$tbReceivers[] = $elem;
			}
		}
		$tbReceivers = array_unique ( $tbReceivers );

		// Variable contenant les messages d'erreur
		$error_strings = array();

		##############
		## Contrôles d'erreur
		##############
		# contrôle email
		$oneAtLeast = false;
		foreach ($tbReceivers as $elem) {
			$str_err = '';
			$oneAtLeast = true;
			if (preg_match("`<([\w, @, \., \-, _]+)>\s[\w]+`", $elem, $reg)){
				if ( !eZMail::validate( $reg[1] ) ){
					$str_err = ezi18n( 'kernel/content', 'The email address of the receiver is not valid' );
				}
			}elseif ( !eZMail::validate( $elem ) )
					$str_err = ezi18n( 'kernel/content', 'The email address of the receiver is not valid' );
			if ($str_err) {
				$error_strings = $str_err . "<br />";
				break;
			}
		}
		if (!$oneAtLeast)
			$error_strings = ezi18n( 'kernel/content', 'The email address of the receiver is not valid' )."<br />";
	    $fromEmail = null;
	    if ( $ini->hasVariable( 'MailSettings', 'AdminEmail' ) )    {
	        $fromEmail = $ini->variable( 'MailSettings', 'AdminEmail' );
	        $fromEmailName = $ini->variable( 'MailSettings', 'AdminName' );
	        if ( $fromEmail != null )
	            if ( !eZMail::validate( $fromEmail ) )
	            {
	                eZDebug::writeError( "The email < $fromEmail > specified in [MailSettings].AdminEmail setting in site.ini is not valid",'MailSettings' );
	                //$fromEmail = null;
	            }
	    }

		if ( count( $error_strings ) == 0 ) {

			foreach ($tbReceivers as $elem) {

		        $this->setSender( $fromEmail, $fromEmailName );
		        
		        if (preg_match("`<([\w, @, \., \-, _]+)>\s([\w]+)`", $elem, $reg)){
					$this->setReceiver( $reg[1], $reg[2] );
		        }else{
					$this->setReceiver( $elem );
		        }
		        $this->setSubject( $subject );

		        // fetch text from mail template
		        require_once( 'kernel/common/template.php' );
		        $mailtpl	=& templateInit();
		        foreach ($datas as $key => $value) {
		        	if ($key != 'subject' && $key != 'email'){
		        		$mailtpl->setVariable( $key, $value );
		        	}
		        }
		        $mailtext =& $mailtpl->fetch( $mailTplPath );

		        $this->setBody( $mailtext );

		        // mail was sent ok
		        if ( eZMailTransport::send( $this ) )
		        {
		            $responseArray['re'] = true;
		            eZLog::write( "email ($subject) send to $elem", 'sqli_notification.log' );
		        }else{
					$responseArray['re'] = false;
	        		$responseArray['er'] =  urlencode('Erreur de la méthode send de eZMailTransport : '.$fromEmail);
				}
			}
	    } else {
			// Envoi des erreurs
			$responseArray['re'] = 'ko';
	        $responseArray['er'] =  urlencode($error_strings);
		}

		// retour de l'objet response
		return $responseArray;

	}
	
	public function emailsGroupUser ($parentNodeId){
		$result = Array();
		$params = array(
					'parent_node_id' => $parentNodeId,
					'class_filter_type' => 'include',
					'class_filter_array' => array('user')
				);
		$users = eZFunctionHandler::execute('content','list', $params);

		foreach ($users as $user) {
			$attributes = $user->dataMap();
			$contentUserAccount = $attributes['user_account']->content();
			array_push($result, "<{$contentUserAccount->Email}> {$user->Name}");
		}

		return $result;
	}
}