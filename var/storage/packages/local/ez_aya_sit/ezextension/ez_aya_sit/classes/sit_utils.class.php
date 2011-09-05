<?php

class SitUtils {
	static function urlGetContentsCurl() {
		// traitement des arguments optionnels et des valeurs par défaut.
		$arg_names = array('url', 'timeout', 'getContent', 'offset', 'maxLen');
		$arg_passed = func_get_args();
		$arg_nb = count($arg_passed);

		if (!$arg_nb){
			return false;
		}

		$arg = array (
			'url' => null,
			'timeout' => 30,
			'getContent' => true,
			'offset' => 0,
			'maxLen' => null
		);

		foreach ($arg_passed as $k=>$v) {
			$arg[$arg_names[$k]] = $v;
		}

		// connexion CURL et retour du résultat
		$ch = curl_init($arg['url']);

		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_RESUME_FROM, $arg['offset']);
		curl_setopt($ch, CURLOPT_TIMEOUT, $arg['timeout']);

		$resultat = curl_exec($ch);
		$elapsed = curl_getinfo($ch, CURLINFO_TOTAL_TIME);
		$CurlErr = curl_error($ch);
		curl_close($ch);

		if ($CurlErr) {
			return false;
		} elseif ($arg['getContent']) {
			if ($arg['maxLen']) {
				return substr($resultat, 0, $arg['maxLen']);
			} else {
				return $resultat;
			}
		}

		return false;
	}

	static function getHtmlResult($xmlFile, $xslFile, $parameters = array()) {
		$xml = new DOMDocument();

		$xml->load($xmlFile);

		$xslt = new XSLTProcessor();
		$xsl = new DOMDocument();
		$xsl->load($xslFile);
		$xslt->importStylesheet($xsl);

		if (is_array($parameters) && count($parameters) > 0) {
			$xslt->setParameter('', $parameters);
		}

		return $xslt->transformToXML($xml);
	}
}

?>
