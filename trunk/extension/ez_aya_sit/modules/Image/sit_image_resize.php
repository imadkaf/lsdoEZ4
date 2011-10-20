<?php


require_once('extension/ez_aya_sit/classes/sit_utils.class.php');

$http = eZHTTPTool::instance();

$sitIni = eZINI::instance('ez_aya_sit.ini');

$cheminCacheImages = $sitIni->variable('GlobalSitParameters','ImagesCachePath');
$cheminCacheImages = $_SERVER['DOCUMENT_ROOT']."/".$cheminCacheImages;
if (!file_exists($cheminCacheImages."thumbs/")) {
	mkdir($cheminCacheImages."thumbs/", 0777, true);
}

$dureeVieCache = $sitIni->variable('GlobalSitParameters','DureeVieCacheImages');

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

$fileNameCrypted = sha1($fileName);
$resizedFileNameCrypted = sha1($width."_".$minWidth."_".$fileName);

$cheminFichierCacheImages = $cheminCacheImages.$fileNameCrypted;
$cheminFichierCacheImagesResized = $cheminCacheImages."thumbs/".$resizedFileNameCrypted;

$contenuImagesDistant = false;

$fs = false;
if (file_exists($cheminFichierCacheImagesResized)) {
	$fs = stat($cheminFichierCacheImagesResized);
}

$requestHeaders = getallheaders();
$imageType = "";
if (!file_exists($cheminFichierCacheImagesResized) || ($fs && time() > $fs['mtime'] + $dureeVieCache)) {
	$contenuImagesDistant = SitUtils::urlGetContentsCurlCustom($fileName, 120, file_exists($cheminFichierCacheImages) ? filemtime($cheminFichierCacheImages) : 60);
	if ($contenuImagesDistant) {
		file_put_contents($cheminFichierCacheImages, $contenuImagesDistant, LOCK_EX);
	}

	if (!file_exists($cheminFichierCacheImages)) {
		$cheminFichierCacheImages = $_SERVER['DOCUMENT_ROOT']."/extension/ez_aya_sit/design/standard/images/sit/image_fiche_defaut_grande.jpg";
	}

	//if (($contenuImagesDistant || !array_key_exists('If-Modified-Since', $requestHeaders) || (array_key_exists('Pragma', $requestHeaders) && $requestHeaders['Pragma'] == "no-cache" && array_key_exists('Cache-Control', $requestHeaders) && $requestHeaders['Cache-Control'] == "no-cache"))) {
		eZLog::write("Image ".$fileName." appelée", "ez_aya_sit.log");

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
	
		if ( $imageType == IMAGETYPE_JPEG ) {
			imagejpeg($image, $cheminFichierCacheImagesResized, 100);
		} elseif ( $imageType == IMAGETYPE_GIF ) {
			imagegif($image, $cheminFichierCacheImagesResized);
		} elseif ( $imageType == IMAGETYPE_PNG ) {
			imagepng($image, $cheminFichierCacheImagesResized);
		}
	/*} else {
		$cheminFichierCacheImagesResized = false;
	}*/
}

/*header("HTTP/1.1 ".($contenuImagesDistant || !array_key_exists('If-Modified-Since', $requestHeaders) || (array_key_exists('Pragma', $requestHeaders) && $requestHeaders['Pragma'] == "no-cache" && array_key_exists('Cache-Control', $requestHeaders) && $requestHeaders['Cache-Control'] == "no-cache") ? "200 OK" : "304 Not Modified"));*/
header("Content-type: image".($imageType == IMAGETYPE_JPEG ? "/jpeg" : ($imageType == IMAGETYPE_GIF ? "/gif" : ($imageType == IMAGETYPE_PNG ? "/png" : ""))));
/*$dateExpirationCacheGMT = filemtime($cheminFichierCacheImages) + $dureeVieCache - ((int)substr(date('O'), 0, 3) * 3600);
header("Expires: ".gmdate("D, d M Y H:i:s", $dateExpirationCacheGMT)." GMT");*/
$dateDerniereModifCacheGMT = filemtime($cheminFichierCacheImages) - ((int)substr(date('O'), 0, 3) * 3600);
header("Last-Modified: ".gmdate("D, d M Y H:i:s", $dateDerniereModifCacheGMT)." GMT");
/*$fs = stat($cheminFichierCacheImages);
header("Etag: ".sprintf('"%x-%x-%s"', $fs['ino'], $fs['size'],base_convert(str_pad($fs['mtime'],16,"0"),10,16)));*/

header_remove("X-Powered-By");
header_remove("Set-Cookie");
header_remove("Served-by");
header_remove("Transfer-Encoding");
header_remove("Content-Language");
header_remove("Pragma");
header_remove("Cache-Control");

if ($cheminFichierCacheImagesResized) {
	echo file_get_contents($cheminFichierCacheImagesResized);
}

eZExecution::cleanExit();

?>
