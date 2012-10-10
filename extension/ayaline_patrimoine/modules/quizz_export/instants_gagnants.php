<?php
require_once( 'kernel/common/template.php' );
$tpl = templateInit();
$http = eZHTTPTool::instance();

// Date du jour
$aujourdhuiDeb = mktime ('00', '00', '00', date("n"), date("j"), date("Y"));
$aujourdhuiFin = mktime ('23', '59', '59', date("n"), date("j"), date("Y"));

// Ajouter un nouvel instant gagnant
if ($http->hasPostVariable('dateAjoutIG') && $http->hasPostVariable('heureAjoutIG')) {
	$dateAjoutIG 	= $http->postVariable('dateAjoutIG');
	$heureAjoutIG 	= $http->postVariable('heureAjoutIG');
	$tabDate 		= explode('/', $dateAjoutIG);
	$tabHeure 		= explode(':', $heureAjoutIG);
	$tsIgToAdd 		= mktime ($tabHeure[0], $tabHeure[1], '00', $tabDate[1], $tabDate[0], $tabDate[2] );

	if ($http->postVariable('dateAjoutIG')==''){
		// Date saisie ?
		$tpl->setVariable('msgErreur', "Veuillez saisir une date.");
		
	} elseif (!checktime($tabHeure[0], $tabHeure[1])){
		// Heure invalide ?
		$tpl->setVariable('msgErreur', "L'heure ". $heureAjoutIG ." n'est pas valide (hh:mm).");
		
	} elseif ($tsIgToAdd<$aujourdhuiDeb){
		// Date passée ? 
		$tpl->setVariable('msgErreur', "La date ". $dateAjoutIG ." est passée.");
		
	} elseif ($tsIgToAdd<time()){
		// Heure passée ? 
		$tpl->setVariable('msgErreur', "L'heure ". $heureAjoutIG ." de l'instant gagnant est passée.");
		
	} elseif (QuizzInstantGagnantManagement::dateExistante($tsIgToAdd)){
		// Date existante ?
		$tpl->setVariable('msgErreur', "Un instant gagnant existe déjà pour cette date.");
	
	} else {
		// Ajout de l'instant gagnant
		$idAdded = QuizzInstantGagnantManagement::newSave(date('Y-m-d H:i:s',$tsIgToAdd));
		if ($idAdded) {
			$tpl->setVariable('msgConfirm', "L'instant gagnant (". $dateAjoutIG ." à partir de ". $heureAjoutIG .") a été ajouté.");
		} else {
			$tpl->setVariable('msgErreur', "L'instant gagnant (". $dateAjoutIG ." à partir de ". $heureAjoutIG .") n'a pas pu être ajouté. Une erreur s'est produite.");
		}
	}
	

// Supprimer un instant gagnant enregistré
}elseif ($http->hasPostVariable('igs')) {
    $igs = $http->postVariable('igs');
	$igToDelete = QuizzInstantGagnantManagement::loadById($igs);
	
	$tabDateHeure 	= explode(' ', $igToDelete->date_heure);
	$tabDate 		= explode('-', $tabDateHeure[0]);
	$tabHeure 		= explode(':', $tabDateHeure[1]);
	$tsIgToDelete 	= mktime ($tabHeure[0], $tabHeure[1], '00', $tabDate[1], $tabDate[0], $tabDate[2] );
	
	if ($igToDelete->gagne!=""){
		// Pas de suppression si l'instant est gagné
		$tpl->setVariable('msgErreur', "L'instant gagnant ne peut être supprimé car il a été déclaré comme gagnant.");
	
	} elseif ($tsIgToDelete<$aujourdhuiDeb){
		// Pas de suppression si l'instant est perdu (date passée)
		$tpl->setVariable('msgErreur', "L'instant gagnant ne peut être supprimé car il est déjà passé.");
	
	} elseif ($tsIgToDelete<$aujourdhuiFin){
		// Pas de suppression si l'instant est en cours
		$tpl->setVariable('msgErreur', "L'instant gagnant ne peut être supprimé car il est en cours.");
	
	} else {
		// Suppression de l'IG
		QuizzInstantGagnantManagement::deleteById($igs);
		$tpl->setVariable('msgConfirm', "L'instant gagnant a été supprimé.");
		
	}

}


// Liste des instants gagnants enregistrés
$instantsGagnants = QuizzInstantGagnantManagement::getListInstantsGagnants();
$tabMoisIG = array();
foreach ($instantsGagnants as $instant) {
	$tabDateHeure 	= explode(' ', $instant->date_heure);
	$tabDate 		= explode('-', $tabDateHeure[0]);
	$tabHeure 		= explode(':', $tabDateHeure[1]);
	$timestampIG = mktime ($tabHeure[0], $tabHeure[1], $tabHeure[2], $tabDate[1], $tabDate[2], $tabDate[0] );
	
	if ($instant->gagne){
		// L'instant est gagné
		$gagneIG = "gagne";
	} elseif ($timestampIG<$aujourdhuiDeb){
		// L'instant est perdu (date passée)
		$gagneIG = "perdu";
	} elseif($timestampIG<$aujourdhuiFin){
		// L'instant est en cours (date du jour AVANT minuit)
		$gagneIG = "encours";
	} else {
		// Instant à venir (supprimable)
		$gagneIG = "";
	}
	setlocale(LC_ALL, "fr_FR");
	$moisAnneeIG = ucfirst(utf8_encode(strftime ('%B %G', $timestampIG)));
	$affichageIG = "Le " . utf8_encode(strftime ('%A %d %B %G', $timestampIG)) . " à partir de " . date('H:i', $timestampIG);
	if (!array_key_exists($moisAnneeIG, $tabMoisIG)) {
		// Nouvel entrée mois
		$tabMoisIG[$moisAnneeIG] = array(array($instant->id,$affichageIG,$gagneIG));
	} else {
		$tabMoisIG[$moisAnneeIG] = array_merge($tabMoisIG[$moisAnneeIG],array(array($instant->id,$affichageIG,$gagneIG)));
	}
}
$tpl->setVariable('tabMoisIG', $tabMoisIG);


// Templating
$Result = array();
$Result['left_menu'] = 'design:parts/quizz_export/left_menu.tpl';
$Result['content'] = $tpl->fetch('design:quizz_export/export_instantsgagnants.tpl');
$Result['path'] = array(
    array('url' => false,
        'text' => 'Quizz'),
    array('url' => false,
        'text' => 'Instants gagnants')
    );
	
	

function checktime($hour, $minute) { 
    if ($hour > -1 && $hour < 24 && $minute > -1 && $minute < 60) { 
        return true; 
    } 
} 


