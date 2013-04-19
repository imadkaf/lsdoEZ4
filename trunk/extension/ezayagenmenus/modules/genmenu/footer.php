<?php

/**
 * Description of Module genmenu/footer
 *
 * @author mzammouri - aYaline - mzammouri@ayaline.com
 */

$tpl=eZTemplate::factory();
$http=eZHTTPTool::instance();
$eziniLayout = eZINI::instance('layout.ini');
$i18nINI = eZINI::instance( 'i18n.ini' );
$layoutStyle = 'ezayagenmenus';


//TODO : code here




$Result['pagelayout'] = $eziniLayout->variable($layoutStyle, 'PageLayout');
$Result['content'] = $tpl->fetch('design:genmenu/footer.tpl');
/* Layout ContentType */
if ( $eziniLayout->hasVariable( $layoutStyle, 'ContentType' ) ){
    header( 'Content-Type: ' . $eziniLayout->variable( $layoutStyle, 'ContentType' ) . '; charset=' . $i18nINI->variable( 'CharacterSettings', 'Charset' ) );
}

?>