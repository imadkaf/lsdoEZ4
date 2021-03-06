<?php
//
// Created on: <02-Apr-2004 00:00:00 Jan Kudlicka>
//
// Copyright (C) 1999-2008 eZ Systems as. All rights reserved.
//
// This source file is part of the eZ Publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE.GPL included in
// the packaging of this file.
//
// Licencees holding valid "eZ Publish professional licences" may use this
// file in accordance with the "eZ Publish professional licence" Agreement
// provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ Publish professional licence" is available at
// http://ez.no/products/licences/professional/. For pricing of this licence
// please contact us via e-mail to licence@ez.no. Further contact
// information is available at http://ez.no/home/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

/*! \file action.php
 */
$http = eZHTTPTool::instance();

$Module = $Params['Module'];

$actionContinue = false;
if ( $http->hasPostVariable( 'NodeID' ) and
     $http->hasPostVariable( 'ContentObjectAttributeID' ) and
     $http->hasPostVariable( 'SurveyID' ) )
{
    $surveyID = $http->postVariable( 'SurveyID' );
    $contentObjectAttributeID = $http->postVariable( 'ContentObjectAttributeID' );
    $nodeID = $http->postVariable( 'NodeID' );
    $node = eZContentObjectTreeNode::fetch( $nodeID );
    if ( get_class( $node ) == 'eZContentObjectTreeNode' and
         $node->canRead() === true )
    {
        $dataMap = $node->dataMap();
        foreach ( $dataMap as $attribute )
        {
            $attributeObjectID = $attribute->attribute( 'id' );
            if ( $attributeObjectID == $contentObjectAttributeID )
            {
                $actionContinue = true;
                break;
            }
        }
    }
    else if ( get_class( $node ) == 'eZContentObjectTreeNode' )
    {
        eZDebug::writeWarning( "Not enough permissions to read node with ID: " . $nodeID . ".",
                               'action.php' );
        $Module->redirectTo( $node->attribute( 'url_alias' ) );
    }
    else
    {
        eZDebug::writeWarning( "node with ID: " . $nodeID . " does not exist.",
                               'action.php' );
        return;
    }
}
else
{
    eZDebug::writeWarning( "All the postvariables NodeID, ContentObjectAttributeID and SurveyID need to be supplied.",
                           'action.php' );
    return;
}

$nodeID = $http->postVariable( 'NodeID' );
$node = eZContentObjectTreeNode::fetch( $nodeID );
if ( get_class( $node ) == 'eZContentObjectTreeNode' )
{
    $Module->redirectTo( $node->attribute( 'url_alias' ) );
}

if ( $actionContinue === true )
{
    $survey = eZSurvey::fetch( $surveyID );
    $status = $survey->validateContentObjectAttributeID( $contentObjectAttributeID );

    if ( !$survey or !$survey->published() or !$survey->enabled() or !$survey->valid() )
    {
        return $Module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );
    }

    if ( $http->hasPostVariable( 'SurveyCancelButton' ) )
    {
        $Module->redirectTo( $survey->attribute( 'redirect_cancel' ) );
        return;
    }

    $params = array( 'prefix_attribute' => eZSurveyType::PREFIX_ATTRIBUTE,
                     'contentobjectattribute_id' => $contentObjectAttributeID );

    $validation = array();
    $survey->processViewActions( $validation, $params );

    if ( $http->hasPostVariable( 'SurveyStoreButton' ) && $validation['error'] == false )
    {
        $user = eZUser::currentUser();
        if ( $survey->attribute( 'persistent' ) )
        {
            $result = eZSurveyResult::instance( $surveyID, $user->id() );
        }
        else
        {
            $result = eZSurveyResult::instance( $surveyID );
        }

        $result->setAttribute( 'user_id', $user->id() );

        $http = eZHTTPTool::instance();
        $sessionID = $http->sessionID();

        $result->setAttribute( 'user_session_id', $sessionID );

        $result->storeResult();
        

//         if ( $http->hasPostVariable( 'SurveyReceiverID' ) )
//         {
//             $surveyList = $survey->fetchQuestionList();
//             $mailTo = $surveyList[$http->postVariable( 'SurveyReceiverID' )]->answer();

//             $tpl_email = templateInit();

//             $tpl_email->setVariable( 'survey', $survey );
//             $tpl_email->setVariable( 'survey_questions', $surveyList );

//             $templateResult = $tpl_email->fetch( 'design:survey/mail.tpl' );
//             $subject = $tpl_email->variable( 'subject' );
//             $mail = new eZMail();
//             $ini = eZINI::instance();
//             $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
//             if ( !$emailSender )
//                 $emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
//             $mail->setSenderText( $emailSender );
//             $mail->setReceiver( $mailTo );
//             $mail->setSubject( $subject );
//             $mail->setBody( $templateResult );

//             $mailResult = eZMailTransport::send( $mail );
//         }
        $Module->redirectTo( $survey->attribute( 'redirect_submit' ) );
    }

//     $res = eZTemplateDesignResource::instance();
//     $res->setKeys( array( array( 'survey', $surveyID ) ) );

//     require_once( 'kernel/common/template.php' );
//     $tpl = templateInit();

//     $tpl->setVariable( 'preview', false );
//     $tpl->setVariable( 'survey', $survey );
//     $tpl->setVariable( 'survey_validation', $validation );

//     $Result = array();
//     $Result['content'] = $tpl->fetch( 'design:survey/action.tpl' );
//     $Result['path'] = array( array( 'url' => false,
//                                     'text' => ezi18n( 'survey', 'Survey' ) ) );
}
if ( is_object( $Module ) )
$Module->redirectTo( $node->attribute( 'url_alias' ) );

?>
