<?php

class QuizzInstantGagnantManagement extends eZPersistentObject {

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
        'date_heure' => array(
            'name' => 'date_heure',
            'datatype' => 'timestamp',
            'default' => '0000-00-00 00:00:00',
            'required' => true),
        'gagne' => array(
            'name' => 'gagne',
            'datatype' => 'integer',
            'required' => false)
    ),
    'keys' => array('id'),
    'class_name' => 'QuizzInstantGagnantManagement',
    'name' => 'quizz_instant_gagnant');
        return $def;
    }

    public static function instance($row) {
        $object = new self(array(
                    'id' => $row['id'],
                    'date_heure' => $row['date_heure'],
                    'gagne' => $row['gagne']));
        return $object;
    }

    public static function save($date_heure, $gagne = null,$id = null) {
        /* Vérifier si l'élément n'existe pas déjà sur la table */
        $DATETIMEFORMAT = "/^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$/";
        if (preg_match($DATETIMEFORMAT, $date_heure)) {
            $enregistrement = QuizzInstantGagnantManagement::instance(array('id'=>$id,'date_heure' => $date_heure, 'gagne' => $gagne));
            $enregistrement->store();
            $last_id = self::fetchObjectList(self::definition(), array('id'), null,array('id'=>'desc'));
            return $last_id[0]->id;
        }
        return false;
    }

    public static function newSave($date_heure) {
        return QuizzInstantGagnantManagement::save($date_heure);
    }

    public static function getInstantsGagnantsGagne() {
        $res = self::fetchObjectList(self::definition(), null, array('gagne' => array('<>', null)), array('date_heure' => 'desc'));
        return $res;
    }

    public static function getInstantsGagnantsNonGagne() {
        $res = self::fetchObjectList(self::definition(), null, array('gagne' => array('=', null)), array('date_heure' => 'desc'));
        return $res;
    }
    public static function getListInstantsGagnants() {
        $res = self::fetchObjectList(self::definition(), null, null, array('date_heure' => 'asc'));
        return $res;
    }

    public static function loadById($id) {
        $res = self::fetchObject(self::definition(), null, array('id' => $id));
        return $res;
    }
    public static function loadByParticipationId($participationId) {
        $res = self::fetchObject(self::definition(), null, array('gagne' => $participationId));
        return $res;
    }

    public static function getInstantsGagnantsByDates($dateDeb, $dateFin) {
        $res = self::fetchObjectList(self::definition(), null, array('date_heure' => array(false, array($dateDeb, $dateFin))), array('date_heure' => 'desc'));
        return $res;
    }

    public static function isInstantGagnant($dateTimeInstant) {
		// Est-ce que la date du jour est un instant gagnant qui n'a pas déjà été gagné ?
		$res = self::fetchObjectList(self::definition(),
										null,
										array('date_heure' => array(false,
																	array(date('Y-m-d 00:00:00'), date('Y-m-d H:i:s')))),
										array('date_heure' => 'desc'),
										null,
										true,
										false,
										null,
										null,
										' AND gagne IS NULL');

		if ($res != null) {
			return $res[0]->id;
		}
		return false;
    }
	
    public static function deleteById($id) {
        $res = self::removeObject(self::definition(), array("id" => $id));
        return $res;
    }
	
    public static function dateExistante($timestamp) {
        $res = self::fetchObjectList(self::definition(),
										null,
										array('date_heure' => array(false,
																	array(date('Y-m-d 00:00:00',$timestamp), date('Y-m-d 23:59:59',$timestamp))
																	)
										)
									);
        return $res;
    }
	
}

?>
