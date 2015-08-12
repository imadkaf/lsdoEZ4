<?php

class AyalineUtils {
    /* !
      Constructor
     */

    function AyalineUtils() {
        $this->Operators = array('ezxmltext_truncate',
            'extract_email_contact',
            'str_replace',
            'server',
            'name_for_menu',
            'generation_code_video',
            'save_variable_in_session',
            'getFeedRSS',
            'show_captcha',
            'get_thematiques_array',
            'clean_relation_list',
            'evalphpcode',
        	'destroy_session',
        );
    }

    /* !
      Returns the operators in this class.
     */

    function &operatorList() {
        return $this->Operators;
    }

    /* !
      \return true to tell the template engine that the parameter list
      exists per operator type, this is needed for operator classes
      that have multiple operators.
     */

    function namedParameterPerOperator() {
        return true;
    }

    /* !
      Both operators have one parameter.
      See eZTemplateOperator::namedParameterList()
     */

    function namedParameterList() {
        return array(
            'ezxmltext_truncate' => array(
                'length' => array('type' => 'string',
                    'required' => false,
                    'default' => '')),
            'extract_email_contact' => array(),
            'str_replace' => array('a_remplacer' => array('type' => 'string',
                    'required' => true,
                    'default' => ''),
                'remplacement' => array('type' => 'string',
                    'required' => true,
                    'default' => '')),
            'server' => array('variable_name' => array('type' => 'string',
                    'required' => true,
                    'default' => '')),
            'name_for_menu' => array(
                'node' => array('type' => 'object',
                    'required' => false,
                    'default' => '')),
            'generation_code_video' => array(
                'link' => array('type' => 'string',
                    'required' => true,
                    'default' => ''),
                'videoNode' => array('type' => 'object',
                    'required' => true,
                    'default' => ''),
                'type' => array('type' => 'string',
                    'required' => true,
                    'default' => ''),
                'taille' => array('type' => 'array',
                    'required' => false,
                    'default' => '')),
            'save_variable_in_session' => array(
                'title' => array('type' => 'string',
                    'required' => true,
                    'default' => ''),
                'value' => array('type' => 'mixed',
                    'required' => true,
                    'default' => ''),
            ),
            'getFeedRSS' => array('pathString' => array('type' => 'string',
                    'required' => true,
                    'default' => ''),
                'list' => array('type' => 'string',
                    'required' => true,
                    'default' => '')),
            'show_captcha' => array(),
            'get_thematiques_array' => array('contactNode' => array('type' => 'mixed',
                    'required' => true,
                    'default' => '')
            ),
			'evalphpcode' => array(),
            'clean_relation_list' => array(),
            'destroy_session' => array()
        );
    }

    /* !
      \Executes the needed operator(s).
      \Checks operator names, and calls the appropriate functions.
     */

    function modify(&$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters) {
        switch ($operatorName) {

            case 'ezxmltext_truncate': {
                    $content = $operatorValue;
                    $length = $namedParameters['length'];
                    $operatorValue = $this->ezxmltext_truncate($content, $length);
                }
                break;
            case 'extract_email_contact': {
                    $content = $operatorValue;
                    $operatorValue = $this->extract_email_contact($content);
                }
                break;
            case 'str_replace': {
                    $operatorValue = $this->str_replace($namedParameters['a_remplacer'], $namedParameters['remplacement'], $operatorValue);
                }
                break;
            case 'server': {
                    $operatorValue = $this->server($namedParameters['variable_name']);
                }
                break;
            case 'name_for_menu': {
                    if (is_object($operatorValue))
                        $node = $operatorValue;
                    else
                        $node = $namedParameters['node'];
                    $operatorValue = $this->name_for_menu($node);
                }
                break;
            case 'generation_code_video': {
                    if ($operatorValue) {
                        $link = $operatorValue;
                        $videoNode = $namedParameters['link'];
                        $type = $namedParameters['videoNode'];
                        $taille = $namedParameters['type'];
                    } else {
                        $videoNode = $namedParameters['videoNode'];
                        $link = $namedParameters['link'];
                        $type = $namedParameters['type'];
                        $taille = $namedParameters['taille'];
                    }
                    $operatorValue = $this->generation_code_video($videoNode, $link, $type, $taille);
                }
                break;
            case 'save_variable_in_session': {
                    $operatorValue = $this->save_variable_in_session($namedParameters['title'], $namedParameters['value']);
                }
                break;
            case 'getFeedRSS': {
                    $operatorValue = $this->getFeedRSS($namedParameters['pathString'], $namedParameters['list']);
                }
                break;
            case 'show_captcha': {
                    $operatorValue = $this->show_captcha();
                }
                break;
            case 'get_thematiques_array': {
                    $operatorValue = $this->get_thematiques_array($namedParameters['contactNode']);
                }
                break;
            case 'clean_relation_list': {
                    $operatorValue = $this->cleanRelationList($operatorValue);
                }
                break;
			case 'evalphpcode': {
					$operatorValue = $this->evalPhpCode($operatorValue);
				}
				break;
            case 'destroy_session': {
                    $operatorValue = $this->destroy_session($operatorValue);
                }
                break;
        }
    }
	
