if (navigator.userAgent.indexOf('iPhone') != -1) {
				document.write('<link rel="stylesheet" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/stylesheets/stylesheet_iphone.css" type="text/css" />');
			} else if (navigator.userAgent.indexOf('Android') != -1) {
				document.write('<link rel="stylesheet" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/stylesheets/stylesheet_android.css" type="text/css" />');
			}else if (navigator.userAgent.indexOf('Chrome') != -1) {
				document.write('<link rel="stylesheet" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/stylesheets/stylesheet_desktop.css" type="text/css" />');
			}else if (navigator.userAgent.indexOf('BlackBerry') != -1) {
				document.write('<link rel="stylesheet" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/stylesheets/stylesheet_blackberry.css" type="text/css" />');
			}else {
				document.write('<link rel="stylesheet" href="/extension/ayaline_patrimoine/design/ayaline_patrimoine/stylesheets/stylesheet_desktop.css" type="text/css" />');
			}