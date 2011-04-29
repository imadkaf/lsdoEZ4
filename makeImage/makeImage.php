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