    function destroy_session(){
    	$http = eZHTTPTool::instance();
    	$http->removeSessionVariable("message_validation");
    }
    
    function str_replace($a_remplacer, $remplacement, $source) {
        return str_replace($a_remplacer, $remplacement, $source);
    }

    function server($variableName) {
        if (isset($_SERVER[$variableName])) {
            return $_SERVER[$variableName];
        } else {
            eZDebug::writeWarning("Server variable $variableName does not exist.", 'Server Operator');
            return false;
        }
    }

    /**
     * TO permettant d'épurer et de tronquer du code HTML provenant d'un OnlineEditor. Marche aussi pour un textarea standar
     * @author Guillaume Bourreau
     * @date 19 mai 2011
     * @param string $content Le contenu texte
     * @param string $length Nombre de caractères maximum
     * @return string $content
     */
    function ezxmltext_truncate($content, $length) {
        // On remplace les sauts de lignes par un espace.
        $content = str_replace('<br />', ' ', $content);
        $content = str_replace('<br/>', ' ', $content);
        $content = str_replace("\n", ' ', $content);
        // On remplace les fins de balises par un espace
        $content = preg_replace('/<\/[^>]*?>/si', ' ', $content);
        $content = preg_replace("/(\s){2,}/si", '$1', $content);

        // On supprimes toutes les balises HTML restantes
        $content = strip_tags($content);

        if ($length && (strlen($content) > $length)) {
            $content = wordwrap($content, $length);
            ;
            $content = substr($content, 0, strpos($content, "\n"));
            $content = trim($content) . '...';
        }

        return $content;
    }

    /**
     * TO pour l'export des lieux scéniques, pour extraire l'email
     * @author Guillaume Bourreau
     * @date 27 juil. 2011
     * @return the bare_field_name
     * @param unknown_type $content
     */
    function extract_email_contact($content) {
        $res = preg_match('/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/si', $content, $matches);
        $email = '';
        if ($res) {
            $email = $matches[0];
        }
        return $email;
    }

    /**
     * Titre pour les menus : titre_court s'il existe, ou sinon le name
     * @author Guillaume Bourreau
     * @date 19 mai 2011
     * @param unknown_type $a_remplacer
     * @param unknown_type $remplacement
     * @param unknown_type $source
     * @return mixed
     */
    function name_for_menu($node) {
        $object = $node->object();
        $titre = $object->Name;

        $attrs = $node->attribute('data_map');

        if (array_key_exists('titre_court', $attrs)) {
            if (trim($attrs['titre_court']->value()) != '')
                $titre = $attrs['titre_court']->value();
        }

        return $titre;
    }

    /**
     * TO permettant, à partir d'un lien de vidéo Dailymotion ou un code embed ciclic de retourner une vignette ou la vidéo de taille souhaitée
     * La taille est un tableau (width, height)
     * Le principe est d'envoyer l'url,'embed' et array(width,height) pour afficher une video
     * Ou l'url ,'vignette' et array(width,height) pour une vignette de la vidéo Dailymotion
     * Il faut utiliser les type ciclicVignette et ciclicVideo pour le site ciclic.
     * Les 3 attributs du TO sont obligatoires
     * @author Maxime Morillon
     * @date 27 mai 2011
     */
    function generation_code_video($videoNode, $link, $type, $taille) {

        require_once( "kernel/common/template.php" );
        $tpl = templateInit();

        $largeur = $taille[0];
        $hauteur = $taille[1];

        /* Ciclic */
        if ($type == 'ciclicVideo') {

            $link = preg_replace('/height="(\d*)"/', 'height="' . $taille[1] . '"', $link);
            $link = preg_replace('/width="([^\"]*)\"/', 'width="' . $taille[0] . '"', $link);

            $tpl->setVariable('code', $link);
        } elseif ($type == 'ciclicVignette') {
            // On récupère l'url de l'image depuis le code embed
            $str = '';
            if (preg_match('/screenShotResource=([^\&]*)\&/', $link, $matches))
                $str = $matches[1];
            $tpl->setVariable('code', $str);
        }
        else {
            /* Daily Motion ou Youtube */
            if (strpos($link, 'dailymotion') !== false) {
                // On récupère le code de la vidéo depuis l'url
                preg_match('/video\/(.*?)_/si', $link, $matches);
                $code = $matches[1];

                $type .= '-dailymotion';
            }

            if (strpos($link, 'youtube') !== false) {
                // On récupère le code de la vidéo depuis l'url
                preg_match('/v\=([^\&]*)/si', $link, $matches);
                $code = $matches[1];

                // Youtube n'a pas le même ratio (1,33) que Dailymotion (1,77), alors on s'adapte en fonction de la largeur pour la vidéo, en fonction de la largeur pour la vignette
                $largeur = (int) ($hauteur * (4 / 3));
                /* if($type == 'vignette') {
                  $largeur = (int)($hauteur * (4/3));
                  }
                  else {
                  $hauteur = (int)($largeur * (3/4));
                  } */

                $type .= '-youtube';
            }

            $tpl->setVariable('code', $code);
        }

        $tpl->setVariable('url', $link);
        $tpl->setVariable('videoNode', $videoNode);
        $tpl->setVariable('type', $type);
        $tpl->setVariable('largeur', $largeur);
        $tpl->setVariable('hauteur', $hauteur);

        $Result['content'] = $tpl->fetch('design:content/affichage_video.tpl');

        return $Result['content'];
    }

