<?php

require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

$http = eZHTTPTool::instance();

$sitIni = eZINI::instance('ez_aya_sit.ini');

$cheminCacheImages = $sitIni->variable('GlobalSitParameters','ImagesCachePath');

$dureeVieCache = 3600;

$currentDirectory = $_SERVER['DOCUMENT_ROOT'];
foreach (explode("/", $cheminCacheImages) as $cheminCacheImagesPart) {
	$currentDirectory .= "/".$cheminCacheImagesPart;
	if ($cheminCacheImagesPart && !file_exists($currentDirectory)) {
		mkdir($currentDirectory);
	}
}
$cheminCacheImages = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheImages;

$fileName = "";
if ($http->hasVariable('img')) {
	$fileName = urldecode($http->variable('img'));
}
$width = "";
if ($http->hasVariable('w')) {
	$width = urldecode($http->variable('w'));
}
$minWidth = "";
if ($http->hasVariable('mw')) {
	$minWidth = urldecode($http->variable('mw'));
}

$fileNameCrypted = sha1($width."__".$fileName);

$cheminFichierCacheImages = $cheminCacheImages.$fileNameCrypted;

$cacheExpire = true;
if (file_exists($cheminFichierCacheImages)) {
	$maintenant = time();
	$dateExpirationCache = filemtime($cheminFichierCacheImages)+$dureeVieCache;
	if ($dateExpirationCache > $maintenant) {
		$cacheExpire = false;
	}
}
$contenuImagesDistant = "";
if ($cacheExpire) {
	$contenuImagesDistant = SitUtils::urlGetContentsCurl($fileName, 20);
	if ($contenuImagesDistant) {
		file_put_contents($cheminFichierCacheImages, $contenuImagesDistant, LOCK_EX);
	}
}

$imageInfo = getimagesize($cheminFichierCacheImages);
$imageType = $imageInfo[2];
$image = false;
if ( $imageType == IMAGETYPE_JPEG ) {
	$image = imagecreatefromjpeg($cheminFichierCacheImages);
} elseif ( $imageType == IMAGETYPE_GIF ) {
	$image = imagecreatefromgif($cheminFichierCacheImages);
} elseif ( $imageType == IMAGETYPE_PNG ) {
	$image = imagecreatefrompng($cheminFichierCacheImages);
}

if ($image && (!$minWidth || $width < imagesx($image))) {
	$ratio = $width / imagesx($image);
	$height = imagesy($image) * $ratio;
	$newImage = imagecreatetruecolor($width, $height);
	imagecopyresampled($newImage, $image, 0, 0, 0, 0, $width, $height, imagesx($image), imagesy($image));
	$image = $newImage;
}

header("Content-type: image".($imageType == IMAGETYPE_JPEG ? "/jpeg" : ($imageType == IMAGETYPE_GIF ? "/gif" : ($imageType == IMAGETYPE_PNG ? "/png" : ""))));
$dateExpirationCacheGMT = filemtime($cheminFichierCacheImages) + $dureeVieCache - ((int)substr(date('O'), 0, 3) * 3600);
header("Expires: ".gmdate("D, d M Y H:i:s", $dateExpirationCacheGMT)." GMT");
$dateDerniereModifCacheGMT = filemtime($cheminFichierCacheImages) - ((int)substr(date('O'), 0, 3) * 3600);
header("Last-Modified: ".gmdate("D, d M Y H:i:s", $dateDerniereModifCacheGMT)." GMT");
header_remove("Cache-Control");
header_remove("Pragma");

if ( $imageType == IMAGETYPE_JPEG ) {
	imagejpeg($image, null, 100);
} elseif ( $imageType == IMAGETYPE_GIF ) {
	imagegif($image);
} elseif ( $imageType == IMAGETYPE_PNG ) {
	imagepng($image);
}

$Result = array();
$Result['pagelayout'] = 'empty_pagelayout.tpl';
$Result['content'] = null;

?>
