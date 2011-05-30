<?php

class WebformType extends eZWorkflowEventType
{
	const WORKFLOW_TYPE_STRING = "webform";
	public function __construct()
    {
        parent::__construct( WebformType::WORKFLOW_TYPE_STRING, 'Webform Contact' );
        $this->setTriggerTypes( array( 'content' => array( 'publish' => array( 'before' ) ) ) );
    }

    public function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        /*  YOUR CODE GOES HERE */

        
        //Test :
        exit("Au revoir !!!");
		// Définission des paramètres
		/*
        $urlCible = "http://vtigercrm.re7-cmt.lnet.fr/modules/Webforms/SQLI_post.php";
		$appKey = "bf8ca33ac809ad76792402300d8c2dd3";
		$idOffice = 78;
		$intituleDemande	= "[Demande web] http://". $_SERVER['SERVER_NAME'];
		$urlsite			= "http://". $_SERVER['SERVER_NAME'];
		$modecontact		= 'Web';
		$etatDemande		= 'A traiter';
		$pointAccueil		= 'Office de tourisme';
		*/
		/* Liste des valeurs possibles pour le type de formulaire
		    * Non renseigné
		    * Demandes d'informations
		    * Demandes de pré-réservations
		    * Demandes de brochures
		    * Carnets de voyage
		    * Newsletters
		    * Jeux concours
		*/
		$typeformulaire = "Demandes d'informations";
		$codeRetour 	= "";
		$html			= "";
		/*
		// Récupération des valeurs des champs
		if (isset($_POST['sqli_raisonsocial'])) $sqli_raisonsocial = $_POST['sqli_raisonsocial'];
		if (isset($_POST['sqli_prenom'])) $sqli_prenom = $_POST['sqli_prenom'];
		if (isset($_POST['sqli_nom'])) $sqli_nom = $_POST['sqli_nom'];
		if (isset($_POST['sqli_email'])) $sqli_email = $_POST['sqli_email'];
		if (isset($_POST['sqli_telephone'])) $sqli_telephone = $_POST['sqli_telephone'];
		if (isset($_POST['sqli_fax'])) $sqli_fax = $_POST['sqli_fax'];
		if (isset($_POST['sqli_mobile'])) $sqli_mobile = $_POST['sqli_mobile'];
		if (isset($_POST['sqli_adresse'])) $sqli_adresse = $_POST['sqli_adresse'];
		if (isset($_POST['sqli_adressecomp'])) $sqli_adressecomp = $_POST['sqli_adressecomp'];
		if (isset($_POST['sqli_codepostal'])) $sqli_codepostal = $_POST['sqli_codepostal'];
		if (isset($_POST['sqli_commune'])) $sqli_commune = $_POST['sqli_commune'];
		if (isset($_POST['sqli_pays'])) $sqli_pays = $_POST['sqli_pays'];
		if (isset($_POST['sqli_contactpartenaire'])) $sqli_contactpartenaire = $_POST['sqli_contactpartenaire'];
		if (isset($_POST['sqli_objetdem'])) $sqli_objetdem = $_POST['sqli_objetdem'];
		if (isset($_POST['sqli_civilite'])) $sqli_civilite = $_POST['sqli_civilite'];
		if (isset($_POST['sqli_modereponse'])) $sqli_modereponse = $_POST['sqli_modereponse'];
		if (isset($_POST['sqli_contactemail'])) $sqli_contactemail = $_POST['sqli_contactemail'];
		if (isset($_POST['sqli_campagneid']) && !empty($_POST['sqli_campagneid'])) $sqli_campagneid = $_POST['sqli_campagneid'];
		
		// Concaténation des informations complémentaires
		$cont = 1;
		$infocomp = "";
		while(isset($_REQUEST["sqli_infocomp_$cont"]) && $_REQUEST["sqli_infocomp_$cont"] != ""){
			$libelle = "";
			if(isset($_REQUEST["sqli_libelle_infocomp_$cont"]) && $_REQUEST["sqli_libelle_infocomp_$cont"] != "")
				$libelle = $_REQUEST["sqli_libelle_infocomp_$cont"];
			else
				$libelle = "Info $cont";
			$contenu = $_REQUEST["sqli_infocomp_$cont"];
			if($infocomp != "")
				$infocomp .= "<br>";
			$infocomp .= "$libelle : $contenu";
			$cont++;
		}
		
		// Traitement intermédiaire
				
		
		// Création d'un flux
		$tab_fields = array(  'appKey' => $appKey
							, 'group' => $idOffice
							, 'sqli_intitule' => $intituleDemande
							, 'sqli_modecontact' => $modecontact
							, 'sqli_etatdemande' => $etatDemande
							, 'sqli_pointaccueil' => $pointAccueil
							, 'sqli_raisonsocial' => $sqli_raisonsocial
							, 'sqli_prenom' => $sqli_prenom
							, 'sqli_nom' => $sqli_nom
							, 'sqli_email' => $sqli_email
							, 'sqli_telephone' => $sqli_telephone
							, 'sqli_fax' => $sqli_fax
							, 'sqli_mobile' => $sqli_mobile
							, 'sqli_adresse' => $sqli_adresse
							, 'sqli_adressecomp' => $sqli_adressecomp
							, 'sqli_codepostal' => $sqli_codepostal
							, 'sqli_commune' => $sqli_commune
							, 'sqli_pays' => $sqli_pays
							, 'sqli_objetdem' => $sqli_objetdem
							, 'sqli_civilite' => $sqli_civilite
							, 'sqli_pays' => $sqli_pays
							, 'sqli_contactpartenaire' => $sqli_contactpartenaire
							, 'sqli_modereponse' => $sqli_modereponse
							, 'sqli_urlsiteweb' => $urlsite
							, 'sqli_infocomp' => $infocomp
							, 'sqli_typeform' => $typeformulaire);
		if(isset($sqli_contactemail))
			$tab_fields['sqli_contactemail'] = $sqli_contactemail;
		if(isset($sqli_campagneid))
			$tab_fields['sqli_campagneid'] = $sqli_campagneid;
		
		$opts = array(
			'http' => array(
				'method' => "POST",
				'header' => "Accept-language: fr\r\n",
				'content' => http_build_query($tab_fields, '', '&')
			)
		);
		$context = stream_context_create($opts);
		
		// Accès au fichier HTTP avec les entêtes HTTP indiqués ci-dessus
		$codeRetour = file_get_contents($urlCible, false, $context);
		
		// Gestion du code Retour
		// Liste des codes erreurs
		$tab_error = array(	'e1' => 'Nom et prénom ou raison sociale ou email non renseignés',
							'e2' => 'Adresse email incorrecte',
							'e3' => 'L\'adresse email doit être renseignée pour ce mode de réponse',
							'e4' => 'Les champs nom et prénom ou raison sociale, adresse, code postal et commune doivent être renseignés pour ce mode de réponse',
							'e5' => 'Le téléphone doit être renseigné pour ce mode de réponse',
							'e6' => 'L\'objet de la demande est un champ obligatoire',
							'e7' => 'L\'une des adresses de retour n\'est pas correcte',
							'e8' => 'L\'id d\'équipe doit être renseigné',
							'e9' => 'L\'id d\'équipe renseigné n\'existe pas'); 
		
		if($codeRetour != ''){
			if($codeRetour != "Votre demande a correctement été enregistrée."){
				// Cas d'une erreur
				$tab_retour = explode(" => ", $codeRetour);
				// $tab_retour[0] => code d'erreur, $tab_retour[1] => message d'erreur
				echo $tab_retour[1];
			}else
				echo $codeRetour;
		}
		
		// Affichage du lien pour le téléchargement
		echo "<br /><br />Vous pouvez télécharger le script affichant cette page en cliquant <a href=Download.php >ici</a>";
		*/

		
		return eZWorkflowType::STATUS_ACCEPTED;
    }
}

eZWorkflowEventType::registerEventType( WebformType::WORKFLOW_TYPE_STRING, 'webformtype' );

?>