    /**
     * Sauvegarde d'une valeur dans une variable de session
     * @param string $title
     * @param mixed $value
     */
    function save_variable_in_session($title, $value) {
        echo "toto";
        $http = eZHTTPTool::instance();
        $http->setSessionVariable($title, $value);
    }

    function getFeedRSS($pathString, $list) {
        // Pas optimisé... boucle sur tous les flux RSS
        // TODO : prendre le noeud le plus profond

        if ($list == 'list') {
            $exportArray = eZRSSExport::fetchList();
            return $exportArray;
        }

        $titleFeedRss = '';
        $urlFeedRss = '';
        $pathArray = explode('/', $pathString);

        // Récupération de tous les flux RSS exportés 
        $exportArray = eZRSSExport::fetchList();
        foreach ($exportArray as $export) {
            $rssExport = eZRSSExport::fetch($export->ID);
            // Récupération des sources de ce flux 
            $rssItems = $rssExport->fetchItems();
            foreach ($rssItems as $rssItem) {
                print "Node id source = " . $rssItem->SourceNodeID . "<br/>";
                // Si le noeud courant (ou un de ses pères) est dans un flux, on récupère l'URL
                // TODO : prendre le noeud le plus profond
                if (in_array($rssItem->SourceNodeID, $pathArray)) {
                    $urlFeedRss = $export->URL . "rss/feed/" . $export->AccessURL;
                    $titleFeedRss = $rssExport->Title;
                    break;
                }
            }
        }
        return array($titleFeedRss, $urlFeedRss);
    }

    /**
     * Vérifie si l'internaute doit utiliser un captcha
     */
    function show_captcha() {
        $currentUser = eZUser::currentUser();
        $accessAllowed = $currentUser->hasAccessTo('recaptcha', 'bypass_captcha');
        if ($accessAllowed["accessWord"] == 'yes') {
            return false;
        }
        return true;
    }

    /**
     * Récupère la liste des thématiques sous la forme : "index" => "valeur"
     */
    function get_thematiques_array($contactNode) {

        $thematiquesArray = array();
        /** Récupération du formulaire de contact * */
        $survey = eZSurvey::fetchByObjectInfo($contactNode->ContentObjectID, '376', 'fre-FR');
        /** Récupération des questions du formulaires * */
        $questionList = $survey->fetchQuestionList();

        /** Récupération de la liste des destinataire contenant en titre : un entier * */
        foreach ($questionList as $question) {
            if (get_class($question) == 'eZSurveyReceiver') {
                if ($question->Text > 0) {
                    foreach ($question->Options as $option) {
                        /** Construction du tableau à retourner * */
                        $thematiquesArray[$option['id']] = $option['label'];
                    }
                    break;
                }
            }
        }
        return $thematiquesArray;
    }

    /**
     * Permet de nettoyer les nodes supprimés et cachés d'un relation_list 
     * @author Guillaume Bourreau
     * @date 28 sept. 2011
     * @return the bare_field_name
     * @param unknown_type $relationList
     */
    function cleanRelationList($relationList) {
        $newRelationList = array();
        foreach ($relationList as $relation) {
            if ($relation['node_id']) {
                $node = eZContentObjectTreeNode::fetch($relation['node_id']);
                if ($node instanceOf eZContentObjectTreeNode) {
                    if (!($node->IsHidden || $node->IsInvisible)) {
                        $newRelationList[] = $relation;
                    }
                }
            }
        }

        return $newRelationList;
    }
	
	/**
	 * Permet d'évaluer un code php
	 * @author Guillaume Bourreau
	 * @date 13 juin 2012
	 * @return the bare_field_name
	 * @param unknown_type $relationList
	 */
	function evalPhpCode($content) {
		ob_start();
		eval($content);
		$out = ob_get_contents();
		ob_end_clean();
		return $out;
	}

}

?>