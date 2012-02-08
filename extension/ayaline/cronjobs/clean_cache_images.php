<?php
// nettoyage du dossier ez_aya_sit/cache/images : suppression des images ayant plus de 2 jours

//Console
$cli = eZCLI::instance();
$cli->setUseStyles( true );
$cli->output( $cli->stylize( 'black', 'Debut du script'), true );

// Check for extension
require_once( 'kernel/common/ezincludefunctions.php' );

ob_start();
exec(' cd var/ez_aya_sit/cache/images/', $output);
exec('find -name "*" -atime +7 -exec rm -rf {} \;', $output);
$content_grabbed=ob_get_contents();
ob_end_clean();

$cli->output( $cli->stylize( 'black', 'Fin du script'), true );
?>
