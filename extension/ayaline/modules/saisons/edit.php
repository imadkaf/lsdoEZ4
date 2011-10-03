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
$http->setSessionVariable('saisonCourante', 0);
if ( is_numeric( $http->postVariable( 'season_id' ) ) ) {
    $season_id = $http->postVariable( 'season_id' );
    if ($http->hasSessionVariable('saison')){
    	if ( $season_id == $http->sessionVariable('saison') ) {
    		$season_id = 0;    	
    		$http->removeSessionVariable('saison');
    	}
    	else {
    		$http->setSessionVariable('saison', $season_id);
    	}
    }
    else $http->setSessionVariable('saison', $season_id);
    
    // on indique également si la saison sélectionnée est la saison courante (si on est le 30 aout et que la saison sélectionnée est l'été, alors on passe le booléen à TRUE
    /* $season_id = 0 -> Automne : du 21-09 au 20-12
     * $season_id = 1 -> Hiver : du 21-12 au 20-03
     * $season_id = 2 -> Printemps : 21-03 au 20-06
     * $season_id = 3 -> Ete : 21-06 au 20-09
     */ 
	$now = time(); // date actuelle
	$debutPrintemps = mktime(0,0,1,3,21, date('Y')); // 21 mars de chaque année (à 0h00:01)
	$finPrintemps = mktime(23,59,59,6,20, date('Y')); // 20 septembre (à 23h59:59)
	$debutEte = mktime(0,0,1,6,21, date('Y')); 
	$finEte = mktime(23,59,59,9,20, date('Y'));
	$debutAutomne = mktime(0,0,1,9,21, date('Y')); 
	$finAutomne = mktime(23,59,59,12,20, date('Y'));
	$debutHiver = mktime(0,0,1,12,21, date('Y')); 
	$finHiver = mktime(23,59,59,03,20, date('Y'));  
	 
	if($now >= $debutPrintemps && $now <= $finPrintemps && $season_id==2) 
		$http->setSessionVariable('saisonCourante', 1);
	if($now >= $debutEte && $now <= $finEte && $season_id==3) 
		$http->setSessionVariable('saisonCourante', 1);
	if($now >= $debutAutomne && $now <= $finAutomne && $season_id==0) 
		$http->setSessionVariable('saisonCourante', 1);
	if($now >= $debutHiver && $now <= $finHiver && $season_id==1) 
		$http->setSessionVariable('saisonCourante', 1);
}
else {
    $season_id = 0;
	$http->setSessionVariable('saison', $season_id);
}

// *	- 2 : Redirection vers la page consultée

$homeUri = "/";
eZURI::transformURI($homeUri);

$userRedirectURI = $http->postVariable( 'RedirectURI', $homeUri );
eZRedirectManager::redirectTo( $Module, false, true, false, $userRedirectURI );

?>
