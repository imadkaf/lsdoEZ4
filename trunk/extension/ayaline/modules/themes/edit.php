<?php
/**
 *	- 1 : Mise en session du thème en fonction de l'indentifiant du thème passé en paramètre
 *	- 2 : Redirection vers la page consultée
 *
 * @author gseguin
 * @version 1
 */
$Module = $Params['Module'];
$http = eZHTTPTool::instance();
// *	- 1 : Mise en session de la saison en fonction de l'indentifiant de la saison passé en paramètre
if ( is_numeric( $http->postVariable( 'topic_id' ) ) ){
    $topic_id = $http->postVariable( 'topic_id' );
}else{
    $topic_id = 0;
}
if ($http->hasSessionVariable('topics')){
	$topic_ids = $http->sessionVariable('topics');
	if (in_array($topic_id, $topic_ids)==true) {
		foreach ($topic_ids as $key=>$value) {
			if ($value==$topic_id) unset($topic_ids[$key]);
		} 
	} else {
		$topic_ids = array(); // JMA : un seul thème possible à fois, donc si un autre thème est sélectioné, je vide le tableau. (le tableau aura donc tjs 0 ou 1 valeur)
	//	$topic_ids=array(); // on vide le thème courant, on ne doit avoir toujours qu'un seul thème de sélectionné
		array_push($topic_ids, $topic_id);		
	}
}else{
	$topic_ids = array($topic_id);
}
//print_r($topic_ids);exit;
$http->setSessionVariable('topics', $topic_ids);	

// *	- 2 : Redirection vers la page consultée
$userRedirectURI = $http->postVariable( 'RedirectURI', $homeUri );
eZRedirectManager::redirectTo( $Module, false, true, false, $userRedirectURI );

?>
