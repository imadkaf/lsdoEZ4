<?php

require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

class eZSitOperators {
	/*!
	Constructor
	*/
	function eZSitOperators() {
		$this->Operators = array(
			'sit_liste',
			'sit_recherche'
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
			)
		);
	}

	/*!
	Executes the needed operator(s).
	Checks operator names, and calls the appropriate functions.
	*/
	function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters) {
		$currentNode = $tpl->variable('node');
		if (!$currentNode) {
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
		if (!$currentNode) {
			$currentNode = $tpl->variable('previousNode');
		}
		switch ($operatorName) {
			case 'sit_liste':
				$operatorValue = $currentNode ? $this->sitListe($currentNode, $tpl->variable('view_parameters'), eZURLOperator::eZImage($tpl, 'sit/', ''), $namedParameters['xslFile'] ? $namedParameters['xslFile'] : 'sit_liste') : "";
				break;
			case 'sit_recherche':
				$operatorValue = $currentNode ? $this->sitRecherche($currentNode, $tpl->variable('view_parameters'), eZURLOperator::eZImage($tpl, 'sit/', ''), $namedParameters['xslFile'] ? $namedParameters['xslFile'] : 'sit_recherche') : "";
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

	function sitListe($currentNode, $viewParameters, $cheminImages, $xslFile) {
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

		return $this->sitListeHtml($sitListe->dataMap(), $viewParameters, $lienCourant, $cheminImages, $currentNode->attribute('url_alias'), $xslFile);
	}

	// Private section
	var $Operators;

	function sitRechercheHtml($sitListe, $viewParameters, $lienCourant, $cheminImages, $xslFile) {
		$http = eZHTTPTool::instance();

		$sitIni = eZINI::instance('ez_aya_sit.ini');

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
		$currentDirectory = $_SERVER['DOCUMENT_ROOT'];
		foreach (explode("/", $cheminCacheXml) as $cheminCacheXmlPart) {
			$currentDirectory .= "/".$cheminCacheXmlPart;
			if ($cheminCacheXmlPart && !file_exists($currentDirectory)) {
				mkdir($currentDirectory);
			}
		}
		$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;

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
		$motsCles = null;
		$debutDispo = null;
		$dureeDispo = null;
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

			$sitModalitesRapides = preg_replace("/(^\||\|$)/", "", preg_replace("/\|+/", "|", implode("|", $sitModalitesRapides)));

			$http->setSessionVariable(sha1("sit_mr_".$lienCourant), $sitModalitesRapides);

			if ($http->hasPostVariable("sit_mc")) {
				$motsCles = $http->postVariable("sit_mc");
			}

			$http->setSessionVariable(sha1("sit_mc_".$lienCourant), $motsCles);

			if ($http->hasPostVariable("sit_debut_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_ouv"))) {
					$debutOuv = $http->postVariable("sit_debut_ouv");
				}
			}

			$http->setSessionVariable(sha1("sit_debut_ouv_".$lienCourant), $debutOuv);

			if ($http->hasPostVariable("sit_fin_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_fin_ouv"))) {
					$finOuv = $http->postVariable("sit_fin_ouv");
				}
			}

			$http->setSessionVariable(sha1("sit_fin_ouv_".$lienCourant), $finOuv);

			if ($http->hasPostVariable("sit_debut_dispo")) {
				if (preg_match("/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_dispo"))) {
					$debutDispo = $http->postVariable("sit_debut_dispo");
				}
			}

			$http->setSessionVariable(sha1("sit_debut_dispo_".$lienCourant), $debutDispo);

			if ($http->hasPostVariable("sit_duree_dispo")) {
				if (preg_match("/^[0-9]+$|^$/", $http->postVariable("sit_duree_dispo")) && $http->postVariable("sit_duree_dispo") > 0) {
					$dureeDispo = $http->postVariable("sit_duree_dispo");
				}
			}

			$http->setSessionVariable(sha1("sit_duree_dispo_".$lienCourant), $dureeDispo);
		} else if ($rechercheEnCours == "oui") {
			if ($http->hasSessionVariable(sha1("sit_mr_".$lienCourant))) {
				$sitModalitesRapides = $http->sessionVariable(sha1("sit_mr_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_mc_".$lienCourant))) {
				$motsCles = $http->sessionVariable(sha1("sit_mc_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_debut_ouv_".$lienCourant))) {
				$debutOuv = $http->sessionVariable(sha1("sit_debut_ouv_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_fin_ouv_".$lienCourant))) {
				$finOuv = $http->sessionVariable(sha1("sit_fin_ouv_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_debut_dispo_".$lienCourant))) {
				$debutDispo = $http->sessionVariable(sha1("sit_debut_dispo_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_duree_dispo_".$lienCourant))) {
				$dureeDispo = $http->sessionVariable(sha1("sit_duree_dispo_".$lienCourant));
			}
		}

		$sitParamsString = $categorie ? "&idC=".$categorie : "";

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
				$contenuXmlCache = utf8_encode(str_replace("&#128;", "__euro__", $contenuXmlDistant));
				file_put_contents($cheminFichierCacheXml, $contenuXmlCache, LOCK_EX);
			}
		}

		$xsltParemters = array();

		$xsltParemters['lienCourant'] = $lienCourant;
		$xsltParemters['cheminImages'] = $cheminImages;
		$xsltParemters['cheminRacineSite'] = $cheminRacineSite;

		$xsltParemters['pageCourante'] = $pageCourante;

		$xsltParemters['triEnCours'] = $triEnCours;
		$xsltParemters['rechercheEnCours'] = $rechercheEnCours;
		$xsltParemters['criteresTri'] = "|".implode("|", $criteresTri)."|";
		$xsltParemters['criteresRecherche'] = "|".implode("|", $criteresRecherche)."|";

		$xsltParemters['modalitesRapides'] = "|".str_replace(",", "|", $sitModalitesRapides)."|";
		$xsltParemters['motsCles'] = utf8_encode($motsCles);
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

		$contenuBloc = preg_replace("/&([\w\d]+|\#\d+);/si", "_dw_entity__$1__", html_entity_decode($contenuBloc));
		$contenuBloc = preg_replace("/&/si", "&amp;", $contenuBloc);
		$contenuBloc = preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc);
		$contenuBloc = preg_replace("/(http:\/\/[^\/]+):\d+/si", "$1", $contenuBloc);
		$contenuBloc = "\n".preg_replace("/  /si", "\t", utf8_decode(str_replace("__euro__", "&euro;", $contenuBloc)))."\n";

		return $contenuBloc;
	}

	function sitListeHtml($sitListe, $viewParameters, $lienCourant, $cheminImages, $sitListeUrlAlias, $xslFile) {
		$http = eZHTTPTool::instance();

		$sitIni = eZINI::instance('ez_aya_sit.ini');

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
		$currentDirectory = $_SERVER['DOCUMENT_ROOT'];
		foreach (explode("/", $cheminCacheXml) as $cheminCacheXmlPart) {
			$currentDirectory .= "/".$cheminCacheXmlPart;
			if ($cheminCacheXmlPart && !file_exists($currentDirectory)) {
				mkdir($currentDirectory);
			}
		}
		$cheminCacheXml = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheXml;

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
				if (!array_key_exists('dwcrit', $sitParams) || !preg_match("/(^|\|)".substr($idCritere, 0, 9)."/", $sitParams['dwcrit'])) {
					if (array_key_exists('dwcrit', $sitParams)) {
						$sitParams['dwcrit'] .= "|".substr($idCritere, 0, 9);
					} else {
						$sitParams['dwcrit'] = substr($idCritere, 0, 9);
					}
				}
			}
		}

		$critereTriPrincipal = $sitListe['critere_tri_principal']->value();
		$critereTriPrincipal = $critereTriPrincipal[0];

		$sensTriPrincipal = $sitListe['sens_tri_principal']->value();
		$sensTriPrincipal = $sensTriPrincipal[0];

		$sitParams['sort'] = "pho";
		$sitParams['order'] = "desc";
		if ($critereTriPrincipal == '1') {
			$sitParams['sort'] .= ",com";
			$sitParams['order'] .= ",".($sensTriPrincipal == '1' ? "desc" : "asc");
		} else if ($critereTriPrincipal == '2') {
			$sitParams['sort'] .= ",ran";
			$sitParams['order'] .= ",".($sensTriPrincipal == '1' ? "desc" : "asc");
		} else if ($critereTriPrincipal) {
			$sitParams['sort'] .= ",".(strlen($critereTriPrincipal) > 9 ? "m" : (preg_match("/^\d+$/", $critereTriPrincipal) ? "c" : "")).$critereTriPrincipal;
			$sitParams['order'] .= ",".($sensTriPrincipal == '1' ? "desc" : "asc");
		}

		if (array_key_exists('tri', $viewParameters) && $viewParameters['tri']) {
			$tri = explode('~', $viewParameters['tri']);
			$sitParams['sort'] = $tri[0];
			$sitParams['order'] = (count($tri) >= 2 && $tri[1] ? $tri[1] : "asc");
		}

		$sitModalitesRapides = array();
		$motsCles = null;
		$debutDispo = null;
		$dureeDispo = null;
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

			$sitModalitesRapides = preg_replace("/(^\||\|$)/", "", preg_replace("/\|+/", "|", implode("|", $sitModalitesRapides)));

			$http->setSessionVariable(sha1("sit_mr_".$lienCourant), $sitModalitesRapides);

			if ($http->hasPostVariable("sit_mc")) {
				$motsCles = $http->postVariable("sit_mc");
			}

			$http->setSessionVariable(sha1("sit_mc_".$lienCourant), $motsCles);

			if ($http->hasPostVariable("sit_debut_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_ouv"))) {
					$debutOuv = $http->postVariable("sit_debut_ouv");
				}
			}

			$http->setSessionVariable(sha1("sit_debut_ouv_".$lienCourant), $debutOuv);

			if ($http->hasPostVariable("sit_fin_ouv")) {
				if (preg_match("/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_fin_ouv"))) {
					$finOuv = $http->postVariable("sit_fin_ouv");
				}
			}

			$http->setSessionVariable(sha1("sit_fin_ouv_".$lienCourant), $finOuv);

			if ($http->hasPostVariable("sit_debut_dispo")) {
				if (preg_match("/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$|^$/", $http->postVariable("sit_debut_dispo"))) {
					$debutDispo = $http->postVariable("sit_debut_dispo");
				}
			}

			$http->setSessionVariable(sha1("sit_debut_dispo_".$lienCourant), $debutDispo);

			if ($http->hasPostVariable("sit_duree_dispo")) {
				if (preg_match("/^[0-9]+$|^$/", $http->postVariable("sit_duree_dispo")) && $http->postVariable("sit_duree_dispo") > 0) {
					$dureeDispo = $http->postVariable("sit_duree_dispo");
				}
			}

			$http->setSessionVariable(sha1("sit_duree_dispo_".$lienCourant), $dureeDispo);
		} else if ($rechercheEnCours == "oui") {
			if ($http->hasSessionVariable(sha1("sit_mr_".$lienCourant))) {
				$sitModalitesRapides = $http->sessionVariable(sha1("sit_mr_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_mc_".$lienCourant))) {
				$motsCles = $http->sessionVariable(sha1("sit_mc_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_debut_ouv_".$lienCourant))) {
				$debutOuv = $http->sessionVariable(sha1("sit_debut_ouv_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_fin_ouv_".$lienCourant))) {
				$finOuv = $http->sessionVariable(sha1("sit_fin_ouv_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_debut_dispo_".$lienCourant))) {
				$debutDispo = $http->sessionVariable(sha1("sit_debut_dispo_".$lienCourant));
			}
			if ($http->hasSessionVariable(sha1("sit_duree_dispo_".$lienCourant))) {
				$dureeDispo = $http->sessionVariable(sha1("sit_duree_dispo_".$lienCourant));
			}
		}

		if ($sitModalitesRapides) {
			if (array_key_exists('mr2', $sitParams)) {
				$sitParams['mr2'] .= "|".$sitModalitesRapides;
			} else {
				$sitParams['mr2'] = $sitModalitesRapides;
			}
		}
		if ($motsCles) {
			$sitParams['mc'] = utf8_decode($motsCles);
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
				$contenuXmlCache = utf8_encode(str_replace("&#128;", "__euro__", $contenuXmlDistant));
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

		$xsltParemters['lienCourant'] = $lienCourant;
		$xsltParemters['cheminImages'] = $cheminImages;
		$xsltParemters['cheminRacineSite'] = $cheminRacineSite;
		$xsltParemters['sitListeUrlAlias'] = str_replace("/", "~", $sitListeUrlAlias);

		$xsltParemters['nbItemsParPage'] = $nbItemsParPage;
		$xsltParemters['nbResultatsTotal'] = $nbResultatsTotal;
		$xsltParemters['pageCourante'] = $pageCourante;

		$xsltParemters['triEnCours'] = $triEnCours;
		$xsltParemters['rechercheEnCours'] = $rechercheEnCours;
		$xsltParemters['criteresAffiches'] = "|".implode("|", $criteresAffiches)."|";

		$xsltParemters['caracteresKo'] = utf8_encode("ŠŒŽŸ¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß");
		$xsltParemters['caracteresOk'] = utf8_encode("šœžÿ¥µàáâãäåæçèéêëìíîïðñòóôõöøùúûüýß");

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

		$contenuBloc = preg_replace("/&([\w\d]+|\#\d+);/si", "_dw_entity__$1__", html_entity_decode($contenuBloc));
		$contenuBloc = preg_replace("/&/si", "&amp;", $contenuBloc);
		$contenuBloc = preg_replace("/_dw_entity__([^_]+)__/si", "&$1;", $contenuBloc);
		$contenuBloc = preg_replace("/(http:\/\/[^\/]+):\d+/si", "$1", $contenuBloc);
		$contenuBloc = "\n".preg_replace("/  /si", "\t", utf8_decode(str_replace("__euro__", "&euro;", $contenuBloc)))."\n";

		return $contenuBloc;
	}
}

?>
