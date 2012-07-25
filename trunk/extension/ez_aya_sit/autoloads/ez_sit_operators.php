<?php

require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

class eZSitOperators {
	/*!
	Constructor
	*/
	function eZSitOperators() {
		$this->Operators = array(
			'sit_liste',
			'sit_recherche',
			'sit_mise_en_avant'
		);
	}

	/*!
	Returns the operators in this class.
	*/
	function &operatorList() {
		return $this->Operators;
	}

	/*!
	Returns true to tell the template engine that the parameter list
	exists per operator type, this is needed for operator classes
	that have multiple operators.
	*/
	function namedParameterPerOperator() {
		return true;
	}

	/*!
	The first operator has two parameters, the other has none.
	See eZTemplateOperator::namedParameterList()
	*/
	function namedParameterList() {
		return array(
			'sit_liste' => array(
				'xslFile' => array(
					'type' => 'string',
					'required' => false,
					'default' => 'sit_liste'
				)
			),
			'sit_recherche' => array(
				'xslFile' => array(
					'type' => 'string',
					'required' => false,
					'default' => 'sit_recherche'
				)
			),
			'sit_mise_en_avant' => array(
				'currentNode' => array(
					'type' => 'eZContentObjectTreeNode',
					'required' => true,
					'default' => null
				),
				'modesAffichage' => array(
					'type' => 'array',
					'required' => true,
					'default' => array()
				),
				'xslFile' => array(
					'type' => 'string',
					'required' => false,
					'default' => ''
				),
				'categories' => array(
					'type' => 'array',
					'required' => false,
					'default' => array()
				)
			)
		);
	}

