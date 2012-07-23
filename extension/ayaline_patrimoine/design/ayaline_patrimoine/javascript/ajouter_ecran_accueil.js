//if(navigator.userAgent.indexOf('iPhone') != -1) {
	var date = new Date();
	date.setTime(date.getTime()+(60*24*60*60*1000));
	var expires = ";expires="+date.toGMTString();
	document.cookie = 'popin=accueil' + expires;
	
	document.write('<link rel="apple-touch-icon" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/images/touch-icon-iphone.png">');
	document.write('<link rel="apple-touch-icon" sizes="72x72" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/images/touch-icon-iphone.png">');
	document.write('<link rel="apple-touch-icon" sizes="114x114" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/images/touch-icon-iphone4.png">');
	document.write('<script src="/extension/ayaline_patrimoine/design/ayaline_patrimoine/javascript/addToHomeConfig.js"></script>');
	document.write('<link rel="stylesheet" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/stylesheets/add2home.css" type="text/css" />');
	document.write('<script src="/extension/ayaline_patrimoine/design/ayaline_patrimoine/javascript/add2home.js"></script>');	
//}