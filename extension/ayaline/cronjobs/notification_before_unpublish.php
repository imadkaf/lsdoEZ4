<?php
//Envoi une notification aux utilisateurs spécifiés pour prévenir de la dépublication avenir de contenus
/*
 * Ce script doit être joué une fois par jour
 */

$data_mails = Array();
$contentsNameToUnpublish = Array();

//Console
$cli = eZCLI::instance();
$cli->setUseStyles( true );
$cli->output( $cli->stylize( 'black', 'Debut du script'), true );

// Check for extension
require_once( 'kernel/common/ezincludefunctions.php' );
eZExtension::activateExtensions();
// Extension check end

$iniSite = eZINI::instance('siteaccess/ayaline_admin/site.ini');
$iniContent = eZINI::instance( 'content.ini' );
$unpublishClasses = $iniContent->variable( 'UnpublishSettings','ClassList' );
$rootNodeIDList = $iniContent->variable( 'UnpublishSettings','RootNodeList' );
$iniNotif = eZINI::instance( 'notification.ini' );
$groupUserIds = $iniNotif->variable('contentUnpublishedToAlert','user_group_node_id');
$dayBeforeunpublish = $iniNotif->variable('contentUnpublishedToAlert','TimeBeforeUnpublish');

$alertDate = mktime(0, 0, 0, date("m", time()), date("d", time())+(int)$dayBeforeunpublish[0], date("Y", time()));
$cli->output( $cli->stylize( 'red', 'default alert timestamp : '. $alertDate), true );

foreach( $rootNodeIDList as $nodeID )
{
	$cli->output( $cli->stylize( 'green', 'Check under node id : '. $nodeID), true );
    $rootNode = eZContentObjectTreeNode::fetch( $nodeID );

    $articleNodeArray = $rootNode->subTree( array( 'ClassFilterType' => 'include',
                                                    'ClassFilterArray' => $unpublishClasses ) );

    foreach ( $articleNodeArray as $articleNode )
    {
        $article = $articleNode->attribute( 'object' );
		if (isset($dayBeforeunpublish[$article->contentClassIdentifier()])){
			$alertDate = mktime(0, 0, 0, date("m", time()), date("d", time())+(int)$dayBeforeunpublish[$article->contentClassIdentifier()], date("Y", time()));
			$cli->output( $cli->stylize( 'red', 'alert timestamp : '. $alertDate), true );
		}
        $dataMap = $article->attribute( 'data_map' );

        $dateAttribute = $dataMap['unpublish_date'];

        if ( $dateAttribute !== null ){
	        $date = $dateAttribute->content();
	        $articleRetractDate = mktime(0, 0, 0, date("m", $date->attribute( 'timestamp' )), date("d", $date->attribute( 'timestamp' )), date("Y", $date->attribute( 'timestamp' )));
			$cli->output( $cli->stylize( 'black', $article->ID . '->unpublish timestamp : '. $articleRetractDate), true );
	        if ( $articleRetractDate > 0 && $articleRetractDate == $alertDate )
	        {
	        	array_push($contentsNameToUnpublish, Array($article->name(), 'http://'.$iniSite->variable( 'SiteSettings', 'SiteURL' ).'/'.$articleNode->urlAlias (), date("d/m/Y à H:i", $date->attribute( 'timestamp' ))));
	        }
        }
    }
}
if (count($contentsNameToUnpublish)>0){
	$cli->output( $cli->stylize( 'green', 'Envoi de la notification'), true );
	// Envoi de la notification
	$mail = new aYacMail();
	$data_mails["subject"] = '['.$iniSite->variable( 'SiteSettings', 'SiteName' ).'] Notification : contenus bientot supprimes';
	$message = "Liste des contenus qui seront dépubliés dans " . $dayBeforeunpublish[0] . " jour(s) : <ul>";
	foreach ($contentsNameToUnpublish as $contentToUnpublish){
		$message .= "<li><a href=\"".$contentToUnpublish[1]."\">" . $contentToUnpublish[0] . "</a> sera dépublié le ".$contentToUnpublish[2]."</li>";		
	}
	$message .= "</ul>";
	$data_mails["message"] = $message;
	foreach ($groupUserIds as $groupUserId) {
		$data_mails["email"] .= implode("\n", $mail->emailsGroupUser($groupUserId));
	}
//	$cli->output( $cli->stylize( 'magenta', print_r($data_mails, true)), true );
	$mail->send_mail($data_mails);
}
$cli->output( $cli->stylize( 'black', 'Fin du script'), true );
?>
