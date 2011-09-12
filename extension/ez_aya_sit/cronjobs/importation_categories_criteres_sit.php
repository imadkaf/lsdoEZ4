<?php

$cli->setUseStyles(true);

if (!$isQuiet) {
	$cli->output($cli->stylize('cyan', "\tDébut import données catégories critères SIT dans les classes SIT."));
}

$sitIni = eZINI::instance('ez_aya_sit.ini');

if ($sitIni->hasVariable('GlobalSitParametersOverride', 'RootSitUrl')) {
	$rootSitUrl = $sitIni->variable('GlobalSitParametersOverride','RootSitUrl');
} else {
	$rootSitUrl = $sitIni->variable('GlobalSitParameters', 'RootSitUrl');
}

$classesSIT = $sitIni->variable('ClassesAttributsSit','ClassesSit');

$xmlStringCategories = file_get_contents($rootSitUrl."Categories");

if ($xmlStringCategories) {
	$xmlCategories = new SimpleXMLElement($xmlStringCategories);
	$categoriesNodes = $xmlCategories->xpath("/categories/categorie[@nbFils='0']");

	if ($classesSIT) {
		foreach ($classesSIT as $identifierClasseSIT) {
			$classeSIT = null;
			if ($identifierClasseSIT) {
				$classeSIT = eZContentClass::fetchByIdentifier($identifierClasseSIT);
			}
			if ($classeSIT) {
				$attributCategorieSIT = $classeSIT->fetchAttributeByIdentifier('categorie');

				if ($attributCategorieSIT) {
					$dataTypeSelection = $attributCategorieSIT->dataType();
					$dataTypeSelection->initializeClassAttribute($attributCategorieSIT);
					$attributCategorieSIT->store();

					$doc = new DOMDocument('1.0', 'utf-8');
					$root = $doc->createElement("ezselection");
					$doc->appendChild($root);

					$optionsNode = $doc->createElement("options");

					$optionsNode = $doc->createElement("options");

					$optionNode = $doc->createElement("option");
					$optionNode->setAttribute('id', "0");
					$optionNode->setAttribute('name', "Toutes les catégories");

					$categoriesArray = array();

					foreach ($categoriesNodes as $categorieNode) {
						$categoriesArray["".$categorieNode->attributes()->id] = "".$categorieNode;
						$optionNode = $doc->createElement("option");
						$optionNode->setAttribute('id', $categorieNode->attributes()->id);
						$optionNode->setAttribute('name', $categorieNode);

						$optionsNode->appendChild($optionNode);
					}

					$root->appendChild($optionsNode);

					$xml = $doc->saveXML();
					$attributCategorieSIT->setAttribute("data_text5", $xml);

					$attributCategorieSIT->sync();

					$criteresArray = array();
					foreach ($categoriesArray as $idCategorieSIT=>$categorieSIT) {
						$xmlStringCriteres = file_get_contents($rootSitUrl."Criteres&idC=".$idCategorieSIT);
						$xmlStringCriteres = str_replace("&#128;", "__euro__", $xmlStringCriteres);
						if ($xmlStringCriteres) {
							$xmlCriteres = new SimpleXMLElement($xmlStringCriteres);
							$criteresNodes = $xmlCriteres->xpath("/criteres/criteresSpecs/critere");
							foreach ($criteresNodes as $critereNode) {
								$critereNodeChildren = $critereNode->children();
								if ($criteresArray["".$critereNode->attributes()->id]) {
									$criteresArray["".$critereNode->attributes()->id]['categories'][] = $idCategorieSIT;
								} else {
									$criteresArray["".$critereNode->attributes()->id] = array('int_critere' => "".$critereNodeChildren[0], 'categories' => array($idCategorieSIT), 'modalites' => array());
								}

								$modatitesNodes = $xmlCriteres->xpath("/criteres/criteresSpecs/critere[@id='".$critereNode->attributes()->id."']/modalites/modalite");
								if (count($modatitesNodes) > 1) {
									foreach ($modatitesNodes as $modatiteNode) {
										if ($criteresArray["".$modatiteNode->attributes()->id]) {
											$criteresArray["".$modatiteNode->attributes()->id]['categories'][] = $idCategorieSIT;
										} else {
											$criteresArray["".$modatiteNode->attributes()->id] = array('int_critere' => "".$critereNodeChildren[0]." — ".$modatiteNode, 'categories' => array($idCategorieSIT));
										}
									}
								}
							}
						} else {
							if (!$isQuiet) {
								$cli->output($cli->stylize('yellow', "\t\tL'URL '".$rootSitUrl."Criteres&idC=".$idCategorieSIT."' est injoignable. Les critères de la catégorie '".$categorieSIT."' n'ont donc pas été mis à jour."));
							}
						}
					}

					$attributsCriteres = $sitIni->variable('ClassesAttributsSit','AttributsCriteres_'.$identifierClasseSIT);
					$attributsCriteresTri = $sitIni->variable('ClassesAttributsSit','AttributsCriteresTri_'.$identifierClasseSIT);
					
					if ($attributsCriteres) {
						foreach ($attributsCriteres as $attributCritere) {
							$attributCritereSIT = $classeSIT->fetchAttributeByIdentifier($attributCritere);

							$doc = new DOMDocument('1.0', 'utf-8');
							$root = $doc->createElement("ezcategoryselection");
							$doc->appendChild($root);

							$optionsNode = $doc->createElement("options");

							if (in_array($attributCritere, $attributsCriteresTri)) {
								$optionNode = $doc->createElement("option");
								$optionNode->setAttribute('id', "1");
								$optionNode->setAttribute('name', "Commune");

								$optionCategoriesNode = $doc->createElement("category");
								$optionCategoriesNode->setAttribute('category_id', $attributCategorieSIT->attribute('id'));
								$optionCategoriesNode->setAttribute('category_value', "0-".join("-", array_keys($categoriesArray)));

								$optionNode->appendChild($optionCategoriesNode);

								$optionsNode->appendChild($optionNode);

								if ($attributCritere == 'critere_tri_principal') {
									$optionNode = $doc->createElement("option");
									$optionNode->setAttribute('id', "2");
									$optionNode->setAttribute('name', "Aléatoire");

									$optionCategoriesNode = $doc->createElement("category");
									$optionCategoriesNode->setAttribute('category_id', $attributCategorieSIT->attribute('id'));
									$optionCategoriesNode->setAttribute('category_value', "0-".join("-", array_keys($categoriesArray)));

									$optionNode->appendChild($optionCategoriesNode);

									$optionsNode->appendChild($optionNode);

									$optionNode = $doc->createElement("option");
									$optionNode->setAttribute('id', "4");
									$optionNode->setAttribute('name', "Date d'ouverture");

									$optionCategoriesNode = $doc->createElement("category");
									$optionCategoriesNode->setAttribute('category_id', $attributCategorieSIT->attribute('id'));
									$optionCategoriesNode->setAttribute('category_value', "0-".join("-", array_keys($categoriesArray)));

									$optionNode->appendChild($optionCategoriesNode);

									$optionsNode->appendChild($optionNode);
								}
								
								$optionNode = $doc->createElement("option");
								$optionNode->setAttribute('id', "3");
								$optionNode->setAttribute('name', "Nombre de consultations");

								$optionCategoriesNode = $doc->createElement("category");
								$optionCategoriesNode->setAttribute('category_id', $attributCategorieSIT->attribute('id'));
								$optionCategoriesNode->setAttribute('category_value', "0-".join("-", array_keys($categoriesArray)));

								$optionNode->appendChild($optionCategoriesNode);

								$optionsNode->appendChild($optionNode);
							}

							foreach ($criteresArray as $idCritereSIT=>$critereSIT) {
								$optionNode = $doc->createElement("option");
								$optionNode->setAttribute('id', $idCritereSIT);
								$optionNode->setAttribute('name', $critereSIT['int_critere']);

								$optionCategoriesNode = $doc->createElement("category");
								$optionCategoriesNode->setAttribute('category_id', $attributCategorieSIT->attribute('id'));
								$optionCategoriesNode->setAttribute('category_value', "0-".join("-", $critereSIT['categories']));

								$optionNode->appendChild($optionCategoriesNode);
								$optionsNode->appendChild($optionNode);
							}

							$root->appendChild($optionsNode);

							$categoriesNode = $doc->createElement("categories");

							$categoryNode = $doc->createElement("category");
							$categoryNode->setAttribute('id', "1");
							$categoryNode->setAttribute('category_class', "");
							$categoryNode->setAttribute('category_id', $attributCategorieSIT->attribute('id'));
							$categoryNode->setAttribute('category_value', "");

							$categoriesNode->appendChild($categoryNode);
							$root->appendChild($categoriesNode);

							if ($attributCritereSIT) {
								$dataTypeSelection = $attributCritereSIT->dataType();
								$dataTypeSelection->initializeClassAttribute($attributCritereSIT);
								$attributCritereSIT->store();
								
								$attributCritereSIT->setAttribute("data_text5", str_replace("__euro__", "€", $doc->saveXML()));

								$attributCritereSIT->sync();
							} else {
								$cli->output($cli->stylize('red', "\t\tAttribut '".$attributCritere."' de la classe '". $identifierClasseSIT."' non trouvé."));
							}
						}
					}
				} else {
					if (!$isQuiet) {
						$cli->output($cli->stylize('red', "\t\tAttribut 'categorie' de la classe '". $identifierClasseSIT."' non trouvé."));
					}
				}

				$xmlStringCriteres = file_get_contents($rootSitUrl."Criteres");
				if ($xmlStringCriteres) {
					$xmlCriteres = new SimpleXMLElement($xmlStringCriteres);
					$entitesNodes = $xmlCriteres->xpath("/criteres/criteresCommuns/partenaires/partenaire");
					$paysNodes = $xmlCriteres->xpath("/criteres/criteresCommuns/pays17/pays");

					$attributPaysSIT = $classeSIT->fetchAttributeByIdentifier('pays_epci');

					if ($attributPaysSIT) {
						$dataTypeSelection = $attributPaysSIT->dataType();
						$dataTypeSelection->initializeClassAttribute($attributPaysSIT);
						$attributPaysSIT->store();

						$doc = new DOMDocument('1.0', 'utf-8');
						$root = $doc->createElement("ezselection");
						$doc->appendChild($root);

						$optionsNode = $doc->createElement("options");

						foreach ($paysNodes as $paysNode) {
							$optionNode = $doc->createElement("option");
							$optionNode->setAttribute('id', $paysNode->attributes()->id);
							$optionNode->setAttribute('name', $paysNode);

							$optionsNode->appendChild($optionNode);
						}

						$root->appendChild($optionsNode);

						$xml = $doc->saveXML();
						$attributPaysSIT->setAttribute("data_text5", $xml);

						$attributPaysSIT->sync();
					}

					$attributEntitesSIT = $classeSIT->fetchAttributeByIdentifier('entites');

					if ($attributEntitesSIT) {
						$dataTypeSelection = $attributEntitesSIT->dataType();
						$dataTypeSelection->initializeClassAttribute($attributEntitesSIT);
						$attributEntitesSIT->store();

						$doc = new DOMDocument('1.0', 'utf-8');
						$root = $doc->createElement("ezselection");
						$doc->appendChild($root);

						$optionsNode = $doc->createElement("options");

						foreach ($entitesNodes as $entiteNode) {
							$optionNode = $doc->createElement("option");
							$optionNode->setAttribute('id', $entiteNode->attributes()->id);
							$optionNode->setAttribute('name', $entiteNode);

							$optionsNode->appendChild($optionNode);
						}

						$root->appendChild($optionsNode);

						$xml = $doc->saveXML();
						$attributEntitesSIT->setAttribute("data_text5", $xml);

						$attributEntitesSIT->sync();
					}
				}
			} else {
				if (!$isQuiet) {
					$cli->output($cli->stylize('red', "\t\tClasse '". $identifierClasseSIT."' non trouvée."));
				}
			}
		}
	}
} else {
	if (!$isQuiet) {
		$cli->output($cli->stylize('yellow', "\t\tL'URL '".$rootSitUrl."Categories' est injoignable. Les catégories n'ont donc pas été mises à jour."));
	}
}

if (!$isQuiet) {
	$cli->output($cli->stylize('green', "\tFait."));
}

?>
