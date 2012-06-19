<?php

$tpl=eZTemplate::factory();
$http=eZHTTPTool::instance();

$Result['content'] = $tpl->fetch('design:aya_carto/full.tpl');
    $Result['path'] = array(
            array(
                'url' => '',
                'url_alias' => '',
                'text' => 'Accueil'),
            array(
                'url' => false,
                'url_alias' => false,
                'text' => 'Cartographie'));

?>
