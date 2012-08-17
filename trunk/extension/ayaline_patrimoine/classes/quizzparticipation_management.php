<?php

class QuizzParticipationManagement extends eZPersistentObject {

    protected function __construct($row) {
        parent::eZPersistentObject($row);
    }

    public static function definition() {
        static $def = array(
    'fields' => array(
        'id' => array(
            'name' => 'id',
            'datatype' => 'integer',
            'required' => true),
        'email' => array(
            'name' => 'email',
            'datatype' => 'string',
            'required' => true),
        'nom' => array(
            'name' => 'nom',
            'datatype' => 'string',
            'required' => true),
        'prenom' => array(
            'name' => 'prenom',
            'datatype' => 'string',
            'required' => true),
        'adresse_ligne1' => array(
            'name' => 'adresse_ligne1',
            'datatype' => 'string',
            'required' => false),
        'adresse_ligne2' => array(
            'name' => 'adresse_ligne2',
            'datatype' => 'string',
            'required' => false),
        'code_postal' => array(
            'name' => 'code_postal',
            'datatype' => 'string',
            'required' => false),
        'ville' => array(
            'name' => 'ville',
            'datatype' => 'string',
            'required' => false),
        'date_heure_participation' => array(
            'name' => 'date_heure_participation',
            'datatype' => 'timestamp',
            'default' => '0000-00-00 00:00:00',
            'required' => true),
        'participation_gagnante' => array(
            'name' => 'participation_gagnante',
            'datatype' => 'integer',
            'required' => true,
            'default' => 0),
        'quizz_id' => array(
            'name' => 'quizz_id',
            'datatype' => 'integer',
            'required' => true),
        'reponse_donnee' => array(
            'name' => 'reponse_donnee',
            'datatype' => 'string',
            'required' => false)
    ),
    'keys' => array('id'),
    'class_name' => 'QuizzParticipationManagement',
    'name' => 'quizz_participation');
        return $def;
    }

    public static function instance($row) {
        $object = new self(array(
                    'id' => null,
                    'email' => $row['email'],
                    'nom' => $row['nom'],
                    'prenom' => $row['prenom'],
                    'adresse_ligne1' => $row['adresse_ligne1'],
                    'adresse_ligne2' => $row['adresse_ligne2'],
                    'code_postal' => $row['code_postal'],
                    'ville' => $row['ville'],
                    'date_heure_participation' => $row['date_heure_participation'],
                    'participation_gagnante' => $row['participation_gagnante'],
                    'quizz_id' => $row['quizz_id'],
                    'reponse_donnee' => $row['reponse_donnee']));
        return $object;
    }

    public static function save($email, $nom, $prenom, $adresse_ligne1, $adresse_ligne2, $code_postal, $ville, $date_heure_participation, $participation_gagnante, $quizz_id, $reponse_donnee, $id=null) {
        /* Vérifier si l'élément n'existe pas déjà sur la table */
        if (QuizzParticipationManagement::loadByEmailIdQuizz($email, $quizz_id) == null) {
            $row = array(
                'id' => $id,
                'email' => $email,
                'nom' => $nom,
                'prenom' => $prenom,
                'adresse_ligne1' => $adresse_ligne1,
                'adresse_ligne2' => $adresse_ligne2,
                'code_postal' => $code_postal,
                'ville' => $ville,
                'date_heure_participation' => $date_heure_participation,
                'participation_gagnante' => $participation_gagnante,
                'quizz_id' => $quizz_id,
                'reponse_donnee' => $reponse_donnee);
            $enregistrement = QuizzParticipationManagement::instance($row);
            $enregistrement->store();
            $last_id = self::fetchObjectList(self::definition(), array('id'), null, array('id' => 'desc'));
            return $last_id[0]->id;
        }
        return false;
    }

    public static function canParticipate($email, $quizz_id) {
        if (QuizzParticipationManagement::loadByEmailIdQuizz($email, $quizz_id) == null) {
            return true;
        }
        return false;
    }

    public static function loadByEmail($email) {
        $res = self::fetchObject(self::definition(), null, array('email' => $email));
        return $res;
    }

    public static function loadByEmailIdQuizz($email, $idQuizz) {
        $res = self::fetchObject(self::definition(), null, array('email' => $email, 'quizz_id' => $idQuizz));
        return $res;
    }

    public static function loadById($id) {
        $res = self::fetchObject(self::definition(), null, array('id' => $id));
        return $res;
    }

    public static function getParticipationsByDates($dateDeb, $dateFin) {
        $res = self::fetchObjectList(self::definition(), null, array('date_heure_participation' => array(false, array($dateDeb, $dateFin))), array('date_heure_participation' => 'desc'));
        return $res;
    }

}

?>