	/*!
	Executes the needed operator(s).
	Checks operator names, and calls the appropriate functions.
	*/
	function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters) {
		$currentNode = array_key_exists('currentNode', $namedParameters) ? $namedParameters['currentNode'] : false;

		if (!$currentNode || $currentNode == 'null' || get_class($currentNode) != 'eZContentObjectTreeNode') {
			$currentNode = $tpl->variable('node');
		}

		if (!$currentNode || $currentNode == 'null' || get_class($currentNode) != 'eZContentObjectTreeNode') {
			$currentNodeId = $tpl->variable('module_result');
			if ($currentNodeId) {
				$currentNodeId = $currentNodeId['node_id'];
				if ($currentNodeId) {
					$currentNode = eZFunctionHandler::execute(
						'content',
						'node',
						array (
							'node_id' => $currentNodeId,
						)
					);
				}
			}
		}
		if (!$currentNode || $currentNode == 'null') {
			$currentNode = $tpl->variable('previousNode');
		}

		switch ($operatorName) {
			case 'sit_recherche':
				$operatorValue = $currentNode ? $this->sitRecherche($currentNode, $tpl->variable('view_parameters'), eZURLOperator::eZImage($tpl, 'sit/', ''), $namedParameters['xslFile'] ? $namedParameters['xslFile'] : 'sit_recherche') : "";
				break;
			case 'sit_liste':
				$operatorValue = $currentNode ? $this->sitListe($currentNode, $tpl->variable('view_parameters'), eZURLOperator::eZImage($tpl, 'sit/', ''), $namedParameters['xslFile'] ? $namedParameters['xslFile'] : 'sit_liste', $tpl->variable('idFicheEnCours')) : "";
				break;
			case 'sit_mise_en_avant':
				$operatorValue = $currentNode ? $this->sitMiseEnAvant($currentNode, $tpl->variable('view_parameters'), eZURLOperator::eZImage($tpl, 'sit/', ''), $namedParameters['modesAffichage'], $namedParameters['xslFile'] ? $namedParameters['xslFile'] : '', $namedParameters['categories']) : "";
				break;
		}
	}

	function sitRecherche($currentNode, $viewParameters, $cheminImages, $xslFile) {
		$lienCourant = $currentNode->attribute('url_alias');
		eZURI::transformURI($lienCourant);

		$sitListe = $currentNode->attribute('object');

		if (!$sitListe || $sitListe->ClassIdentifier != 'sit_liste') {
			$currentNodeObjects = eZFunctionHandler::execute(
				'content',
				'list',
				array (
					'parent_node_id' => $currentNode->attribute('node_id'),
					'offset' => 0,
					'limit' => 1,
					'class_filter_type' => 'include',
					'class_filter_array' => array('sit_liste')
				)
			);

			if (!$currentNodeObjects) {
				return "";
			}

			$sitListe = $currentNodeObjects[0];
		}

		return $this->sitRechercheHtml($sitListe->dataMap(), $viewParameters, $lienCourant, $cheminImages, $xslFile);
	}

	function sitListe($currentNode, $viewParameters, $cheminImages, $xslFile, $idFicheEnCours) {
		$lienCourant = $currentNode->attribute('url_alias');
		eZURI::transformURI($lienCourant);

		$sitListe = $currentNode->attribute('object');

		if (!$sitListe || $sitListe->ClassIdentifier != 'sit_liste') {
			$currentNodeObjects = eZFunctionHandler::execute(
				'content',
				'list',
				array (
					'parent_node_id' => $currentNode->attribute('node_id'),
					'offset' => 0,
					'limit' => 1,
					'class_filter_type' => 'include',
					'class_filter_array' => array('sit_liste')
				)
			);

			if (!$currentNodeObjects) {
				return "";
			}

			$sitListe = $currentNodeObjects[0];
		}

		return $this->sitListeHtml($sitListe->dataMap(), $viewParameters, $lienCourant, $cheminImages, $currentNode->attribute('url_alias'), $xslFile, $idFicheEnCours);
	}

	function sitMiseEnAvant($currentNode, $viewParameters, $cheminImages, $modesAffichage, $xslFile, $categories) {
		$lienCourant = $currentNode->attribute('url_alias');
		eZURI::transformURI($lienCourant);

		$sitMiseEnAvant = $currentNode->attribute('object');

		if (!$categories) {
			$categories = array();
		}

		$sitMiseEnAvantMatch = false;
		if ($sitMiseEnAvant && $sitMiseEnAvant->ClassIdentifier == 'sit_mise_en_avant') {
			$sitMiseEnAvantDataMap = $sitMiseEnAvant->dataMap();
			$categorie = $sitMiseEnAvantDataMap['categorie']->value();
			$categorie = $categorie[0];
			$modeAffichage = $sitMiseEnAvantDataMap['mode_affichage']->value();
			$modeAffichage = $modeAffichage[0];
			if ((count($categories) == 0 || !$categorie || in_array($categorie, $categories)) && (count($modesAffichage) == 0 || !$modeAffichage || in_array($modeAffichage, $modesAffichage))) {
				$sitMiseEnAvantMatch = true;
			}
		}
		if (!$sitMiseEnAvant || $sitMiseEnAvant->ClassIdentifier != 'sit_mise_en_avant' || !$sitMiseEnAvantMatch) {
			$fetchParameters = array (
				'parent_node_id' => $currentNode->attribute('node_id'),
				'offset' => 0,
				'limit' => 1,
				'class_filter_type' => 'include',
				'class_filter_array' => array('sit_mise_en_avant')
			);
			if (count($categories) > 0) {
				$fetchParameters['attribute_filter'] = array(array('sit_mise_en_avant/categorie', 'in', $categories));
			}
			if (count($modesAffichage) > 0) {
				if (count($categories) > 0) {
					array_unshift($fetchParameters['attribute_filter'], 'and');
				} else {
					$fetchParameters['attribute_filter'] = array();
				}
				$fetchParameters['attribute_filter'][] = array('sit_mise_en_avant/mode_affichage', 'in', $modesAffichage);
			}

			$currentNodeObjects = eZFunctionHandler::execute(
				'content',
				'list',
				$fetchParameters
			);

			if (!$currentNodeObjects) {
				return "";
			}

			$sitMiseEnAvant = $currentNodeObjects[0];
		}

		$sitMiseEnAvantUrlAlias = "";
		$sitMiseEnAvantDataMap = $sitMiseEnAvant->dataMap();

		$sitListeReliee = $sitMiseEnAvantDataMap['liste_reliee']->value();
		$sitListeNodes = false;
		if ($sitListeReliee && $sitListeReliee->ClassIdentifier == 'sit_liste') {
			$sitListeNodes = eZFunctionHandler::execute(
				'content',
				'node',
				array (
					'node_id' => $sitListeReliee->attribute('main_node_id')
				)
			);
			if ($sitListeNodes) {
				$sitListeNodes = array($sitListeNodes);
			}
		}

		if (!$sitListeNodes) {
			$contentIni = eZINI::instance('content.ini');
			$rootNodeId = $contentIni->variable('NodeSettings','RootNode');
			$sitListeNodes = eZFunctionHandler::execute(
				'content',
				'list',
				array (
					'parent_node_id' => $rootNodeId,
					'offset' => 0,
					'limit' => 1,
					'depth' => 10,
					'class_filter_type' => 'include',
					'class_filter_array' => array('sit_liste'),
					'attribute_filter' => array(array('sit_liste/categorie', 'in', $sitMiseEnAvantDataMap['categorie']->value()))
				)
			);
		}

		if ($sitListeNodes) {
			$sitMiseEnAvantUrlAlias = $sitListeNodes[0]->attribute('url_alias');
		}

		return $this->sitMiseEnAvantHtml($sitMiseEnAvant->dataMap(), $viewParameters, $lienCourant, $cheminImages, $sitMiseEnAvantUrlAlias, $xslFile);
	}

	// Private section
	var $Operators;

	function sitRechercheHtml($sitListe, $viewParameters, $lienCourant, $cheminImages, $xslFile) {
		$http = eZHTTPTool::instance();

		$sitIni = eZINI::instance('ez_aya_sit.ini');

		$cheminImagesDesign = $sitIni->variable('ImagesDesign','Chemin');

		$siteIni = eZINI::instance('site.ini');

		$langue = $siteIni->variable('RegionalSettings','Locale');
		if ($langue) {
			$langue = substr($langue, 0, 2);
		}

		$saisonId = null;
		if ($http->hasSessionVariable('saison')) {
			$saisonId = $http->sessionVariable('saison');
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
			$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
		} else {
			$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XmlCachePath')) {
			$cheminCacheXml = $sitIni->variable('GlobalSitParametersOverride','XmlCachePath');
		} else {
			$cheminCacheXml = $sitIni->variable('GlobalSitParameters','XmlCachePath');
		}
		$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;
		if (!file_exists($cheminCacheXml)) {
			mkdir($cheminCacheXml, 0777, true);
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XslPath')) {
			$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParametersOverride','XslPath');
		} else {
			$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParameters','XslPath');
		}

		$traductionsStatiques = $sitIni->variable('SitTranslations', 'StaticSitTranslations');
		$traductionsStatiquesComplementaires = array();
		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'StaticSitTranslations')) {
			$traductionsStatiquesComplementaires = $sitIni->variable('GlobalSitParametersOverride','StaticSitTranslations');
		}
		foreach ($traductionsStatiquesComplementaires as $traductionStatiqueComplementaire) {
			if (!in_array($traductionStatiqueComplementaire, $traductionsStatiques)) {
				$traductionsStatiques[] = $traductionStatiqueComplementaire;
			}
		}

		$villes = $sitIni->variable('GlobalSitParameters','ListeVilles');
		if (!$villes) {
			$villes = array();
		}
		$villes = join("#", $villes);

		$triEnCours = "";
		if (array_key_exists('tri', $viewParameters) && $viewParameters['tri']) {
			$triEnCours = $viewParameters['tri'];
		}

		$rechercheEnCours = "non";
		if (array_key_exists('recherche', $viewParameters) && $viewParameters['recherche']) {
			$rechercheEnCours = $viewParameters['recherche'];
		}

		$pageCourante = "1";
		if (array_key_exists('page', $viewParameters) && $viewParameters['page']) {
			$pageCourante = $viewParameters['page'];
		}

		$cheminRacineSite = "/";
		eZURI::transformURI($cheminRacineSite);

		$categorie = $sitListe['categorie']->value();
		$categorie = $categorie[0];

		$dureeVieCache = $sitListe['duree_vie_cache']->value() * 60;

		$criteresTri = $sitListe['criteres_tri']->value();

		$criteresRecherche = $sitListe['criteres_recherche']->value();

		$sitModalitesRapides = array();
		$sitModalitesTexte = "";
		$sitModalitesNum = "";
		$codesInsee = null;
		$motsCles = null;
		$debutDispo = null;
		$dureeDispo = null;
		$ouvAnnee = null;
		$debutOuv = null;
		$finOuv = null;
		if ($http->hasPostVariable("search_sit")) {
			$rechercheEnCours = "oui";

			if ($http->hasPostVariable("sit_mr")) {
				$sitModalitesRapides = $http->postVariable("sit_mr");
			}

			foreach ($sitModalitesRapides as $idCritere=>$sitModaliteRapide) {
				$sitModalitesRapides[$idCritere] = preg_replace("/(^,|,$)/", "", preg_replace("/,+/", ",", implode(",", $sitModaliteRapide)));
			}

			$sitModalitesRapides = preg_replace("/(^\\||\\|$)/", "", preg_replace("/\\|+/", "|", implode("|", $sitModalitesRapides)));

			$http->setSessionVariable("sit_mr_".sha1($lienCourant), $sitModalitesRapides);

			$sitModalitesTexteNum = array();
			if ($http->hasPostVariable("sit_nrtr")) {
				$sitModalitesTexteNum = $http->postVariable("sit_nrtr");
			}

			foreach ($sitModalitesTexteNum as $idCritere=>$sitModaliteTexteNum) {
				if (trim($sitModaliteTexteNum['val']) != "") {
					if (array_key_exists('ope', $sitModaliteTexteNum)) {
						$sitModalitesNum[$idCritere] = $idCritere.urlencode(utf8_decode('Â§')).$sitModaliteTexteNum['val'].urlencode(utf8_decode('Â§')).urlencode($sitModaliteTexteNum['ope']);
					} else {
						$sitModalitesTexte[$idCritere] = $idCritere.urlencode(utf8_decode('Â§')).$sitModaliteTexteNum['val'];
					}
				}
			}

			$sitModalitesTexte = preg_replace("/(^\\||\\|$)/", "", preg_replace("/\\|+/", "|", implode("|", $sitModalitesTexte)));
			$sitModalitesNum = preg_replace("/(^\\||\\|$)/", "", preg_replace("/\\|+/", "|", implode("|", $sitModalitesNum)));

			$http->setSessionVariable("sit_tr_".sha1($lienCourant), $sitModalitesTexte);
			$http->setSessionVariable("sit_nr_".sha1($lienCourant), $sitModalitesNum);

			if ($http->hasPostVariable("sit_cinsee")) {
				$codesInsee = join("|", $http->postVariable("sit_cinsee"));
			}

			$http->setSessionVariable("sit_cinsee_".sha1($lienCourant), $codesInsee);

			if ($http->hasPostVariable("sit_mc")) {
				$motsCles = $http->postVariable("sit_mc");
			}

			$http->setSessionVariable("sit_mc_".sha1($lienCourant), $motsCles);

			if ($http->hasPostVariable("sit_ouvert_annee")) {
				$ouvAnnee = $http->postVariable("sit_ouvert_annee");
			}

			$http->setSessionVariable("sit_ouv_annee_".sha1($lienCourant), $ouvAnnee);

			if ($http->hasPostVariable("sit_debut_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_ouv"))) {
					$debutOuv = $http->postVariable("sit_debut_ouv");
				}
			}

			if (!$ouvAnnee) {
				$http->setSessionVariable("sit_debut_ouv_".sha1($lienCourant), $debutOuv);
			} else {
				if ($http->hasSessionVariable("sit_debut_ouv_".sha1($lienCourant))) {
					$debutOuv = $http->sessionVariable("sit_debut_ouv_".sha1($lienCourant));
				}
			}

			if ($http->hasPostVariable("sit_fin_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_fin_ouv"))) {
					$finOuv = $http->postVariable("sit_fin_ouv");
				}
			}

			if (!$ouvAnnee) {
				$http->setSessionVariable("sit_fin_ouv_".sha1($lienCourant), $finOuv);
			} else {
				if ($http->hasSessionVariable("sit_fin_ouv_".sha1($lienCourant))) {
					$finOuv = $http->sessionVariable("sit_fin_ouv_".sha1($lienCourant));
				}
			}

			if ($http->hasPostVariable("sit_debut_dispo")) {
				if (preg_match("/^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_dispo"))) {
					$debutDispo = $http->postVariable("sit_debut_dispo");
				}
			}

			$http->setSessionVariable("sit_debut_dispo_".sha1($lienCourant), $debutDispo);

			if ($http->hasPostVariable("sit_duree_dispo")) {
				if (preg_match("/^[0-9]+$|^$/", $http->postVariable("sit_duree_dispo")) && $http->postVariable("sit_duree_dispo") > 0) {
					$dureeDispo = $http->postVariable("sit_duree_dispo");
				}
			}

			$http->setSessionVariable("sit_duree_dispo_".sha1($lienCourant), $dureeDispo);
		} else if ($rechercheEnCours == "oui") {
			if ($http->hasSessionVariable("sit_mr_".sha1($lienCourant))) {
				$sitModalitesRapides = $http->sessionVariable("sit_mr_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_tr_".sha1($lienCourant))) {
				$sitModalitesTexte = $http->sessionVariable("sit_tr_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_nr_".sha1($lienCourant))) {
				$sitModalitesNum = $http->sessionVariable("sit_nr_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_cinsee_".sha1($lienCourant))) {
				$codesInsee = $http->sessionVariable("sit_cinsee_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_mc_".sha1($lienCourant))) {
				$motsCles = $http->sessionVariable("sit_mc_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_ouv_annee_".sha1($lienCourant))) {
				$ouvAnnee = $http->sessionVariable("sit_ouv_annee_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_debut_ouv_".sha1($lienCourant))) {
				$debutOuv = $http->sessionVariable("sit_debut_ouv_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_fin_ouv_".sha1($lienCourant))) {
				$finOuv = $http->sessionVariable("sit_fin_ouv_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_debut_dispo_".sha1($lienCourant))) {
				$debutDispo = $http->sessionVariable("sit_debut_dispo_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_duree_dispo_".sha1($lienCourant))) {
				$dureeDispo = $http->sessionVariable("sit_duree_dispo_".sha1($lienCourant));
			}
		}

		if ($saisonId !== null && ($debutOuv == '' || $ouvAnnee)) {
			if ($sitIni->hasVariable('Saisons', 'Printemps') && $saisonId == $sitIni->variable('Saisons','Printemps')) {
				if ($sitIni->hasVariable('Saisons','DebutPrintemps')) {
					$debutOuv=$sitIni->variable('Saisons','DebutPrintemps').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinPrintemps')) {
					$finOuv=$sitIni->variable('Saisons','FinPrintemps').'/'.date('Y');
				}
			}
			if ($sitIni->hasVariable('Saisons', 'Ete') && $saisonId == $sitIni->variable('Saisons','Ete')) {
				if ($sitIni->hasVariable('Saisons','DebutEte')) {
					$debutOuv=$sitIni->variable('Saisons','DebutEte').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinEte')) {
					$finOuv=$sitIni->variable('Saisons','FinEte').'/'.date('Y');
				}
			}
			if ($sitIni->hasVariable('Saisons', 'Automne') && $saisonId == $sitIni->variable('Saisons','Automne')) {
				if ($sitIni->hasVariable('Saisons','DebutAutomne')) {
					$debutOuv=$sitIni->variable('Saisons','DebutAutomne').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinAutomne')) {
					$finOuv=$sitIni->variable('Saisons','FinAutomne').'/'.date('Y');
				}
			}
			if ($sitIni->hasVariable('Saisons', 'Hiver') && $saisonId == $sitIni->variable('Saisons','Hiver')) {
				if ($sitIni->hasVariable('Saisons','DebutHiver')) {
					$debutOuv=$sitIni->variable('Saisons','DebutHiver').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinHiver')) {
					$finOuv=$sitIni->variable('Saisons','FinHiver').'/'.(date('Y')+1);
				}
			}
			if ($debutOuv && $finOuv) {
				$now = time();
				$dateDebutOuv = explode('/', $debutOuv);
				$dateDebutOuv = mktime(0, 0, 0, $dateDebutOuv[1], $dateDebutOuv[0], $dateDebutOuv[2]);
				$dateFinOuv = explode('/', $finOuv);
				$dateFinOuv = mktime(0, 0, 0, $dateFinOuv[1], $dateFinOuv[0], $dateFinOuv[2]);
				if ($now >= $dateDebutOuv && $now <= $dateFinOuv) {
					$debutOuv = date("d/m/Y", $now);
				}
			}
			$http->setSessionVariable("sit_debut_ouv_".sha1($lienCourant), $debutOuv);
			$http->setSessionVariable("sit_fin_ouv_".sha1($lienCourant), $finOuv);
		}

		$sitParamsString = $categorie ? "&idC=".$categorie : "";
		$sitParamsString .= $langue ? "&lang=".$langue : "";

		$sitParamsStringCrypte = sha1("Criteres__".substr($sitParamsString, 1));

		$cheminFichierCacheXml = $cheminCacheXml.$sitParamsStringCrypte.".xml";

		$cacheExpire = true;
		if (file_exists($cheminFichierCacheXml)) {
			$maintenant = time();
			$dateExpirationCache = filemtime($cheminFichierCacheXml)+$dureeVieCache;
			if ($dateExpirationCache > $maintenant) {
				$cacheExpire = false;
			}
		}

		$contenuXmlDistant = "";
		if ($cacheExpire) {
			$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Criteres".$sitParamsString);
			if ($contenuXmlDistant) {
				$contenuXmlCache = utf8_encode(preg_replace("/&([\\w\\d]+|\\#\\d+);/si", "_dw_entity__$1__", $contenuXmlDistant));
				file_put_contents($cheminFichierCacheXml, $contenuXmlCache, LOCK_EX);
			}
		}

		$xsltParemters = array();

		$xsltParemters['saisonId'] = $saisonId;
		$xsltParemters['cheminImages'] = $cheminImages;
		$xsltParemters['cheminImagesDesign'] = $cheminImagesDesign ? $cheminImagesDesign : $cheminImages;
		$xsltParemters['lienCourant'] = $lienCourant;
		$xsltParemters['cheminRacineSite'] = $cheminRacineSite;

		$xsltParemters['pageCourante'] = $pageCourante;

		$xsltParemters['villes'] = utf8_encode($villes);

		$xsltParemters['triEnCours'] = $triEnCours;
		$xsltParemters['rechercheEnCours'] = $rechercheEnCours;
		$xsltParemters['criteresTri'] = "|".implode("|", $criteresTri)."|";
		$xsltParemters['criteresRecherche'] = "|".implode("|", $criteresRecherche)."|";

		$xsltParemters['modalitesRapides'] = "|".str_replace(",", "|", $sitModalitesRapides)."|";
		$xsltParemters['modalitesTexte'] = str_replace(utf8_encode("Â§"), "#", utf8_encode(utf8_encode("|".urldecode($sitModalitesTexte)."|")));
		$xsltParemters['modalitesNum'] = str_replace(utf8_encode("Â§"), "#", utf8_encode(utf8_encode("|".urldecode($sitModalitesNum)."|")));

		$xsltParemters['codesInsee'] = utf8_encode($codesInsee);
		$xsltParemters['motsCles'] = utf8_encode($motsCles);
		$xsltParemters['ouvAnnee'] = utf8_encode($ouvAnnee);
		$xsltParemters['debutOuv'] = utf8_encode($debutOuv);
		$xsltParemters['finOuv'] = utf8_encode($finOuv);
		$xsltParemters['debutDispo'] = utf8_encode($debutDispo);
		$xsltParemters['dureeDispo'] = utf8_encode($dureeDispo);

		foreach ($traductionsStatiques as $traductionStatique) {
			if (ezpI18n::tr("sit/termes/override", $traductionStatique) != $traductionStatique) {
				$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes/override", $traductionStatique));
			} else {
				$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes", $traductionStatique));
			}
		}

		$cheminFichierXsl = $cheminXsl.$xslFile."_".$categorie.".xsl";
		if (!file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl.$xslFile.".xsl";
		}
		if (!file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl."sit_recherche_".$categorie.".xsl";
		}
		if (!file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl."sit_recherche.xsl";
		}

		$contenuBloc = "";
		if (file_exists($cheminFichierCacheXml) && file_exists($cheminFichierXsl)) {
			$contenuBloc = SitUtils::getHtmlResult($cheminFichierCacheXml, $cheminFichierXsl, $xsltParemters);
		}

		$contenuBloc = preg_replace("/&([\\w\\d]+|\\#\\d+);/si", "_dw_entity__$1__", html_entity_decode($contenuBloc));
		$contenuBloc = preg_replace("/&/si", "&amp;", $contenuBloc);
		$contenuBloc = utf8_decode(preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc));
		$contenuBloc = "\n".preg_replace("/(http:\\/\\/[^\\/]+):\\d+/si", "$1", $contenuBloc)."\n";


		return $contenuBloc;
	}

	function sitListeHtml($sitListe, $viewParameters, $lienCourant, $cheminImages, $sitListeUrlAlias, $xslFile, $idFicheEnCours) {
		$http = eZHTTPTool::instance();

		$sitIni = eZINI::instance('ez_aya_sit.ini');

		$cheminImagesDesign = $sitIni->variable('ImagesDesign','Chemin');

		$siteIni = eZINI::instance('site.ini');

		$langue = $siteIni->variable('RegionalSettings','Locale');
		if ($langue) {
			$langue = substr($langue, 0, 2);
		}

		$saisonId = null;
		if ($http->hasSessionVariable('saison')) {
			$saisonId=$http->sessionVariable('saison');
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
			$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
		} else {
			$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XmlCachePath')) {
			$cheminCacheXml = $sitIni->variable('GlobalSitParametersOverride','XmlCachePath');
		} else {
			$cheminCacheXml = $sitIni->variable('GlobalSitParameters','XmlCachePath');
		}
		$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;
		if (!file_exists($cheminCacheXml)) {
			mkdir($cheminCacheXml, 0777, true);
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XslPath')) {
			$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParametersOverride','XslPath');
		} else {
			$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParameters','XslPath');
		}

		$traductionsStatiques = $sitIni->variable('SitTranslations','StaticSitTranslations');
		$traductionsStatiquesComplementaires = array();
		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'StaticSitTranslations')) {
			$traductionsStatiquesComplementaires = $sitIni->variable('GlobalSitParametersOverride','StaticSitTranslations');
		}
		foreach ($traductionsStatiquesComplementaires as $traductionStatiqueComplementaire) {
			if (!in_array($traductionStatiqueComplementaire, $traductionsStatiques)) {
				$traductionsStatiques[] = $traductionStatiqueComplementaire;
			}
		}

		$cheminRacineSite = "/";
		eZURI::transformURI($cheminRacineSite);
		$cheminRacineSite = $cheminRacineSite == "/" ? "" : $cheminRacineSite;

		$categorie = $sitListe['categorie']->value();
		$categorie = $categorie[0];

		$nbItemsParPage = $sitListe['nb_items_par_page']->value();

		$dureeVieCache = $sitListe['duree_vie_cache']->value() * 60;

		$triEnCours = "";
		if (array_key_exists('tri', $viewParameters) && $viewParameters['tri']) {
			$triEnCours = $viewParameters['tri'];
		}

		$rechercheEnCours = "non";
		if (array_key_exists('recherche', $viewParameters) && $viewParameters['recherche']) {
			$rechercheEnCours = $viewParameters['recherche'];
		}

		$pageCourante = "1";
		if (array_key_exists('page', $viewParameters) && $viewParameters['page']) {
			$pageCourante = $viewParameters['page'];
		}

		$sitParams = array();

		$sitParams['dwimg'] = "1";
		$sitParams['dwadd'] = "111";
		$sitParams['dwdate'] = "111";
		$sitParams['dwcom'] = "11111";
		$sitParams['dwlien'] = "1";
		$sitParams['dwref'] = "1";
		if ($langue) {
			$sitParams['lang'] = $langue;
		}

		$entites = $sitListe['entites']->value();
		foreach ($entites as $entite) {
			if ($entite) {
				if (array_key_exists('ide', $sitParams)) {
					$sitParams['ide'] .= ",".$entite;
				} else {
					$sitParams['ide'] = $entite;
				}
			}
		}

		$paysEpci = $sitListe['pays_epci']->value();
		foreach ($paysEpci as $unPaysEpci) {
			if ($unPaysEpci) {
				if (array_key_exists('idp', $sitParams)) {
					$sitParams['idp'] .= ",".$unPaysEpci;
				} else {
					$sitParams['idp'] = $unPaysEpci;
				}
			}
		}

		$criteresAffiches = $sitListe['criteres_affiches']->value();
		foreach ($criteresAffiches as $idCritere) {
			if ($idCritere) {
				if (!array_key_exists('dwcrit', $sitParams) || !preg_match("/(^|\\|)".substr($idCritere, 0, 9)."/", $sitParams['dwcrit'])) {
					if (array_key_exists('dwcrit', $sitParams)) {
						$sitParams['dwcrit'] .= "|".substr($idCritere, 0, 9);
					} else {
						$sitParams['dwcrit'] = substr($idCritere, 0, 9);
					}
				}
			}
		}

		$criteresTriPrincipaux = $sitListe['criteres_tri_principaux']->value();

		$sitParams['sort'] = "pho";
		$sitParams['order'] = "desc";
		foreach ($criteresTriPrincipaux as $critereTri) {
			$idCritereTri = substr($critereTri, 1);
			$sensCritereTri = substr($critereTri, 0, 1);

			if ($idCritereTri == '1') {
				$sitParams['sort'] .= ",com";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri == '2') {
				$sitParams['sort'] .= ",ran";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri == '3') {
				$sitParams['sort'] .= ",nco";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri == '4') {
				$sitParams['sort'] .= ",douv";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri) {
				$sitParams['sort'] .= ",".(strlen($idCritereTri) > 9 ? "m" : (preg_match("/^\\d+$/", $idCritereTri) ? "c" : "")).$idCritereTri;
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			}
		}

		if (array_key_exists('tri', $viewParameters) && $viewParameters['tri']) {
			$tri = explode('~', $viewParameters['tri']);
			$sitParams['sort'] = $tri[0];
			$sitParams['order'] = (count($tri) >= 2 && $tri[1] ? $tri[1] : "asc");
		}

		$sitModalitesRapides = array();
		$sitModalitesTexte = "";
		$sitModalitesNum = "";
		$codesInsee = null;
		$motsCles = null;
		$debutDispo = null;
		$dureeDispo = null;
		$ouvAnnee = null;
		$debutOuv = null;
		$finOuv = null;
		if ($http->hasPostVariable("search_sit")) {
			$rechercheEnCours = "oui";

			if ($http->hasPostVariable("sit_mr")) {
				$sitModalitesRapides = $http->postVariable("sit_mr");
			}

			foreach ($sitModalitesRapides as $idCritere=>$sitModaliteRapide) {
				$sitModalitesRapides[$idCritere] = preg_replace("/(^,|,$)/", "", preg_replace("/,+/", ",", implode(",", $sitModaliteRapide)));
			}

			$sitModalitesRapides = preg_replace("/(^\\||\\|$)/", "", preg_replace("/\\|+/", "|", implode("|", $sitModalitesRapides)));

			$http->setSessionVariable("sit_mr_".sha1($lienCourant), $sitModalitesRapides);

			$sitModalitesTexteNum = array();
			if ($http->hasPostVariable("sit_nrtr")) {
				$sitModalitesTexteNum = $http->postVariable("sit_nrtr");
			}

			foreach ($sitModalitesTexteNum as $idCritere=>$sitModaliteTexteNum) {
				if (trim($sitModaliteTexteNum['val']) != "") {
					if (array_key_exists('ope', $sitModaliteTexteNum)) {
						$sitModalitesNum[$idCritere] = $idCritere.urlencode(utf8_decode('Â§')).$sitModaliteTexteNum['val'].urlencode(utf8_decode('Â§')).$sitModaliteTexteNum['ope'];
					} else {
						echo "toto";
						$sitModalitesTexte[$idCritere] = $idCritere.urlencode(utf8_decode('Â§')).$sitModaliteTexteNum['val'];
					}
				}
			}

			$sitModalitesTexte = preg_replace("/(^\\||\\|$)/", "", preg_replace("/\\|+/", "|", implode("|", $sitModalitesTexte)));
			$sitModalitesNum = preg_replace("/(^\\||\\|$)/", "", preg_replace("/\\|+/", "|", implode("|", $sitModalitesNum)));

			$http->setSessionVariable("sit_tr_".sha1($lienCourant), $sitModalitesTexte);
			$http->setSessionVariable("sit_nr_".sha1($lienCourant), $sitModalitesNum);

			if ($http->hasPostVariable("sit_cinsee")) {
				$codesInsee = join("|", $http->postVariable("sit_cinsee"));
			}

			$http->setSessionVariable("sit_cinsee_".sha1($lienCourant), $codesInsee);

			if ($http->hasPostVariable("sit_mc")) {
				$motsCles = $http->postVariable("sit_mc");
			}

			$http->setSessionVariable("sit_mc_".sha1($lienCourant), $motsCles);

			if ($http->hasPostVariable("sit_ouvert_annee")) {
				$ouvAnnee = $http->postVariable("sit_ouvert_annee");
			}

			$http->setSessionVariable("sit_ouv_annee_".sha1($lienCourant), $ouvAnnee);

			if ($http->hasPostVariable("sit_debut_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_ouv"))) {
					$debutOuv = $http->postVariable("sit_debut_ouv");
				}
			}

			if (!$ouvAnnee) {
				$http->setSessionVariable("sit_debut_ouv_".sha1($lienCourant), $debutOuv);
			} else {
				if ($http->hasSessionVariable("sit_debut_ouv_".sha1($lienCourant))) {
					$debutOuv = $http->sessionVariable("sit_debut_ouv_".sha1($lienCourant));
				}
			}

			if ($http->hasPostVariable("sit_fin_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_fin_ouv"))) {
					$finOuv = $http->postVariable("sit_fin_ouv");
				}
			}

			if (!$ouvAnnee) {
				$http->setSessionVariable("sit_fin_ouv_".sha1($lienCourant), $finOuv);
			} else {
				if ($http->hasSessionVariable("sit_fin_ouv_".sha1($lienCourant))) {
					$finOuv = $http->sessionVariable("sit_fin_ouv_".sha1($lienCourant));
				}
			}

			if ($http->hasPostVariable("sit_debut_dispo")) {
				if (preg_match("/^(((0[1-9]|[12]\\d|3[01])\\/(0[13578]|1[02])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|[12]\\d|30)\\/(0[13456789]|1[012])\\/((19|[2-9]\\d)\\d{2}))|((0[1-9]|1\\d|2[0-8])\\/02\\/((19|[2-9]\\d)\\d{2}))|(29\\/02\\/((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_dispo"))) {
					$debutDispo = $http->postVariable("sit_debut_dispo");
				}
			}

			$http->setSessionVariable("sit_debut_dispo_".sha1($lienCourant), $debutDispo);

			if ($http->hasPostVariable("sit_duree_dispo")) {
				if (preg_match("/^[0-9]+$|^$/", $http->postVariable("sit_duree_dispo")) && $http->postVariable("sit_duree_dispo") > 0) {
					$dureeDispo = $http->postVariable("sit_duree_dispo");
				}
			}

			$http->setSessionVariable("sit_duree_dispo_".sha1($lienCourant), $dureeDispo);
		} else if ($rechercheEnCours == "oui") {
			if ($http->hasSessionVariable("sit_mr_".sha1($lienCourant))) {
				$sitModalitesRapides = $http->sessionVariable("sit_mr_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_tr_".sha1($lienCourant))) {
				$sitModalitesTexte = $http->sessionVariable("sit_tr_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_nr_".sha1($lienCourant))) {
				$sitModalitesNum = $http->sessionVariable("sit_nr_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_cinsee_".sha1($lienCourant))) {
				$codesInsee = $http->sessionVariable("sit_cinsee_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_mc_".sha1($lienCourant))) {
				$motsCles = $http->sessionVariable("sit_mc_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_ouv_annee_".sha1($lienCourant))) {
				$ouvAnnee = $http->sessionVariable("sit_ouv_annee_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_debut_ouv_".sha1($lienCourant))) {
				$debutOuv = $http->sessionVariable("sit_debut_ouv_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_fin_ouv_".sha1($lienCourant))) {
				$finOuv = $http->sessionVariable("sit_fin_ouv_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_debut_dispo_".sha1($lienCourant))) {
				$debutDispo = $http->sessionVariable("sit_debut_dispo_".sha1($lienCourant));
			}
			if ($http->hasSessionVariable("sit_duree_dispo_".sha1($lienCourant))) {
				$dureeDispo = $http->sessionVariable("sit_duree_dispo_".sha1($lienCourant));
			}
		}
		if ($saisonId !== null && ($debutOuv == '' || $ouvAnnee)) {
			if ($sitIni->hasVariable('Saisons', 'Printemps') && $saisonId == $sitIni->variable('Saisons','Printemps')) {
				if ($sitIni->hasVariable('Saisons','DebutPrintemps')) {
					$debutOuv=$sitIni->variable('Saisons','DebutPrintemps').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinPrintemps')) {
					$finOuv=$sitIni->variable('Saisons','FinPrintemps').'/'.date('Y');
				}
			}
			if ($sitIni->hasVariable('Saisons', 'Ete') && $saisonId == $sitIni->variable('Saisons','Ete')) {
				if ($sitIni->hasVariable('Saisons','DebutEte')) {
					$debutOuv=$sitIni->variable('Saisons','DebutEte').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinEte')) {
					$finOuv=$sitIni->variable('Saisons','FinEte').'/'.date('Y');
				}
			}
			if ($sitIni->hasVariable('Saisons', 'Automne') && $saisonId == $sitIni->variable('Saisons','Automne')) {
				if ($sitIni->hasVariable('Saisons','DebutAutomne')) {
					$debutOuv=$sitIni->variable('Saisons','DebutAutomne').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinAutomne')) {
					$finOuv=$sitIni->variable('Saisons','FinAutomne').'/'.date('Y');
				}
			}
			if ($sitIni->hasVariable('Saisons', 'Hiver') && $saisonId == $sitIni->variable('Saisons','Hiver')) {
				if ($sitIni->hasVariable('Saisons','DebutHiver')) {
					$debutOuv=$sitIni->variable('Saisons','DebutHiver').'/'.date('Y');
				}
				if ($sitIni->hasVariable('Saisons','FinHiver')) {
					$finOuv=$sitIni->variable('Saisons','FinHiver').'/'.(date('Y')+1);
				}
			}
			if ($debutOuv && $finOuv) {
				$now = time();
				$dateDebutOuv = explode('/', $debutOuv);
				$dateDebutOuv = mktime(0, 0, 0, $dateDebutOuv[1], $dateDebutOuv[0], $dateDebutOuv[2]);
				$dateFinOuv = explode('/', $finOuv);
				$dateFinOuv = mktime(0, 0, 0, $dateFinOuv[1], $dateFinOuv[0], $dateFinOuv[2]);
				if ($now >= $dateDebutOuv && $now <= $dateFinOuv) {
					$debutOuv = date("d/m/Y", $now);
				}
			}
			$http->setSessionVariable("sit_debut_ouv_".sha1($lienCourant), $debutOuv);
			$http->setSessionVariable("sit_fin_ouv_".sha1($lienCourant), $finOuv);
		}

		if ($sitModalitesRapides) {
			if (array_key_exists('mr2', $sitParams)) {
				$sitParams['mr2'] .= "|".$sitModalitesRapides;
			} else {
				$sitParams['mr2'] = $sitModalitesRapides;
			}
		}

		if ($sitModalitesTexte) {
			if (array_key_exists('tr', $sitParams)) {
				$sitParams['tr'] .= "|".$sitModalitesTexte;
			} else {
				$sitParams['tr'] = $sitModalitesTexte;
			}
		}

		if ($sitModalitesNum) {
			if (array_key_exists('nr', $sitParams)) {
				$sitParams['nr'] .= "|".$sitModalitesNum;
			} else {
				$sitParams['nr'] = $sitModalitesNum;
			}
		}

		if ($codesInsee) {
			$sitParams['cinsee'] = utf8_decode($codesInsee);
		}
		if ($motsCles) {
			$sitParams['mc'] = utf8_decode($motsCles);
		}
		if (!$ouvAnnee) {
			if ($debutOuv) {
				$dateDebutOuv = explode('/', $debutOuv);
				$sitParams['jdo'] = $dateDebutOuv[0];
				$sitParams['mdo'] = $dateDebutOuv[1];
				$sitParams['ado'] = $dateDebutOuv[2];
			}
			if ($finOuv) {
				$dateFinOuv = explode('/', $finOuv);
				$sitParams['jfo'] = $dateFinOuv[0];
				$sitParams['mfo'] = $dateFinOuv[1];
				$sitParams['afo'] = $dateFinOuv[2];
			}
		}
		if ($debutDispo && $dureeDispo) {
			$dateDebutDispo = explode('/', $debutDispo);
			$sitParams['jdd'] = $dateDebutDispo[0];
			$sitParams['mdd'] = $dateDebutDispo[1];
			$sitParams['add'] = $dateDebutDispo[2];
			$dateFinDispo = explode('/', date("d/m/Y", mktime(0, 0, 0, $dateDebutDispo[1], $dateDebutDispo[0], $dateDebutDispo[2]) + $dureeDispo * 24 * 60 * 60));
			$sitParams['jfd'] = $dateFinDispo[0];
			$sitParams['mfd'] = $dateFinDispo[1];
			$sitParams['afd'] = $dateFinDispo[2];
		}

		$parametresDiffusionSupplementaires = $sitListe['parametres_diffusion_supplementaires']->value()->attribute('matrix');
		$parametresDiffusionSupplementaires = $parametresDiffusionSupplementaires['rows']['sequential'];

		foreach ($parametresDiffusionSupplementaires as $parametreDiffusionSupplementaire) {
			$sitParamName = $parametreDiffusionSupplementaire['columns'][0];
			$sitParamValue = $parametreDiffusionSupplementaire['columns'][1];

			if ($sitParamName && $sitParamValue) {
				if (array_key_exists($sitParamName, $sitParams)) {
					$sitParams[$sitParamName] .= (preg_match("{^dwcrit|mr2$}", $sitParamName) ? "|" : (preg_match("{^mc$}", $sitParamName) ? " " : ",")).$sitParamValue;
				} else {
					$sitParams[$sitParamName] = $sitParamValue;
				}
				if ($sitParamName == 'dwcrit') {
					$criteresAffiches = array_merge($criteresAffiches, explode("|", $sitParamValue));
				}
			}
		}

		$sitParamsString = "";
		$sitParamsEncodedString = "";
		foreach ($sitParams as $sitParamName=>$sitParamValue) {
			$sitParamsString .= "&".$sitParamName."=".$sitParamValue;
			$sitParamsEncodedString .= "&".urlencode($sitParamName)."=".urlencode($sitParamValue);
		}

		$sitParamsString .= $categorie ? "&idc=".$categorie : "";
		$sitParamsEncodedString .= $categorie ? "&idc=".$categorie : "";

		$sitParamsStringCrypte = sha1("Recherche__".substr($sitParamsString, 1));

		$cheminFichierCacheXml = $cheminCacheXml.$sitParamsStringCrypte.".xml";

		$cacheExpire = true;
		if (file_exists($cheminFichierCacheXml)) {
			$maintenant = time();
			$dateExpirationCache = filemtime($cheminFichierCacheXml)+$dureeVieCache;
			if ($dateExpirationCache > $maintenant) {
				$cacheExpire = false;
			}
		}
		$contenuXmlDistant = "";
		if ($cacheExpire) {
			$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Recherche".$sitParamsEncodedString, 120);
			if ($contenuXmlDistant) {
				$contenuXmlCache = utf8_encode(preg_replace("/&([\\w\\d]+|\\#\\d+);/si", "_dw_entity__$1__", $contenuXmlDistant));
				file_put_contents($cheminFichierCacheXml, $contenuXmlCache, LOCK_EX);
			}
		}

		eZLog::write($rootSitUrl."Recherche".$sitParamsString, "ez_aya_sit.log");

		$sitParamsString .= "&num=1";
		$sitParamsEncodedString .= "&num=1";

		$sitParamsStringCrypte = sha1("Recherche__".substr($sitParamsString, 1));

		$cheminFichierCacheXmlNbProduits = $cheminCacheXml.$sitParamsStringCrypte.".xml";

		$cacheExpire = true;
		if (file_exists($cheminFichierCacheXmlNbProduits)) {
			$maintenant = time();
			$dateExpirationCache = filemtime($cheminFichierCacheXmlNbProduits)+$dureeVieCache;
			if ($dateExpirationCache > $maintenant) {
				$cacheExpire = false;
			}
		}
		$contenuXmlDistant = "";
		if ($cacheExpire) {
			$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl."Recherche".$sitParamsEncodedString);
			if ($contenuXmlDistant) {
				$contenuXmlCache = utf8_encode($contenuXmlDistant);
				file_put_contents($cheminFichierCacheXmlNbProduits, $contenuXmlCache, LOCK_EX);
			}
		}

		$cheminFichierXsl = $cheminXsl."sit_nb_produits.xsl";

		$xsltParemters = array();
		$xsltParemters['nbPages'] = "1";
		$nbResultatsTotal = "0";
		if (file_exists($cheminFichierCacheXmlNbProduits) && file_exists($cheminFichierXsl)) {
			$nbResultatsTotal = trim(SitUtils::getHtmlResult($cheminFichierCacheXmlNbProduits, $cheminFichierXsl));
			$xsltParemters['nbPages'] = ceil($nbItemsParPage > 0 ? $nbResultatsTotal/$nbItemsParPage : 1);
		}

		$xsltParemters['saisonId'] = $saisonId;
		$xsltParemters['cheminImages'] = $cheminImages;
		$xsltParemters['cheminImagesDesign'] = $cheminImagesDesign ? $cheminImagesDesign : $cheminImages;
		$xsltParemters['lienCourant'] = $lienCourant;
		$xsltParemters['cheminRacineSite'] = $cheminRacineSite;
		$xsltParemters['sitListeUrlAlias'] = str_replace("/", "~", $sitListeUrlAlias);
		eZURI::transformURI($sitListeUrlAlias);
		$xsltParemters['sitListeLien'] = $sitListeUrlAlias;

		$xsltParemters['idFicheEnCours'] = $idFicheEnCours;

		$xsltParemters['nbItemsParPage'] = $nbItemsParPage;
		$xsltParemters['nbResultatsTotal'] = $nbResultatsTotal;
		$xsltParemters['pageCourante'] = $pageCourante;

		$xsltParemters['triEnCours'] = $triEnCours;
		$xsltParemters['rechercheEnCours'] = $rechercheEnCours;
		$xsltParemters['criteresAffiches'] = "|".implode("|", $criteresAffiches)."|";

		$xsltParemters['caracteresKo'] = utf8_encode("Å Å’Å½Å¸Â¥ÂµÃ€Ã�Ã‚ÃƒÃ„Ã…Ã†Ã‡ÃˆÃ‰ÃŠÃ‹ÃŒÃ�ÃŽÃ�Ã�Ã‘Ã’Ã“Ã”Ã•Ã–Ã˜Ã™ÃšÃ›ÃœÃ�ÃŸ");
		$xsltParemters['caracteresOk'] = utf8_encode("Å¡Å“Å¾Ã¿Â¥ÂµÃ Ã¡Ã¢Ã£Ã¤Ã¥Ã¦Ã§Ã¨Ã©ÃªÃ«Ã¬Ã­Ã®Ã¯Ã°Ã±Ã²Ã³Ã´ÃµÃ¶Ã¸Ã¹ÃºÃ»Ã¼Ã½ÃŸ");

		$xsltParemters['langue'] = $langue;

		foreach ($traductionsStatiques as $traductionStatique) {
			if (ezpI18n::tr("sit/termes/override", $traductionStatique) != $traductionStatique) {
				$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes/override", $traductionStatique));
			} else {
				$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes", $traductionStatique));
			}
		}

		$cheminFichierXsl = $cheminXsl.$xslFile."_".$categorie.".xsl";
		if (!file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl.$xslFile.".xsl";
		}
		if (!file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl."sit_liste_".$categorie.".xsl";
		}
		if (!file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl."sit_liste.xsl";
		}

		$contenuBloc = "";
		if (file_exists($cheminFichierCacheXml) && file_exists($cheminFichierXsl)) {
			$contenuBloc = SitUtils::getHtmlResult($cheminFichierCacheXml, $cheminFichierXsl, $xsltParemters);
		}

		$contenuBloc = preg_replace("/_dw_entity__#13__\n/si", " ", $contenuBloc);
		$contenuBloc = utf8_decode(preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc));
		$contenuBloc = preg_replace("/&amp;([\\w\\d]+|\\#\\d+);/si", "&$1;", html_entity_decode($contenuBloc));
		$contenuBloc = "\n".preg_replace("/(http:\\/\\/[^\\/]+):\\d+/si", "$1", $contenuBloc)."\n";

		return $contenuBloc;
	}

	function sitMiseEnAvantHtml($sitMiseEnAvant, $viewParameters, $lienCourant, $cheminImages, $sitMiseEnAvantUrlAlias, $xslFile) {
		$http = eZHTTPTool::instance();

		$sitIni = eZINI::instance('ez_aya_sit.ini');

		$cheminImagesDesign = $sitIni->variable('ImagesDesign','Chemin');

		$siteIni = eZINI::instance('site.ini');

		$langue = $siteIni->variable('RegionalSettings','Locale');
		if ($langue) {
			$langue = substr($langue, 0, 2);
		}

		$saisonId = null;
		if ($http->hasSessionVariable('saison')) {
			$saisonId=$http->sessionVariable('saison');
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
			$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
		} else {
			$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XmlCachePath')) {
			$cheminCacheXml = $sitIni->variable('GlobalSitParametersOverride','XmlCachePath');
		} else {
			$cheminCacheXml = $sitIni->variable('GlobalSitParameters','XmlCachePath');
		}
		$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;
		if (!file_exists($cheminCacheXml)) {
			mkdir($cheminCacheXml, 0777, true);
		}

		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'XslPath')) {
			$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParametersOverride','XslPath');
		} else {
			$cheminXsl = $_SERVER['DOCUMENT_ROOT']."/".$sitIni->variable('GlobalSitParameters','XslPath');
		}

		$traductionsStatiques = $sitIni->variable('SitTranslations','StaticSitTranslations');
		$traductionsStatiquesComplementaires = array();
		if ($sitIni->hasVariable('GlobalSitParametersOverride', 'StaticSitTranslations')) {
			$traductionsStatiquesComplementaires = $sitIni->variable('GlobalSitParametersOverride','StaticSitTranslations');
		}
		foreach ($traductionsStatiquesComplementaires as $traductionStatiqueComplementaire) {
			if (!in_array($traductionStatiqueComplementaire, $traductionsStatiques)) {
				$traductionsStatiques[] = $traductionStatiqueComplementaire;
			}
		}

		$cheminRacineSite = "/";
		eZURI::transformURI($cheminRacineSite);
		$cheminRacineSite = $cheminRacineSite == "/" ? "" : $cheminRacineSite;

		$modeAffichage = $sitMiseEnAvant['mode_affichage']->value();
		$modeAffichage = $modeAffichage[0];

		$categorie = $sitMiseEnAvant['categorie']->value();
		$categorie = $categorie[0];

		$nbItems = $sitMiseEnAvant['nb_items']->value();

		$dureeVieCache = $sitMiseEnAvant['duree_vie_cache']->value() * 60;

		$sitParams = array();

		$sitParams['dwimg'] = "1";
		$sitParams['dwadd'] = "111";
		$sitParams['dwdate'] = "111";
		$sitParams['dwcom'] = "11111";
		$sitParams['dwlien'] = "1";
		$sitParams['dwref'] = "1";
		if ($langue) {
			$sitParams['lang'] = $langue;
		}

		$entites = $sitMiseEnAvant['entites']->value();
		foreach ($entites as $entite) {
			if ($entite) {
				if (array_key_exists('ide', $sitParams)) {
					$sitParams['ide'] .= ",".$entite;
				} else {
					$sitParams['ide'] = $entite;
				}
			}
		}

		$paysEpci = $sitMiseEnAvant['pays_epci']->value();
		foreach ($paysEpci as $unPaysEpci) {
			if ($unPaysEpci) {
				if (array_key_exists('idp', $sitParams)) {
					$sitParams['idp'] .= ",".$unPaysEpci;
				} else {
					$sitParams['idp'] = $unPaysEpci;
				}
			}
		}

		if ($sitMiseEnAvant['filtrer_sur_saison']->value()) {
			$debutOuv = null;
			$finOuv = null;
			if ($saisonId !== null) {
				if ($sitIni->hasVariable('Saisons', 'Printemps') && $saisonId == $sitIni->variable('Saisons','Printemps')) {
					if ($sitIni->hasVariable('Saisons','DebutPrintemps')) {
						$debutOuv=$sitIni->variable('Saisons','DebutPrintemps').'/'.date('Y');
					}
					if ($sitIni->hasVariable('Saisons','FinPrintemps')) {
						$finOuv=$sitIni->variable('Saisons','FinPrintemps').'/'.date('Y');
					}
				}
				if ($sitIni->hasVariable('Saisons', 'Ete') && $saisonId == $sitIni->variable('Saisons','Ete')) {
					if ($sitIni->hasVariable('Saisons','DebutEte')) {
						$debutOuv=$sitIni->variable('Saisons','DebutEte').'/'.date('Y');
					}
					if ($sitIni->hasVariable('Saisons','FinEte')) {
						$finOuv=$sitIni->variable('Saisons','FinEte').'/'.date('Y');
					}
				}
				if ($sitIni->hasVariable('Saisons', 'Automne') && $saisonId == $sitIni->variable('Saisons','Automne')) {
					if ($sitIni->hasVariable('Saisons','DebutAutomne')) {
						$debutOuv=$sitIni->variable('Saisons','DebutAutomne').'/'.date('Y');
					}
					if ($sitIni->hasVariable('Saisons','FinAutomne')) {
						$finOuv=$sitIni->variable('Saisons','FinAutomne').'/'.date('Y');
					}
				}
				if ($sitIni->hasVariable('Saisons', 'Hiver') && $saisonId == $sitIni->variable('Saisons','Hiver')) {
					if ($sitIni->hasVariable('Saisons','DebutHiver')) {
						$debutOuv=$sitIni->variable('Saisons','DebutHiver').'/'.date('Y');
					}
					if ($sitIni->hasVariable('Saisons','FinHiver')) {
						$finOuv=$sitIni->variable('Saisons','FinHiver').'/'.(date('Y')+1);
					}
				}
				if ($debutOuv && $finOuv) {
					$now = time();
					$dateDebutOuv = explode('/', $debutOuv);
					$dateDebutOuv = mktime(0, 0, 0, $dateDebutOuv[1], $dateDebutOuv[0], $dateDebutOuv[2]);
					$dateFinOuv = explode('/', $finOuv);
					$dateFinOuv = mktime(0, 0, 0, $dateFinOuv[1], $dateFinOuv[0], $dateFinOuv[2]);
					if ($now >= $dateDebutOuv && $now <= $dateFinOuv) {
						$debutOuv = date("d/m/Y", $now);
					}
				}
			}

			if ($debutOuv) {
				$dateDebutOuv = explode('/', $debutOuv);
				$sitParams['jdo'] = $dateDebutOuv[0];
				$sitParams['mdo'] = $dateDebutOuv[1];
				$sitParams['ado'] = $dateDebutOuv[2];
			}
			if ($finOuv) {
				$dateFinOuv = explode('/', $finOuv);
				$sitParams['jfo'] = $dateFinOuv[0];
				$sitParams['mfo'] = $dateFinOuv[1];
				$sitParams['afo'] = $dateFinOuv[2];
			}
		}

		$criteresAffiches = $sitMiseEnAvant['criteres_affiches']->value();
		foreach ($criteresAffiches as $idCritere) {
			if ($idCritere) {
				if (!array_key_exists('dwcrit', $sitParams) || !preg_match("/(^|\\|)".substr($idCritere, 0, 9)."/", $sitParams['dwcrit'])) {
					if (array_key_exists('dwcrit', $sitParams)) {
						$sitParams['dwcrit'] .= "|".substr($idCritere, 0, 9);
					} else {
						$sitParams['dwcrit'] = substr($idCritere, 0, 9);
					}
				}
			}
		}

		$criteresTriPrincipaux = $sitMiseEnAvant['criteres_tri_principaux']->value();

		$sitParams['sort'] = "pho";
		$sitParams['order'] = "desc";
		foreach ($criteresTriPrincipaux as $critereTri) {
			$idCritereTri = substr($critereTri, 1);
			$sensCritereTri = substr($critereTri, 0, 1);

			if ($idCritereTri == '1') {
				$sitParams['sort'] .= ",com";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri == '2') {
				$sitParams['sort'] .= ",ran";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri == '3') {
				$sitParams['sort'] .= ",nco";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri == '4') {
				$sitParams['sort'] .= ",douv";
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			} else if ($idCritereTri) {
				$sitParams['sort'] .= ",".(strlen($idCritereTri) > 9 ? "m" : (preg_match("/^\\d+$/", $idCritereTri) ? "c" : "")).$idCritereTri;
				$sitParams['order'] .= ",".($sensCritereTri == 'd' ? "desc" : "asc");
			}
		}

		$parametresDiffusionSupplementaires = $sitMiseEnAvant['parametres_diffusion_supplementaires']->value()->attribute('matrix');
		$parametresDiffusionSupplementaires = $parametresDiffusionSupplementaires['rows']['sequential'];

		foreach ($parametresDiffusionSupplementaires as $parametreDiffusionSupplementaire) {
			$sitParamName = $parametreDiffusionSupplementaire['columns'][0];
			$sitParamValue = $parametreDiffusionSupplementaire['columns'][1];

			if ($sitParamName && $sitParamValue) {
				if (array_key_exists($sitParamName, $sitParams)) {
					$sitParams[$sitParamName] .= (preg_match("{^dwcrit|mr2$}", $sitParamName) ? "|" : (preg_match("{^mc$}", $sitParamName) ? " " : ",")).$sitParamValue;
				} else {
					$sitParams[$sitParamName] = $sitParamValue;
				}
				if ($sitParamName == 'dwcrit') {
					$criteresAffiches = array_merge($criteresAffiches, explode("|", $sitParamValue));
				}
			}
		}

		$sitParams['nbr'] = $nbItems;
		$sitParams['ofs'] = '0';

		// Ajout pour récupérer une fiche depuis son ID
		$compSitUrl = "Recherche";
		$idProduit = $sitMiseEnAvant['id_produit']->value();
		if(!is_nan($idProduit) && $idProduit != "" && $idProduit != 0){
			$sitParams['idP'] = $idProduit;
			$compSitUrl = "Produit";
		}

		$sitParamsString = "";
		$sitParamsEncodedString = "";
		foreach ($sitParams as $sitParamName=>$sitParamValue) {
			$sitParamsString .= "&".$sitParamName."=".$sitParamValue;
			$sitParamsEncodedString .= "&".urlencode($sitParamName)."=".urlencode($sitParamValue);
		}

		$sitParamsString .= $categorie ? "&idc=".$categorie : "";
		$sitParamsEncodedString .= $categorie ? "&idc=".$categorie : "";

		$sitParamsStringCrypte = sha1("Recherche__".substr($sitParamsString, 1));

		$cheminFichierCacheXml = $cheminCacheXml.$sitParamsStringCrypte.".xml";

		$cacheExpire = true;
		if (file_exists($cheminFichierCacheXml)) {
			$maintenant = time();
			$dateExpirationCache = filemtime($cheminFichierCacheXml)+$dureeVieCache;
			if ($dateExpirationCache > $maintenant) {
				$cacheExpire = false;
			}
		}
		$contenuXmlDistant = "";
		if ($cacheExpire) {
			$contenuXmlDistant = SitUtils::urlGetContentsCurl($rootSitUrl.$compSitUrl.$sitParamsEncodedString, 120);
			if ($contenuXmlDistant) {
				$contenuXmlCache = utf8_encode(preg_replace("/&([\\w\\d]+|\\#\\d+);/si", "_dw_entity__$1__", $contenuXmlDistant));
				file_put_contents($cheminFichierCacheXml, $contenuXmlCache, LOCK_EX);
			}
		}

		eZLog::write($rootSitUrl.$compSitUrl.$sitParamsString, "ez_aya_sit.log");

		$xsltParemters = array();

		$xsltParemters['lienCourant'] = $lienCourant;
		$xsltParemters['cheminImages'] = $cheminImages;
		$xsltParemters['cheminImagesDesign'] = $cheminImagesDesign ? $cheminImagesDesign : $cheminImages;
		$xsltParemters['cheminRacineSite'] = $cheminRacineSite;
		$xsltParemters['sitMiseEnAvantUrlAlias'] = str_replace("/", "~", $sitMiseEnAvantUrlAlias);
		eZURI::transformURI($sitMiseEnAvantUrlAlias);
		$xsltParemters['sitListeUrlAlias'] = $sitMiseEnAvantUrlAlias;

		$pageCourante = "1";
		if (array_key_exists('page', $viewParameters) && $viewParameters['page']) {
			$pageCourante = $viewParameters['page'];
		}
		$xsltParemters['pageCourante'] = $pageCourante;

		$triEnCours = "";
		if (array_key_exists('tri', $viewParameters) && $viewParameters['tri']) {
			$triEnCours = $viewParameters['tri'];
		}
		$xsltParemters['triEnCours'] = $triEnCours;

		$rechercheEnCours = "non";
		if (array_key_exists('recherche', $viewParameters) && $viewParameters['recherche']) {
			$rechercheEnCours = $viewParameters['recherche'];
		}
		$xsltParemters['rechercheEnCours'] = $rechercheEnCours;

		$xsltParemters['criteresAffiches'] = "|".implode("|", $criteresAffiches)."|";

		$xsltParemters['caracteresKo'] = utf8_encode("Å Å’Å½Å¸Â¥ÂµÃ€Ã�Ã‚ÃƒÃ„Ã…Ã†Ã‡ÃˆÃ‰ÃŠÃ‹ÃŒÃ�ÃŽÃ�Ã�Ã‘Ã’Ã“Ã”Ã•Ã–Ã˜Ã™ÃšÃ›ÃœÃ�ÃŸ");
		$xsltParemters['caracteresOk'] = utf8_encode("Å¡Å“Å¾Ã¿Â¥ÂµÃ Ã¡Ã¢Ã£Ã¤Ã¥Ã¦Ã§Ã¨Ã©ÃªÃ«Ã¬Ã­Ã®Ã¯Ã°Ã±Ã²Ã³Ã´ÃµÃ¶Ã¸Ã¹ÃºÃ»Ã¼Ã½ÃŸ");

		$xsltParemters['langue'] = $langue;

		foreach ($traductionsStatiques as $traductionStatique) {
			if (ezpI18n::tr("sit/termes/override", $traductionStatique) != $traductionStatique) {
				$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes/override", $traductionStatique));
			} else {
				$xsltParemters['terme'.$traductionStatique] = utf8_encode(ezpI18n::tr("sit/termes", $traductionStatique));
			}
		}

		// On ajoute la possibilité d'ouvrir des urls vers des sites externes
		if ($sitIni->hasVariable('SiteExterne','Url_site')) {
			$urlexterne=$sitIni->variable('SiteExterne','Url_site');
			$xsltParemters['UrlExterne'] = $urlexterne;
		}

		$cheminFichierXsl = "";
		if ($xslFile) {
			$cheminFichierXsl = $cheminXsl.$xslFile."_".$categorie.".xsl";
			if (!file_exists($cheminFichierXsl)) {
				$cheminFichierXsl = $cheminXsl.$xslFile.".xsl";
			}
			if (!file_exists($cheminFichierXsl)) {
				$cheminFichierXsl = "";
			}
		}
		if ((!$cheminFichierXsl || !file_exists($cheminFichierXsl)) && $modeAffichage) {
			$cheminFichierXsl = $cheminXsl."sit_mise_en_avant_mode".$modeAffichage."_".$categorie.".xsl";
		}
		if ((!$cheminFichierXsl || !file_exists($cheminFichierXsl)) && $modeAffichage) {
			$cheminFichierXsl = $cheminXsl."sit_mise_en_avant_mode".$modeAffichage.".xsl";
		}
		if (!$cheminFichierXsl || !file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl."sit_mise_en_avant_".$categorie.".xsl";
		}
		if (!$cheminFichierXsl || !file_exists($cheminFichierXsl)) {
			$cheminFichierXsl = $cheminXsl."sit_mise_en_avant.xsl";
		}

		$contenuBloc = "";
		if (file_exists($cheminFichierCacheXml) && file_exists($cheminFichierXsl)) {
			$contenuBloc = SitUtils::getHtmlResult($cheminFichierCacheXml, $cheminFichierXsl, $xsltParemters);
		}

		$contenuBloc = preg_replace("/_dw_entity__#13__\n/si", " ", $contenuBloc);
		$contenuBloc = utf8_decode(preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc));
		$contenuBloc = preg_replace("/&amp;([\\w\\d]+|\\#\\d+);/si", "&$1;", html_entity_decode($contenuBloc));
		$contenuBloc = "\n".preg_replace("/(http:\\/\\/[^\\/]+):\\d+/si", "$1", $contenuBloc)."\n";

		return $contenuBloc;
	}
}

?>
