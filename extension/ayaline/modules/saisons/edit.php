<?php
/**
 *	- 1 : Mise en session de la saison en fonction de l'indentifiant de la saison passé en paramètre
 *	- 2 : Redirection vers la page consultée
 *
 * @author gseguin
 * @version 1
 */
$Module = $Params['Module'];
$http = eZHTTPTool::instance();
// *	- 1 : Mise en session de la saison en fonction de l'indentifiant de la saison passé en paramètre
if ( is_numeric( $http->postVariable( 'season_id' ) ) )
    $season_id = $http->postVariable( 'season_id' );
else
    $season_id = 0;
$http->setSessionVariable('saison', $season_id);

// *	- 2 : Redirection vers la page consultée
$userRedirectURI = $http->postVariable( 'RedirectURI', $http->sessionVariable( 'LastAccessesURI', '/' ) );
eZRedirectManager::redirectTo( $Module, $userRedirectURI );
return;
?>

