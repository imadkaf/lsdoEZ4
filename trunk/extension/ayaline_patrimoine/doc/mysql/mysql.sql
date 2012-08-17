
--
-- Participation
--
CREATE TABLE IF NOT EXISTS `quizz_participation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50)  NOT NULL,
  `nom` text  NOT NULL,
  `prenom` text  NOT NULL,
  `adresse_ligne1` text ,
  `adresse_ligne2` text ,
  `code_postal` varchar(6) ,
  `ville` text ,
  `date_heure_participation` DATETIME  NOT NULL DEFAULT '0000-00-00 00:00:00',
  `participation_gagnante` TINYINT(1) DEFAULT 0,
  `quizz_id` int(11) ,
  `reponse_donnee` text ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- Instant gagnant
--
CREATE TABLE IF NOT EXISTS `quizz_instant_gagnant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_heure` DATETIME  NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gagne` int(11),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
