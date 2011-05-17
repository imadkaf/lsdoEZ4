<?php

//Taille différentes selon les elements a transfomer
if (isset($_GET['lsdo'])){
	switch ( $_GET['lsdo'] ) {
		//Titre du site
		case "o1":
			$widthImg = 440;
			$heightImg = 40;
			break;
		
		//Slogan
		case "o2":
			$widthImg = 320;
			$heightImg = 20;
			break;
		/*
		//blocsAccueil_title
		case "o3":
			$widthImg = 300;
			$heightImg = 30;
			break;
			
		//blocsAccueil_subTitle
		case "o4":
			$widthImg = 300;
			$heightImg = 24;
			break;
		*/
	}
}

// Création de l'image
$im = imagecreatetruecolor($widthImg, $heightImg);

// Création des couleurs
$white 				= imagecolorallocate($im, 255, 255, 255);
$beige				= imagecolorallocate($im, 153, 141, 127);
$black 				= imagecolorallocate($im, 0, 0, 0);
$bleuOffice			= imagecolorallocate($im, 44, 132, 195);
$vertRestaurant		= imagecolorallocate($im, 134, 124, 88);
$bleuHotel			= imagecolorallocate($im, 0, 138, 177);
$fontHotel			= imagecolorallocate($im, 241, 229, 222);
$vertCamping		= imagecolorallocate($im, 75, 89, 53);
$fondCamping		= imagecolorallocate($im, 204, 208, 181);
$bleuAssociation	= imagecolorallocate($im, 2, 120, 194);
$fondAssociation	= imagecolorallocate($im, 120, 170, 237);

/*
//Si parametre suplementaire pour la couleur
if (isset($_GET['coul'])){
	switch ( $_GET['coul'] ) {
		//Rose
		case "rose":
			$paramCouleur = imagecolorallocate($im, 230, 68, 172);
			break;
			
		//Bleu ciel
		case "ciel":
			$paramCouleur = imagecolorallocate($im, 2, 189, 255);
			break;

		//Orange
		case "orange":
			$paramCouleur = imagecolorallocate($im, 255, 139, 51);
			break;

		//Bleu
		case "bleu":
			$paramCouleur = imagecolorallocate($im, 51, 126, 176);
			break;
	}
}
*/

//Valeurs différentes selon les elements a transfomer
if (isset($_GET['lsdo'])){
	switch ( $_GET['lsdo'] ) {
		//Titre du site
		case "o1":
			// Application de la transparence sur la couleur de fond dominante puis création de l'image
			imagecolortransparent($im, $black);
			imagefilledrectangle($im, 0, 0, $widthImg-1, $heightImg-1, $black);
			
			// Valeurs
			$font = 'Omnes_Medium.ttf';
			$fontSize = 38;
			$positionX = 0;
			$positionY = 35;
			$fontColor = $white;
			break;
			
		//Slogan
		case "o2":
			//Application de la transparence sur la couleur de fond dominante puis création de l'image
			imagecolortransparent($im, $black);
			imagefilledrectangle($im, 0, 0, $widthImg-1, $heightImg-1, $black);
			
			//Valeurs
			$font = 'Omnes_Regular.ttf';
			$fontSize = 15;
			$positionX = 0;
			$positionY = 17;
			$fontColor = $white;
			break;

		/*
		//blocsAccueil_title
		case "o3":
			//Application de la transparence sur la couleur de fond dominante puis création de l'image
			imagecolortransparent($im, $white);
			imagefilledrectangle($im, 0, 0, $widthImg-1, $heightImg-1, $white);
			
			//Valeurs
			$font = 'Omnes_Light.ttf';
			$fontSize = 24;
			$positionX = 0;
			$positionY = 23;
			$fontColor = $black;
			break;
			
		//blocsAccueil_subTitle
		case "o4":
			//Application de la transparence sur la couleur de fond dominante puis création de l'image
			imagecolortransparent($im, $white);
			imagefilledrectangle($im, 0, 0, $widthImg-1, $heightImg-1, $white);
			
			//Valeurs
			$font = 'Omnes_Medium.ttf';
			$fontSize = 17;
			$positionX = 0;
			$positionY = 18;
			$fontColor = $paramCouleur;
			break;
		*/
	}
}

// The text to draw
if (isset($_GET['t'])){
	$text = $_GET['t'];
}

// Add the text
imagettftext($im, $fontSize, 0, $positionX, $positionY, $fontColor, $font, $text);

// Using imagepng() results in clearer text compared with imagejpeg()
header('Content-type: image/png');
imagepng($im);
imagedestroy($im);

?>
