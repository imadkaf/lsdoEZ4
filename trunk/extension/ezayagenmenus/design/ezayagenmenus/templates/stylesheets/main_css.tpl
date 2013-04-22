{literal}
/* Polices suplementaires */
@font-face {
	font-family:'OmnesLight';
	src:url('../fonts/omnes_light-webfont.eot');
	src:local('OmnesLight'), url('../fonts/Omnes_Light.ttf') format('truetype');
	font-weight:normal;
	font-style:normal;
}

@font-face {
	font-family:'OmnesMedium';
	src:url('../fonts/omnes_medium-webfont.eot');
	src:local('OmnesMedium'), url('../fonts/Omnes_Medium.ttf') format('truetype');
	font-weight:normal;
	font-style:normal;
}



/* ############################################################################
	Les sables d'olonne
	Ayaline 2010
############################################################################ */

/* ############################################################################
	 1. CSS RESET
############################################################################ */

body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, fieldset, p, blockquote, th, td {margin:0; padding:0;}

h1, h2, h3, h4, h5, h6 {font-size:100%;}

ol, ul {list-style:none;}

adress, caption, cite, code, dfn, em, th, var {font-style:normal; font-weight:normal;}

table {}
input, textarea , select{
	color:#000000;
	font-family:Arial,Verdana,Helvetica,sans-serif;
}
img {border:0;}

p {padding:0; /*color:#000000;*/}

caption, th {text-align:left;}

q:before, q:after {content:'';}

a {cursor:pointer; color:#000000;text-decoration:none;outline:none}
a:hover {text-decoration:underline;}
fieldset {border:none;}
.none, hr {display:none;}
.clear {clear:both; line-height:0 !important; padding:0 !important;}
.clear-both {clear:both;overflow:hidden;height:0;font-size:0;}
.none-bg {background:none;}
h1 {
	font-size:35px;
}
h2 {font-size:12px}
.float-g{
	float:left;
}
.float-d{
	float:right !important;
}
.display-block{
	display:block;
}
.display-inline{
	display:inline;
}
.display-none,
.none{
	display:none !important;
}
.none-border{
	border:none;
}
.underline a, .underline a:hover{
	text-decoration:underline;
}
.no-overflow{
	overflow:hidden;
	height:1%;
}
.line-through{
	text-decoration:line-through;
}
.uppercase{
	text-transform:uppercase;
}
.align-c{
	text-align:center;
}
.align-l{
	text-align:left !important;
}
/* ############################################################################
	 STRUCTURE
############################################################################ */
#global-page{
}
#header {
	padding:0 0 5px 0;
}
#content {
	width:800px;
	margin:0 auto;
	overflow:hidden;
	height:1%;
}
.footer {
	clear:both;
	background:#2b3b46;
	padding:21px;
	color:#ffffff;
	overflow:hidden;
	height:1%;
}
/* ############################################################################
	 2. GENERIC STYLES FOR TAGS
############################################################################ */

/* PAGE ***************************************************************** */
body {
	font-size:12px; font-family:Arial, Verdana, Helvetica, sans-serif;
	color:#000000;
	background:#f6efe9;
}

/* ############################################################################
	 5. CONTENU
############################################################################ */
/* Header ***************************************************************** */

#headerdiapos{
	text-align:center;
	min-height: 178px;
	background-position: 50% 0;
	background-repeat: no-repeat;
}

#headerimgs {
	height:505px;
}

.headerdiapo {
	position:relative;

}
.headerimg {
	background-position:center top;
	background-repeat:no-repeat;
	height:500px;
	position:absolute;
	width:100%;
	min-width: 1260px;
}
.header-in{
	background:url("/extension/ayaline/design/ayaline/images/headerbg.png") 50% 0 repeat;
	height:122px;
	position:absolute;
	top: 28px;
	left: 0;
	width: 100%;
	min-width: 1260px;
}
.header-content{
	margin:0 auto;
	width:1110px;
}
.header-in h1{
	float:left;
	width:500px;
}
.header-in h1 a:hover{
	text-decoration:none;
}
.header-in h1 p{
}
.header-in h1 a{
}
.header-in h1 .style-png{

}
.header-in h1 .style-png img{
	position:relative;
	float:left;
}
.header-in h1 .style-png img.home-title{
	top:15px;
	left:45px;
}
.header-in h1 .style-png img.home-grip{
	top:20px;
	left:10px;
}
.header-in-right{
	float:right;
	padding:5px 0 0 0;
	width:600px;
}
.header-in-right ul.list-top,
.header-in-right div.menu{
	float:right;
}
.header-in-right ul.list-top{
}
.header-in-right ul li{
	display:inline;
	float:left;
	color:#ffffff;
}
.header-in-right ul li.last{
	margin:0;
	padding:0;
}
.header-in-right ul li.last ul li{
	margin:0 15px 0 0;
}
.header-in-right ul li.last ul li.last{
	margin:0;
}
.header-in-right ul li.meteo{
	background:url('../images/sun.png') 0 0 no-repeat;
	padding:0 0 0 20px;
	margin:0 16px 0 7px;
}
.header-in-right ul li.langue{
	margin:0 15px;
}
.header-in-right ul li select{
	width:43px;
}
.header-in-right ul li a{
	color:#ffffff;
}
li.last form{
	overflow:hidden;
	height:1%;
}
.img0 input,
.img1 input,
.img2 input,
.img3 input{
	border:none !important;
	float:none !important;
	padding:0 !important;
	cursor:pointer;
}
.img0 input{
	background:url('../images/img0.png') 0 0 no-repeat !important;
	width:24px !important;
	height:23px !important;
}
.img0 input.actif, .img0 input:hover {
	background:url('../images/img0-on.png') 0 0 no-repeat !important;
}
.img1 input{
	background:url('../images/img1.png') 0 0 no-repeat !important;
	width:18px !important;
	height:23px !important;
}
.img1 input.actif, .img1 input:hover{
	background:url('../images/img1-on.png') 0 0 no-repeat !important;
}
.img2 input{
	background:url('../images/img2.png') 0 0 no-repeat !important;
	width:22px !important;
	height:23px !important;
}
.img2 input.actif, .img2 input:hover{
	background:url('../images/img2-on.png') 0 0 no-repeat !important;
}
.img3 input{
	background:url('../images/img3.png') 0 0 no-repeat !important;
	width:17px !important;
	height:23px !important;
}
.img3 input.actif, .img3 input:hover{
	background:url('../images/img3-on.png') 0 0 no-repeat !important;
}
.header-in-right input{
	text-transform:uppercase;
	font-size:11px;
	width:214px;
	border:1px solid #ffffff;
	float:left;
	background:#979da2;
	color:#ffffff;
	padding:4px 2px 4px 10px;
	font-weight:bold;
}
.header-in-right button{
	float:left;
	background:url('../images/bt-ok.png') 0 0 no-repeat;
	width:36px;
	height:24px;
	border:none;
	cursor:pointer;
	position:relative;
	right:1px;
}
@media screen and (-webkit-min-device-pixel-ratio:0) {
	.header-in-right button{
		top:2px;
	}
}

.header-in-right div.search{
	margin:11px 0 0 0;
	height:1%;
	float:right;
	position:relative;
	z-index:1000;
}
.header-in-right div.menu{
	position:relative;
	top:31px;
}
@media screen and (-webkit-min-device-pixel-ratio:0) {
	.header-in-right div.menu{
		top:28px;
	}
}
.header-in-right div.menu li a{
	text-transform:uppercase;
	font-size:20px;
	position:relative;
	top:-2px;
	padding:0 15px 10px 12px;
}
.header-in-right div.menu li.rubrique0{
	padding:0 0 3px 0;
	margin:0 35px 0 0;
	position:relative;
}
.header-in-right div.menu li.rubrique1{
	padding:0 0 3px 0;
	margin:0 35px 0 0;
	position:relative;
}
.header-in-right div.menu li.rubrique2{
	padding:0 0 3px 0;
	position:relative;
}
.header-in-right div.menu li.rubrique0 a{
	border-left:5px solid #e644ac;
	float:left;
}
.header-in-right div.menu li.rubrique0 a span{
	/*background:url('../images/decouvrir.png') 0 0 no-repeat;*/
	width:110px;
	height:19px;
	display:block;
}
.header-in-right div.menu li.rubrique0:hover a span{
	/*background:url('../images/decouvrir-over.png') 0 0 no-repeat;*/
}
.header-in-right div.menu li.rubrique1 a{
	border-left:5px solid #02bdff;
	float:left;
}
.header-in-right div.menu li.rubrique1 a span{
	/*background:url('../images/sejourner.png') 0 0 no-repeat;*/
	width:113px;
	height:19px;
	display:block;
}
.header-in-right div.menu li.rubrique1:hover a span{
	/*background:url('../images/sejourner-over.png') 0 0 no-repeat;*/
}
.header-in-right div.menu li.rubrique2 a{
	border-left:5px solid #bcc601;
	float:left;
}
.header-in-right div.menu li.rubrique2 a span{
	/*background:url('../images/a-la-une.png') 0 0 no-repeat;*/
	width:85px;
	height:19px;
	display:block;
}
.header-in-right div.menu li.rubrique2:hover a span{
	/*background:url('../images/a-la-une-over.png') 0 0 no-repeat;*/
}
.header-in-right div.menu li.rubrique2 a{
	padding:0 15px 10px 15px;
}
.header-in-right div.menu li.rubrique0:hover a.element,
.header-in-right div.menu li.rubrique2:hover a.element,
.header-in-right div.menu li.rubrique1:hover a.element{
	text-decoration:none;
	background:#ffffff;
	position:relative;
	z-index:6;
}
.header-in-right div.menu li.rubrique0:hover div.ss-menu,
.header-in-right div.menu li.rubrique2:hover div.ss-menu,
.header-in-right div.menu li.rubrique1:hover div.ss-menu{
	display:block;
}

/****Diaporama****/
#header #header-container {
	width:960px;
	position: absolute;
	top:260px;
	overflow: hidden;
	left:50%;
	margin-left:-480px;
}
#header #headernav-outer {
	margin:0;
	position:static;
	top:0;
	width:auto;
	float:right;
}
#header #headernav {
	padding-left:0;
}
#header #headertxt {
	margin:0;
	position:static;
	top:0;
	width:auto;
	left:0;
	clear: right;
	overflow: hidden;
}
#header .btns-carres .btn {
	background-position:0 0;
	background-repeat:no-repeat;
	display:block;
	float:left;
	height:34px;
	overflow:hidden;
}
#header .btn {
	cursor:pointer;
}
#header .btns-carres #back span {
	background-image:url("/extension/ayaline/design/ayaline/images/carousel-previous.png");
	display:block;
	height:68px;
	width:28px;
}
#header .btns-carres #control span {
	background-image:url("/extension/ayaline/design/ayaline/images/carousel-pause.png");
	display:block;
	height:68px;
	width:20px;
}
#header .btns-carres #next span {
	background-image:url("/extension/ayaline/design/ayaline/images/carousel-next.png");
	display:block;
	height:68px;
	width:28px;
}
#header .btns-carres .btn:hover span, .header-controls .btn:focus span {
	margin-top:-34px;
}
#header #firstline {
	background:url("/extension/ayaline/design/ayaline/images/textbg.png");
	color:#313e47;
	display:block;
	float:left;
	font-size:45px;
	padding:4px 13px 7px;
	margin:0 0 2px 0;
}
#header #secondline {
	background:url("/extension/ayaline/design/ayaline/images/textbg-bis.png");
	clear:both;
	color:#ffffff;
	display:block;
	float:left;
	font-size:22px;
	padding:10px 13px;
	text-decoration:none;
}
/****Content****/
.content{
	width:1193px;
	margin:0 auto;
	padding:0 0 20px 0;
}
.bloc-left{
	width:833px;
	margin:0 23px 0 0;
	float:left;
}
.bloc-left-home{
	width:833px;
	float:left;
}
.bloc-right{
	width:337px;
	float:left;
}
.bloc-left-in{
	width:406px;
	margin:0 24px 0 0;
	float:left;
}
.bloc-right-in{
	width:402px;
	float:left;
}
/****Accueil****/
.bloc-type, .bloc-type-bis,
.bloc-left-in-bis .bloc-type{
	background:#ffffff;
	border:1px solid #e9e3de;
	padding:15px 23px 9px 23px;
	margin:0 0 15px 0;
}
.bloc-type-bis{
	margin:0 0 15px 0;
	padding:0;
}
.bloc-type h2{
	font-size:30px;
	color:#313131;
	float:left;
}
.bloc-type h3{
	padding:4px 0 17px 0;
}
.bloc-type h3.type1,
.bloc-type h3.type2,
.bloc-type h3.type3,
.bloc-type h3.type4,
.bloc-type h3.type5{
	font-size:22px;
	color:#e644ac;
}
.bloc-type h4{
	font-size:18px;
	color:#383838;
	padding:10px 0 7px 0;
}
.bloc-type img.spec{
	margin:0 -23px 0 -23px;
}
.bloc-type p{
	line-height:17px;
	padding:0 0 14px 0;
}
.lien-bas{
	text-align:right;
	padding:0 12px 0 0 !important;
}
.lien-bas a.type0,
.lien-bas a.type1,
.lien-bas a.type2,
.lien-bas a.type3,
.lien-bas a.type4{
	background:url('../images/picto1.gif') 0 50% no-repeat;
	padding:3px 0 3px 25px;
	color:#e644ac;
	font-weight:bold;
}
.lien-bas a.type2{
	background:url('../images/picto2.gif') 0 50% no-repeat;
	color:#ff8b33;
}
.bloc-type h3.type2{
	color:#ff8b33;
}
.bloc-type ul li{
	overflow:hidden;
	height:1%;
	padding:0 0 16px 0;
}
.bloc-type ul li h4{
	font-weight:bold;
	font-size:14px;
	text-transform:uppercase;
	padding:0 0 5px 0;
	margin:0;
}
.bloc-type ul li img{
	margin:0 14px 0 0;
	float:left;
}
.bloc-type ul li p{
	padding:0;
}
.bloc-type ul li p img {
    padding: 0 0 0 5px;
    float: right;
}
.lien-bas a.type3{
	background:url('../images/picto3.gif') 0 50% no-repeat;
	color:#02bdff;
}
.bloc-type h3.type3{
	color:#02bdff;
}
.lien-bas a.type4{
	background:url('../images/picto4.gif') 0 50% no-repeat;
	color:#337eb0;
}
.bloc-type h3.type4{
	color:#337eb0;
}
.spec p{
	line-height:13px;
}
.spec ul li{
	padding:0 0 20px 0;
}
.spec h4{
	text-transform:none !important;
	font-size:12px !important;
}
.bloc-type h3.type5{
	color:#ff8b33;
}
.bloc-type .form{
	margin:0 -15px 0 -15px;
	background:#ff8b33;
	padding:17px 31px 25px 19px;
}
.bloc-type .form p{
	color:#ffffff;
	font-weight:bold;
}
.bloc-type .form p label{
	font-weight:normal;
}
.bloc-type .form select{
	width:219px;
	border:1px solid #000000;
	font-size:11px;
}
.bloc-type .form label{
	color:#ffffff;
}
.bloc-type .form div.date select,
.bloc-type .form p.agenda{
	float:left
}
.bloc-type .form div.date select.small{
	width:38px;
}
.bloc-type .form div.date select.big{
	width:88px;
}
.bloc-type .form div.date select.middle{
	width:52px;
}
.bloc-type .form p.agenda img{
	margin:0 2px 0 0;
	vertical-align:middle;
}
.date p{
	padding:10px 0 6px 0 !important;
}
.date p.agenda{
	padding:0 !important;
}
.duree{
	overflow:hidden;
	height:1%;
	padding:11px 0;
}
.duree p{
	padding:0;
}
.duree select{
	width:77px !important;
}
.duree p.float-g{
	width:20%;
	padding:0;
}
.duree div{
	width:33%;
}
.situation label{
	float:left;
}
.situation select{
	width:152px !important;
	float:left;
	margin:0 0 0 3px;
}
.liste-bottom li a{
	background:url('../images/picto.gif') 0 50% no-repeat;
	padding:0 0 0 15px;
	color:#ffffff;
}
.liste-bottom li{
	padding:0 0 5px 0 !important;
}
button.button {
	background:none;
	border:none;
	cursor:pointer;
	padding:0 !important;
	margin:20px 0 15px 0;
	text-align:left;
	font-size:12px;
	font-family:arial;
	width:265px;
}
.bt-bg-hl{
	background:url('../images/bt-bg-hl.png') 0 0 no-repeat;
}
.bt-bg-hr{
	background:url('../images/bt-bg-hr.png') 100% 0 no-repeat;
}
.bt-bg-bl{
	background:url('../images/bt-bg-bl.png') 0 100% no-repeat;
}
.bt-bg-br{
	background:url('../images/bt-bg-br.png') 100% 100% no-repeat;
	padding:2px 6px 6px 4px;
}
.bt-bg-l{
	background:url('../images/bt-bg-l.png') 0 0 repeat-y;
}
.bt-bg-r{
	background:url('../images/bt-bg-r.png') 100% 0 repeat-y;
}
.bt-bg-t{
	background:#ffffff url('../images/bt-bg-t.png') 0 0 repeat-x;
}
.bt-bg-b{
	background:url('../images/bt-bg-b.png') 0 100% repeat-x;
}
.picto-bt {
	background:url('../images/loupe.gif') 0 50% no-repeat;
	color:#ff8b33;
	text-transform:uppercase;
	font-weight:bold;
	padding:3px 0 3px 21px;
	display:block;
}
.bg-a, .bg-b {
	background:url('../images/illustration10.png') 100% 0 no-repeat;
	padding:13px 0 31px 18px;
}
.bg-a h2,
.bg-b h2,
.bg-c h2{
	font-size:26px;
	font-weight:lighter;
	line-height:25px;
}
.bg-a p,
.bg-c p{
	padding:15px 181px 0 0;
	font-weight:bold;
	line-height:14px;
}
.bloc-type-bis .list-inline{
	overflow:hidden;
	height:1%;
	padding:10px 0 10px 0;
}
.bloc-type-bis .list-inline li{
	display:inline;
	float:left;
	margin:0 10px 0 0;
	padding:0;
}
.bloc-type-bis .list-inline li.lien-a a{
	background:url('../images/visite-virtuelle.png') 0 25% no-repeat;
	padding:7px 0 5px 34px;
	display:block;
}
.bloc-type-bis .list-inline li.lien-b a{
	background:url('../images/phototheque.png') 0 50% no-repeat;
	padding:7px 0 5px 34px;
	display:block;
}
.bloc-type-bis .list-inline li.lien-c a{
	background:url('../images/webcams.png') 0 50% no-repeat;
	padding:7px 0 5px 24px;
	display:block;
}
.bg-b{
	background:none;
	padding:13px 0 0 18px;
}
.bg-c{
	/*background:url('../images/illustration11.png') 97% 60% no-repeat;*/
	padding:13px 0 15px 18px;
}
.bg-c .lien-bas{
	text-align:left;
	margin:25px 0 0 0;
}
/********/
.footer ul li,
.footer ul li ul li ul.list-inline li{
	display:inline;
	float:left;
}
.footer ul li ul li ul.list-inline{
	overflow:hidden;
	height:1%;
}
.footer ul.list-block li{
	display:block;
	float:none;
}
.footer ul li{
	font-size:15px;
	text-transform:uppercase;
}
.footer ul.list-block li{
	font-size:12px;
	text-transform:none;
	padding:0 0 3px 0 !important;
}
.footer ul.list-block li a{
	color:#ffffff;
}
.footer ul.niv-1{
	background:url('../images/bg-ul.png') 0 0 repeat-y;
	overflow:hidden;
	height:1%;
}
.footer ul.niv-1 li{
	padding:0 55px 0 24px;
}
.footer ul.niv-1 li.first{
	padding:0 47px 0 0;
	width:137px;
}
.footer ul.niv-1 li.second{
	padding:0 32px 0 24px;
	width:196px;
}
.footer ul.niv-1 li.third{
	padding:0 45px 0 24px;
}
.footer ul.niv-1 li.fourth{
	padding:0 37px 0 24px;
}
.footer ul.niv-1 li.fifth{
	padding:0 0 0 24px;
}
.footer ul.niv-1 li.last{
	padding:0 0 0 60px;
}
.footer ul.niv-1 li ul li{
	padding:0;
}
.list-block li.parag{
	overflow:hidden;
	height:1%;
	padding:0 0 10px 0 !important;
}
.list-block li.parag img{
	float:left;
	margin:0 26px 0 0;
	vertical-align:middle;
}
.list-block li.parag p{
	float:left;
	width:120px;
	padding:15px 0 0 0;
}
.list-block li.parag p a{
	color:#ffffff;
}
.footer ul.niv-1 li ul.list-block{
	margin:18px 0 0 0;
}
.footer .niv-2{
	display:inline;
	float:left;
	margin:33px 0 0 0;
}
.footer .niv-2 li a{
	text-transform:none;
	color:#ffffff;
	font-size:12px;
	padding:0 10px;
}
.footer .niv-2 li.first a{
	padding:0 10px 0 0;
}
.footer ul li div.bg-l{
	float:left;
	display:block;
	background:url('../images/bg-f-l.png') 0 0 no-repeat;
	padding:0 0 0 3px;
	margin:10px 0 0 0;
}
.footer ul li div.bg-l div.bg-r{
	float:left;
	display:block;
	background:url('../images/bg-f-r.png') 100% 0 no-repeat;
}
.footer ul li div.bg-l div.bg-r ul li{
	display:inline;
	float:left;
	padding:0 5px 0 0 !important;
}
.footer ul li div.bg-l div.bg-r ul li.last{
	padding:0 !important;
}
ul li.partager a{
	background:url('../images/partager.gif') 0 50% no-repeat;
	padding:0 0 0 15px;
	font-size:11px;
	text-transform:uppercase;
	color:#000000 !important;
	text-decoration:none;
}
.footer ul li div.bg-l div.bg-r ul{
	padding:0 5px 0 0;
}
.footer ul li div.bg-l div.bg-r span{
	color:#000000;
}
/***Select-Header**/
.Header .Top_Header form span.input_right{
	background:url("/extension/ayaline/design/ayaline/images/input_right.png") 0 0 no-repeat;
	position:absolute;
	width:11px;
	height:24px;
	top:-1px;
	right:0;
}
.conteneurSelect{
	position:relative;
	z-index:200;
	padding:0;
	float:left;
	top:3px;
}
.conteneurSelect .inputsSelect{
	/*background:#ffffff url("/extension/ayaline/design/ayaline/images/select.gif") 95% 50% no-repeat;*/
	position:relative;
	/*border:1px solid #999;*/
	text-align:center;
	float:left;
}
.inputsSelect .selects{
	padding:1px;
	font-size:11px;
	cursor:pointer;
	width:42px;
	white-space:nowrap;
	overflow:hidden;
	color:#8a8a8a;
}
.inputsSelect ul{
	/*position:absolute;*/
	text-align:left;
	/*border:1px solid #999;*/
	padding:1px;
	/*display:none;*/
	/*background:#ffffff;*/
	z-index:200;
	list-style:none;
	margin:0;
	/*left:-1px;*/
	/*width:42px;*/
}
.inputsSelect ul li span.Flag_en,
.inputsSelect p span.Flag_en{
	background:url("/extension/ayaline/design/ayaline/images/en_flag.png") 0 50% no-repeat;
	font-size:11px;
	color:#8A8A8A;
	width:20px;
	height:14px;
	display:block;
}
.inputsSelect ul li span.Flag_fr,
.inputsSelect p span.Flag_fr{
	background:url("/extension/ayaline/design/ayaline/images/fr_flag.png") 0 50% no-repeat;
	font-size:11px;
	color:#8A8A8A;
	width:20px;
	height:14px;
	display:block;
}
.inputsSelect ul li a{
	display:block;
	cursor:pointer;
	text-decoration:none;
	width:100%;
}
.inputsSelect ul li a:hover{
	color:#fff;
	background:#093e6d;
	text-decoration:none;
}
ul#listeSelect1 li{
	/*float:none;*/
	display:inline;
	margin-left: 5px;
}
ul#listeSelect1 li:first-child{
	margin-left: 0px;
}
.l-spacing{
	letter-spacing:-1px;
}
.bloc-type .float-d img{
	position:relative;
	top:2px;
}
/****Visites excursions****/
.fil-ariane{
	font-size:11px;
	margin:0 auto;
	padding:0 0 5px 0;
	width:1193px;
}
.bloc-left-bis{
	margin:0 7px 0 0 !important;
	width:883px;
	float:left;
}
.bloc-left-in-bis{
	width:214px;
	margin:0 7px 0 0;
	float:left;
}
.bloc-left-in-bis .bloc-type{
	margin:0;
	padding:15px 5px 50px 10px !important;
}
.bloc-right-in-bis{
	width:660px;
	float:left;
}
.bloc-right-bis{
	width:303px;
	float:left;
}
.bloc-left-in-bis .bloc-type{
	padding:15px 5px 9px 10px;
}
ul.menu-left{
	margin:9px 0 0 0;
}
ul.menu-left li.actif span{
	background:#303a43 url('../images/picto-on.png') 6px 50% no-repeat;
	color:#ffffff;
	font-weight:bold;
	padding:5px 0 5px 22px;
	display:block;
	margin:0;
	cursor:pointer;
}
ul.menu-left li.actif{
	background:none !important;
}
ul.menu-left li.actif ul li{
	background:#efefee !important;
	border-bottom:1px solid #ffffff;
	padding:0;
	margin:0;
}
ul.menu-left li.actif ul li a{
	background:none !important;
	padding:5px 0 5px 6px;
	color:#303a43;
	font-weight:normal;
	display:block;
}
ul.menu-left li.actif ul li ul.s-menu-in li{
	border:none;
}
ul.menu-left li.actif ul li ul.s-menu-in li.actif a{
	font-weight:bold;
}
ul.menu-left li.actif:hover a,
li.actif ul li:hover a,
ul.menu-left li:hover a{
	text-decoration:none;
}
ul.menu-left li span{
	background:url('../images/picto-off.png') 6px 50% no-repeat;
	color:#303a43;
	font-weight:bold;
	padding:5px 0 5px 22px;
	display:block;
	margin:0;
	cursor:pointer;
}
ul.menu-left li{
	background:#cbced0 !important;
	padding:0;
	margin:0 0 5px 0;
}
ul.menu-left li.actif ul.s-menu{
	display:block;
}
ul.menu-left li ul.s-menu{
	display:none;
}
.chapeau{
	font-size:14px;
	font-weight:bold;
	padding:24px 0 25px 0 !important;
	border-bottom:1px solid #E9E3DE;
	margin:0 0 24px 0;
}
.list,
.liste{
	overflow:hidden;
	height:1%;
	position:relative;
}
.list li,
.liste li{
	display:inline;
	float:left;
	padding:0 18px 18px 18px !important;
	border:1px solid #E9E3DE;
	width:251px;
	background:#F6EFE9;
	margin:0 0 34px 0;
}
.list li h3 img{
	/*float:left !important;*/
}
.list li h3.small-space img{
	margin:12px 0 7px 0 !important;
}
.list li h3,
.liste li h3{
	padding:0;
}
.list li h3.big-space img{
	margin:12px 0 17px 0 !important;
}
.liste li h3.big-space img{
	margin:12px 0 8px 0 !important;
}
.list li img,
.liste li img{
	float:none !important;
	margin:0 !important;
}
.list li.first{
	margin:0 28px 34px 0;
}
ul.list li p,
ul.liste li p{
	padding:5px 0 13px 0;
}
ul.list .lien-bas,
ul.liste .lien-bas{
	text-align:left;
	padding:0;
	overflow:hidden;
	height:1%;
	/*bottom:15px;
	position:absolute;*/
}
ul.list .lien-bas a,
ul.liste .lien-bas a,
.cp-coeur .lien-bas a{
	background:url("/extension/ayaline/design/ayaline/images/picto-noir.png") no-repeat scroll 0 50% transparent;
	color:#000000;
	font-weight:bold;
	padding:3px 0 3px 25px;
}
ul.list-right{
	margin:14px 0 0 0;
}
.list-right li img{
	float:left;
	margin:0 8px 0 0;
}
.list-right li{
	border-bottom:1px solid #E9E3DE;
	padding:0 0 10px 0 !important;
	margin:0 0 10px 0;
}
.list-right li.last{
	border:none;
	padding:0;
	margin:0;
}
.list-right li h3{
	padding:0;
	margin:0;
}
.list-right p{
	font-size:10px;
	margin:-2px 0 0 0;
}
.list-right p.pos-r{
	position:relative;
	top:15px;
	left:-32px;
}
.list-right .link,
.list-right .link-bis{
	background:url('../images/bg-btn-r-tl.png') 0 0 no-repeat #f13db7;
	float:right;
	position:relative;
	left:-96px;
	top:10px;
}
.list-right .bg-btn-r-tr{
	background:url('../images/bg-btn-r-tr.png') 100% 0 no-repeat;
}
.list-right .bg-btn-r-bl{
	background:url('../images/bg-btn-r-bl.png') 0 100% no-repeat;
	display:block;
}
.list-right .link a{
	background:url('../images/bg-btn-r-br.png') 100% 100% no-repeat;
	padding:2px 5px;
	color:#ffffff;
	font-weight:bold;
	display:block;
}
.list-right .link a:hover{
	text-decoration:none;
}
/****Mediathiaque photo****/
.bloc-search{
	background:#f6efe9;
	border:1px solid #E9E3DE;
	padding:21px 0 21px 23px;
	margin:14px 102px 18px 0;
}
.bloc-search input,
.bloc-search select{
	width:260px;
	border:1px solid #cfcfcf;
}
.bloc-search input{
	margin:0 15px 0 0;
	padding:1px 0 1px 10px;
	width:250px;
}
.bloc-search legend{
	float:left;
	font-size:14px;
	font-weight:bold;
	padding:0 18px 0 0;
}
.bloc-search button{
	border:none;
	background:#e644ac;
	color:#ffffff;
	font-weight:bold;
	font-family:arial;
	font-size:12px;
	padding:2px 15px;
	cursor:pointer;
}
.menu-h{
	border-bottom:1px solid #E9E3DE;
	margin:0 102px 0 0;
	padding:0 0 0 23px;
}
.menu-h ul li{
	display:inline;
	float:left;
	padding:0;
	position:relative
}
.menu-g-on {
	background:url('../images/bg-l-on.png') 0 0 no-repeat;
	display:block;
	float:left;
	padding:0 0 0 4px;
}
.menu-d-on {
	background:url('../images/bg-r-on.png') 100% 0 no-repeat;
	display:block;
	float:left;
	padding:14px 58px 12px 38px;
	font-weight:bold;
	font-size:16px;
}
.menu-g-off {
	background:url('../images/bg-l-off.png') 0 0 no-repeat;
	display:block;
	float:left;
	padding:0 0 0 4px;
}
.menu-d-off {
	background:url('../images/bg-r-off.png') 100% 0 no-repeat;
	display:block;
	float:left;
	padding:14px 48px 8px 38px;
	font-size:14px;
}
.menu-h ul li.actif{
	top:2px;
}
.menu-h ul li.first{
	margin:0 20px 0 0;
}
.menu-h ul li{
	top:9px;
}
li:hover a.menu-g-off {
	text-decoration:none;
}
.cadre-t{
	background:url('../images/bkg-t.png') 0 0 repeat-x;
}
.cadre-b{
	background:url('../images/bkg-b.png') 0 100% repeat-x;
}
.cadre-l{
	background:url('../images/bkg-l.png') 0 0 repeat-y;
}
.cadre-r{
	background:url('../images/bkg-r.png') 100% 0 repeat-y;
}
.cadre-tl{
	background:url('../images/bkg-tl.png') 0 0 no-repeat;
}
.cadre-tr{
	background:url('../images/bkg-tr.png') 100% 0 no-repeat;
}
.cadre-bl{
	background:url('../images/bkg-bl.png') 0 100% no-repeat;
}
.cadre-br{
	background:url('../images/bkg-br.png') 100% 100% no-repeat;
	padding:6px 14px 14px 8px;
	overflow:hidden;
	height:1%;
}
.bloc-container{
	padding:50px 0 0 35px;
}
.bloc-container ul{
	overflow:hidden;
	height:1%;
}
.bloc-container ul li{
	display:inline;
	float:left;
	overflow:hidden;
	height:1%;
	padding:0;
	margin:0 46px 37px 0;
}
.cadre-br img{
	margin:0 !important;
	float:none !important;
}
.bloc-container ul li p{
	text-align:center;
	font-weight:bold;
	font-size:14px;
}
.pagination{
	background:#e5dcd3;
	border:1px solid #d6cdc4;
	padding:5px 0 5px 498px;
	overflow:hidden;
	height:1%;
	margin:0 90px 0 26px;
	text-align:center;
}
.pagination ul li{
	display:inline;
	float:left;
	margin:0 10px 0 0;
	padding:0;
}
.pagination ul li.actif a{
	font-weight:bold;
}
.padding-tl{
	padding:35px 0 10px 41px;
}
.padding-35px-32px{
	padding:35px 25px 10px 32px;
}
/****Decouvrir****/
/*.container-list-3col li.niv{
	background:url('../images/border-b-list-3col.png') 0 100% no-repeat;
	width:825px;
}
.container-list-3col .list{
	background:url('../images/bg-list-3col.png') 0 0 repeat-y;
}*/
.liste li{
	width:226px;
	padding:0 15px 15px !important;
	margin:0 25px 34px 0;
}
.liste li.last{
	margin: 0px 0px 34px 0px;
}
ul.liste .lien-bas{
	bottom:11px;
}/**/
/*.container-list-3col .list-2col{
	background:url('../images/bg-list-2col.png') 0 0 repeat-y;
}
.border-2col{
	background:url("/extension/ayaline/design/ayaline/images/border-b-list-2col.png") no-repeat scroll 0 100% transparent !important;
	width:540px !important;
}*/
.list-agenda{
	margin:14px 0 0 0;
}
.list-agenda h3{
	font-size:11px;
	text-transform:uppercase;
	padding:0;
	margin:0 0 3px 0;
}
.l-spacing{
	font-size:11px;
	letter-spacing:0;
	line-height:14px !important;
}
.pagination ul.pagin{
	float:left;
	margin:0 150px 0 300px;
}
.no-margin{
	padding:5px 0 5px 0;
	margin:0;
}
.pagination p{
	padding:0;
}
/****Sous menu****/
.ss-menu{
	background:#f6efe9 url('../images/bg-ss-menu.png') 0 0 repeat-x;
	padding:12px 15px;
	position:absolute;
	top:27px;
	width:585px;
	border-left:1px solid #E9E3DE;
	border-bottom:1px solid #E9E3DE;
	border-right:1px solid #E9E3DE;
	left:-146px;
	z-index:5;
	display:none;
}
.ss-menu .top{
	margin:0 10px 11px 0;
	overflow:hidden;
	height:1%;
}
.ss-menu .top li{
	display:inline;
	float:left;
	margin:0 5px 0 0;
}
.top li input{
	background:#f6efe9;
	padding:0 4px !important;
	text-transform:none !important;
	font-size:14px !important;
	font-weight:bold;
	border-left:none !important;
	width:auto !important;
	cursor:pointer;
}
.rubrique0 .top li input{
	color:#e644ab !important;
}
.rubrique1 .top li input{
	color:#02bdff !important;
}
.top li a:hover{
	text-decoration:none;
}
.bottom h2 a, .bottom-2 h2 a{
	color:#e644ab !important;
	font-size:14px !important;
	text-transform:none !important;
	float:none !important;
}
.bottom-2 h2 a{
	color:#00bcd6 !important;
}
.bottom li, .bottom-2 li{
	background:url('../images/border.png') 0 0 repeat-x;
	display:inline;
	float:left;
	padding:11px 0 11px 0;
	width:275px;
	margin:0 28px 0 0;
}
.bottom-2 li.first{
	background:transparent none;
}
.bottom li.right, .bottom-2 li.right{
	margin:0;
}
.bottom p, .bottom-2 p{
	font-size:11px;
}
.bottom li a, .bottom-2 li a{
	border-left:none !important;
	padding:0 !important;
	position:static !important;
	top:0 !important;
}
.bottom li a img, .bottom-2 li a img{
	margin:0 15px 0 0;
}
.rubrique0 .ss-menu li.actif input{
	background:#e843ab;
	color:#ffffff !important;
}
.rubrique1 .ss-menu li.actif input{
	background:#02bdff;
	color:#ffffff !important;
}
/****Photo detail****/
.bloc-container h3{
	font-size:18px;
}
.bloc-container .container-diapo{
	padding:0 106px 0 65px;
}
.bloc-container .slider{
	padding:12px;
	border:1px solid #E9E3DE;
	margin:0 119px 96px 0;
}
/****Videotheque liste****/
.box-img{
	padding:4px !important;
	border:1px solid #E9E3DE !important;
	float:left !important;
	margin:0 19px 0 0;
}
.box-img img{
	float:none !important;
	margin:0 !important;
}
.bloc-container h3.titre{
	padding:0 0 5px 0;
}
.bloc-container p.text{
	text-align:left;
	font-weight:normal;
	font-size:12px;
	padding:0;
}
.bloc-container .list-video li{
	border-bottom:1px solid #E9E3DE;
	padding:21px 0;
	display:block;
	float:none;
	height:1%;
	margin:0;
	overflow:hidden;
}
.bloc-container .list-video li.first{
	padding:0 0 21px 0;
}
.bloc-container .list-video li.last{
	padding:21px 0 0 0;
	border:none;
}
.bloc-container .list-video{
	margin:0 214px 40px -11px;
}
/****popup***/
.popin-voile {
	background:#000000;
	height:0;
	left:0;
	position:fixed;
	top:0;
	width:100%;
	z-index:5000;
}
.popin {
	left:27%;
	position:absolute;
	top:145%;
	z-index:5500;
}
/****Page promenades mer****/
ul.list-thm li{
	display:inline;
	float:left;
	padding:0;
}
ul.list-thm{
	overflow:hidden;
	height:1%;
	padding:0 0 23px 0;
}
ul.list-thm li.first{
	padding:0 18px 0 0;
}
ul.list-thm li{
	padding:0 5px 0 0;
}
ul.list-thm li.last{
	padding:0;
}
ul.list-thm li img{
	float:none;
	margin:0;
}
form.form-search{
	background:#faf9f7;
	padding:6px 0 21px 6px;
	margin:19px 0 0 0;
}
form.form-search label{
}
form.form-search p{
	padding:0;
}
form.form-search input{
	padding:0;
	margin:0;
	position:relative;
	top:2px;
}
form.form-search p.margin-b{
	padding:0 0 6px 0;
}
form.form-search select{
	width:179px;
}
form.form-search div.date select{
	width:auto;
	border:1px solid #000000;
	font-size:11px;
}
form.form-search p.agenda{
	float:left;
	position:relative;
	top:2px;
}
form.form-search div.date{
	margin:0 0 10px 0;
}
form.form-search button{
	background:#303a42;
	color:#ffffff;
	width:85px;
	text-align:center;
	padding:1px 0 !important;
	margin:23px 0 0 0;
}
form.form-search div.margin-b{
	padding:0 0 18px 0;
}
ul.border{
	padding:20px 0 0 0;
	border-top:1px solid #F6EFE9;
	margin:24px 0 0 0;
}
ul.list p.ss-titre{
	color:#e644ac;
	font-style:italic;
	font-weight:bold;
	padding:0 0 7px 0;
}
ul.list p.ss-titre span span{
	font-size:14px;
	background:none;
	display:inline;
}
ul.list p.ss-titre span.picto{
	display:block;
	background:url('../images/price.png') 100% 0 no-repeat;
	padding:4px 0 1px 0;
}
p.lien-bas a.reserver{
	background:#ff8b33 !important;
	color:#ffffff;
	font-weight:bold;
	padding:3px 8px !important;
	float:right;
	margin:0 -12px 0 0;
}
p.lien-bas a:hover.reserver{
	text-decoration:none;
}
p.lien-bas a.dispos{
	background:#fff !important;
	color:#ff8b33;
	border:1px solid #ff8b33;
	font-weight:bold;
	padding:2px 8px !important;
	float:right;
	margin:0 2px 0 0;
}
p.lien-bas a:hover.dispos{
	text-decoration:none;
}
.cp-coeur .lien-bas{
	text-align:right;
}
.cp-coeur{
	padding:15px 13px 9px !important;
}
.cp-coeur h2{
	margin:0 0 12px 0;
}
.cp-coeur h3{
	font-size:14px;
	padding:10px 0 13px 0;
}
ul li.spec-bis{
	padding:0 18px 10px 18px !important;
}
/****Liste hôtels****/
ul.bloc-search-left li span {
	background:url("/extension/ayaline/design/ayaline/images/fleche-r.png") no-repeat scroll 98% 50% #303A43;
	color:#FFFFFF;
	display:block;
	font-weight:normal;
	margin:0;
	padding:2px 0 2px 4px;
}
ul.bloc-search-left li ul.champs {
	background:#faf9f7;
	padding:11px 0 11px 4px;
}
ul.bloc-search-left li ul.champs li{
	padding:0 0 2px 0;
}
ul.bloc-search-left li ul.champs li.last{
	padding:0;
}
ul.bloc-search-left li ul.champs li input{
	float:right;
}
ul.bloc-search-left li ul.champs li label{
	float:left;
}
form.form-search-left h3{
	padding:0 0 7px 0;
}
h2.margin-b{
	margin:0 0 19px 0;
}
ul.bloc-search-left li{
	padding:0 0 12px 0;
}
.chapeau-bis{
	padding:22px 0 17px 0 !important;
	line-height:15px !important;
}
p.map{
	border:1px solid #E9E3DE;
	padding:0;
	margin:0 0 8px 0;
}
.picto-hotel{
	background:url('../images/picto-hotel.png') 0 50% no-repeat;
	padding:6px 0 7px 28px;
	display:block;
	margin:0 0 13px 0;
}
div.pagination p.padding-l{
	padding:0 0 0 10px;
}
ul.ss-titre-bis li{
	display:inline;
	float:left;
	margin:0;
	padding:0 5px 0 0 !important;
	width:auto;
	border:none;
	background:url('../images/separator.png') 100% 50% no-repeat;
}
ul.ss-titre-bis li.last{
	background:none;
	padding:0 0 0 5px !important;
	font-weight:bold;
}
ul.ss-titre-bis li.pas-hotel{
	background:none;
}
ul.ss-titre-bis{
/*	clear: left;*/
	overflow:hidden;
	height:1%;
	margin:0 0 8px 0;
}
.list-inline-bis{
	overflow:hidden;
	height:1%;
	margin:11px 0 20px 0;
}
.list-inline-bis h3{
	padding:13px 0 10px 0;
}
.list-inline-bis li{
	display:inline;
	float:left;
	padding:13px 15px 9px 15px !important;
	background:#faf9f7;
	border:1px solid #e5e2dd;
	width:278px;
}
.list-inline-bis li.first{
	margin:0 16px 0 0;
}
.list-inline-bis li img{
	float:none !important;
	margin:0 !important;
	padding: 0 3px 0 3px;
}
p.ss-titre{
	color:#00bbd6 !important;
	font-style:italic !important;
	font-weight:bold;
	padding:0 0 8px 0 !important;
}
.list-inline-bis li p.lien-bas a, .list-block-bis li p.lien-bas a{
	background:url("/extension/ayaline/design/ayaline/images/picto-noir.png") no-repeat scroll 0 50% transparent;
	font-weight:bold;
	padding:3px 0 3px 25px;
}
.list-inline-bis li p.lien-bas, .list-block-bis li p.lien-bas{
	text-align:left;
}
/*
.list-inline-bis li p.lien-bas a.picto3,
.list-block-bis li p.lien-bas a.picto3{
	background:url("/extension/ayaline/design/ayaline/images/picto3.gif") no-repeat scroll 0 50% transparent;
	font-weight:bold;
	padding:3px 0 3px 25px;
}
*/
.list-inline-bis li p.text,
.list-block-bis li p.text{
	line-height:15px;
	padding:9px 0 12px 0;
}
.padding-lr{
	padding:15px 11px 9px;
}
.list-block-bis{
	background:#faf9f7;
}
.list-block-bis img{
	margin:0 !important;
}
.list-block-bis img,
.list-block-bis div{
	float:left;
}
.list-block-bis div{
	width:414px;
}
.list-block-bis div.titre-container{
	padding:0;
	width:auto;
	float:none;
	border-left:1px solid #d2cbc5;
	padding:0 0 0 8px;
	position:relative;
}
.list-block-bis li{
	padding:11px 14px 11px 14px !important;
	border-top:1px solid #D2CBC5;
}
.list-block-bis h3{
	padding:0 0 7px 0 !important;
	font-size:14px;
	overflow:hidden;
	height:1%;
}
.list-block-bis ul.ss-titre-bis{
	font-size:11px;
}
.list-block-bis li p.text{
	padding:0 0 12px 6px;
}
.list-block-bis p.ss-titre{
	font-size:11px !important;
	padding:0 0 8px 6px !important;
}
.list-block-bis p.ss-titre span span{
	font-size:12px !important;
}
.list-block-bis h3 span img{
	position:relative;
	top:2px;
	margin:0 1px 0 0 !important;
}
.list-block-bis h3 span.nom{
	margin:0 10px 0 0;
}
.list-block-bis p.lien-bas{
	padding:0 12px 0 6px !important;
}
.list-block-bis div.titre-container p{
	/*position:absolute;
	right:110px;
	top:5px;*/
	float:right;
}
/****page contenu****/
div.chapeau {
	font-size:13px;
	font-weight:bold;
	font-style:italic;
	text-align:justify;
	background:#F6EFE9;
	border:1px solid #E9E3DE;
	padding:18px 19px 22px 14px !important;
	margin:10px 0 0 0;
}
div.chapeau p{
	line-height:15px !important;
}
div.chapeauMedia {
	font-size:14px;
	font-weight:bold;
	padding:24px 0 25px 0 !important;
	border-bottom:1px solid #E9E3DE;
	margin:0 0 24px 0;
}
.bloc-content p.padding-b-5px{
	padding:0 0 5px 0 !important;
}

div.chapeau img{
	float:left;
	margin:0 16px 0 0;
}
.bloc-content{
	padding:14px 5px 20px 14px;
}
.bloc-content p{
	text-align:justify;
}
.bloc-content h3{
	font-weight:bold;
	font-size:14px;
	padding:14px 0 11px 0;
}
.bloc-content span{
	color:#f340b8;
}
.bloc-content img.float-d{
	margin:0 0 0 11px;
}
.bloc-content img.float-g{
	margin:0 11px 0 0;
}
.bloc-content ul li span{
	color:#000000;
	background:url('../images/puce-contenu.png') 0 3px no-repeat;
	display:block;
	padding:0 0 0 12px;;
}
.bloc-content ul li{
	padding:0 0 5px 0 !important;
}
.bloc-content ul{
	margin:0 0 12px 0;
}
/*****ss-menu à la une****/
.rubrique2 .ss-menu{
	width:425px;
	background:#FAF5F2 url('../images/bg-ss-menu-rubrique2.png') 0 0 repeat-x;
	border-left:1px solid #E9E3DE;
	border-right:1px solid #E9E3DE;
	border-bottom:1px solid #E9E3DE;
	display:none;
	right:0;
	padding:18px 30px 18px 15px;
	position:absolute;
	top:27px;
	z-index:5;
	left:auto;
}
.rubrique2 .ss-menu ul li{
	display:inline;
	float:left;
	border-right:1px solid #E9E3DE;
	padding:0 9px 0 0;
}
.rubrique2 .ss-menu ul li.right{
	border:none;
	padding:0;
}
.rubrique2 .ss-menu ul li div.border{
	background:url("/extension/ayaline/design/ayaline/images/border.png") repeat-x scroll 0 100% transparent;
	padding:0 64px 8px 0;
}
.rubrique2 .ss-menu ul li div p{
	font-size:11px;
}
.rubrique2 .ss-menu ul li div p.text{
	font-size:14px;font-weight:bold;
	padding:10px 0 16px 0;
}
.rubrique2 .ss-menu ul li div p span{
	display:block;
}
.rubrique2 .ss-menu ul li div p span.spec{
	color:#bcc701;
	font-weight:bold;
}
.rubrique2 .ss-menu ul li div p strong{
	display:block;
}
.rubrique2 .ss-menu ul li ul.list-in li{
	display:block;
	float:none;
	padding:0 0 2px 0;
	border:none;
/*	width:auto;*/
	width:120px;
}
.rubrique2 .ss-menu ul li ul.list-in li.last{
	padding:17px 0 0 0;
}
.rubrique2 .ss-menu ul li ul.list-in li a{
	padding:0;
	border:none;
	float:none;
	font-size:12px;
	color:#000000;
	font-weight:bold;
	text-transform:none;
}
.rubrique2 .ss-menu ul li div img{
	float:left;
	margin:0 24px 0 0;
}
.rubrique2 .ss-menu ul li div.border img{
	margin:0 33px 0 0;
}
.rubrique2 .ss-menu ul li ul.list-in{
	float:left;
	width:65px;
}
.rubrique2 .ss-menu ul li.right p.title{
	font-size:14px;
	font-weight:bold;
	padding:0;
}
.rubrique2 .ss-menu ul li.right span{
	color:#bcc701;
	font-weight:bold;
}
.rubrique2 .ss-menu ul li.right p{
	font-size:11px;
	width:192px;
	padding:15px 0 10px 0;
}
.rubrique2 .ss-menu ul li{
	width:200px;
}
.rubrique2 .ss-menu ul li.right{
	padding:0 0 0 22px;
	width:auto;
}
.rubrique2 .ss-menu ul li.right img{
	border:1px solid #E9E3DE;
	margin:0 0 6px 0;
}
.lien-bas a.type5 {
	background:url("/extension/ayaline/design/ayaline/images/picto5.gif") no-repeat scroll 0 50% transparent;
	font-weight:bold;
	font-size:12px !important;
	color:#000000;
	text-transform:none !important;
	border:none !important;
	float:none !important;
	padding:3px 0 3px 20px !important;
	position:static !important;
}
p.lien-bas{
	width:auto !important;
	padding:0 5px 0 0 !important;
}
/*****ss-menu Sejourner****/
.rubrique1 .ss-menu{
	left:-325px;
}
/****Fiche hotel****/
.box-left{
	width:326px;
	margin:0 16px 0 0;
	float:left;
}
.box-right{
	width:294px;
	float:left;
}
.box-right .ss-titre-bis{
	padding:6px 0 0 0;
}
.box-right .ss-titre{
	font-size:13px;
	float:left;
	padding:0 21px 0 0 !important;
}
/*.box-right p.lien-bas a.reserver {
	float:left;
}
.box-right p.lien-bas a.dispos {
	float:left;
}*/
.box-right ul.inline{
	overflow:hidden;
	height:1%;
	padding:0 0 12px 0;
}
.box-right ul.inline li{
	display:inline;
	float:left;
	padding:0;
}
.box-right div a{
	color:#00bbd4;
}
.box-right div ul.inline{
	overflow:hidden;
	height:1%;
	margin:34px 0 0 0;
	padding:0;
}
.box-right div ul.inline li{
	display:inline;
	float:left;
	padding:0 1px 0 0;
}
.box-right div ul.inline li a{
	display:block;
	padding:5px 8px;
	text-transform:uppercase;
	background:#f5f2ef;
	color:#000000;
	font-size:10px;
}
.box-right div ul.inline li.actif a{
	font-weight:bold;
	background:#ece5df;
}
.box-right div ul.inline li.last a{
	background:#7ad6e1;
	color:#ffffff;
	padding:5px 9px;
}
.box-right div ul.inline li a:hover{
	text-decoration:none;
}
.box-right div.texte{
	margin:8px 0 0 0;
	border:1px solid #ece5df;
	/*padding:16px 11px 0 11px;*/
	padding:10px;
}
.box-right div.texte p{
	line-height:14px;
}
.padd-t12px-b14px{
	padding:12px 0 14px 0 !important;
	line-height:14px !important;
}
.box-left div ul.inline li{
	display:inline;
	float:left;
	padding:0 7px 0 0;
}
.box-left div ul.inline li.last{
	padding:0;
}
.box-left div ul.inline li img{
	margin:0;
}
.box-left div.list-img{
	background:#ece5df;
	padding:14px 5px;
	overflow:hidden;
	height:1%;
	width:314px;
	margin:0 0 17px 0;
}
.box-left div ul.inline li.prev,
.box-left div ul.inline li.next{
	position:relative;
	top:12px;
}
.box-left div ul.inline li.separator{
	position:relative;
	top:5px;
}
.box-left .map{
	margin:0;
}
.box-left .form-rech span{
	display:block;
	background:#303a42;
	color:#ffffff;
	padding:10px 0 10px 9px;
	font-weight:bold;
}
.box-left .form-rech form{
	background:#c0c4c6;
	font-size:11px;
	padding:12px 0 26px 11px;
	overflow:hidden;
	height:1%;
}
.box-left .form-rech div.date p, .box-left .form-rech div.date label,
.box-left .form-rech div.date select{
	float:left;
}
.box-left .form-rech div.date p.label,
.box-left .form-rech p.float-g{
	padding:0 !important;
	width:25%;
}
.box-left .form-rech input{
	padding:0 !important;
	margin:0 !important;
}
.box-left .form-rech select{
	font-size:11px;
}
select#nbre-semaine{
	margin:0 0 0 20px;
}
.nbr{
	padding:0 0 11px 0;
	overflow:hidden;
	height:1%;
}
.box-left .form-rech .button{
	background:#ff8b33;
	color:#ffffff;
	font-weight:bold !important;
	padding:3px 7px !important;
	font-size:11px;
	margin:5px 0 0 78px !important;
	text-align:left !important;
	width:180px !important;
}
.bloc-stars{
	padding:3px 0 0 0 !important;
	overflow:hidden;
	height:1%;
}
.bloc-stars img{
	margin:0 !important;
}
.list-right .link-bis{
	background:url('../images/bg-btn-r-bis-tl.png') 0 0 no-repeat #02bdff;
	top:19px;
}
.list-right .link-bis .bg-btn-r-tr{
	background:url('../images/bg-btn-r-bis-tr.png') 100% 0 no-repeat;
}
.list-right .link-bis .bg-btn-r-bl{
	background:url('../images/bg-btn-r-bis-bl.png') 0 100% no-repeat;
	display:block;
}
.list-right .link-bis a{
	background:url('../images/bg-btn-r-bis-br.png') 100% 100% no-repeat;
	padding:2px 5px;
	color:#ffffff;
	font-weight:bold;
	display:block;
}
.list-right .link-bis a:hover{
	text-decoration:none;
}
.space{
	height:20px;
}
.form-rech .width-auto{
	width:auto;
}
.form-rech p.agenda img{
	margin:2px 0 0 0;
}

/*** Fiche normale ***/
.ss-titre.apartirde{
	margin: 0px 0px 5px 15px;
}

/*********************/
/*** Ajouts Alexia ***/
/*********************/

/*** General ***/
.menu .ss-menu p{
	color:#000000;
}

#langue.conteneurSelect{
    z-index: 2000;
}

.header-in-right .list-top .first{
	text-transform:capitalize;
	margin-right:0px;
	padding-top: 5px;
}

.header-in-right div.menu li a span{
	font-family: 'OmnesMedium', Arial, sans-serif !important;
	color: white;
}
.header-in-right div.menu li:hover.rubrique0 a span{
	color: #E644AC;
}
.header-in-right div.menu li:hover.rubrique1 a span{
	color: #02BDFF;
}
.header-in-right div.menu li:hover.rubrique2 a span{
	color: #BCC601;
}

.align-center{
	text-align: center;
}

.lien-bas a.type0{
	background:url('../images/picto-noir.png') 0 50% no-repeat;
	color:black;
}

.footer p{
	padding:5px 0 0 0 !important;
}
.footer .contenu a{
	text-decoration: none;
}
.footer .contenu a:hover{
	text-decoration: underline;
}


/*** Page de contenu ***/
h2.titre-normal{
	font-size: 28px;
	color: black;
	float: none;
	padding: 5px 0px 5px 0px;
}
h3.titre-normal{
	font-size: 24px;
	padding: 5px 0px 5px 0px;
}
h4.titre-normal{
	font-size: 20px;
	padding: 5px 0px 5px 0px;
	color: black;
}
h5.titre-normal{
	font-size: 16px;
	padding: 5px 0px 5px 0px;
}
h6.titre-normal{
	font-size: 12px;
	padding: 5px 0px 5px 0px;
}

h2.titre-normal a, h3.titre-normal a, h4.titre-normal a, h5.titre-normal a, h6.titre-normal a{
	text-decoration: underline;
}

.renderedtable p.contenu{
	padding-left: 5px;
}

p.contenu{
	padding-bottom: 17px;
}
.contenu a {
	text-decoration:underline;
}
ul.contenu li{
	background:url("/extension/ayaline/design/ayaline/images/puce-contenu-noir.png") no-repeat scroll 0 3px transparent;
	padding:0 0 5px 10px;
	margin-left:10px;
}


/*** Pagination ***/
.pagenavigator{
	text-align:center;
	background:none repeat scroll 0 0 #E5DCD3;
	border:1px solid #D6CDC4;
}
.pagenavigator p{
	padding:5px 10px 5px 10px;
}
.next{
	float:right;
}
.previous{
	float:left;
}
.current{
	font-weight:bold;
}


/*** Page d'accueil ***/
/* Bloc Accueil - Blog Flux RSS */
.bloc-accueil-h2{
	font-family:'OmnesLight', Arial, sans-serif !important;
	font-size:32px !important;
	font-weight:bold;
}
.bloc-accueil-h2 .contenu{
	margin-top:10px;
}
.bloc-accueil-h3{
	font-family:'OmnesMedium', Arial, sans-serif !important;
	font-size:22px;
	font-weight:normal;
	color:#2B80B9;
	padding:0 0 15px 0 !important;
}
.bloc-accueil-h3 .contenu{
	padding-bottom:0;
	padding-top: 10px;
}
.bloc-type .float-d img {
	position:relative;
	top:10px !important;
}


/*** Page des rubriques ***/
/* Bloc liste (page decouvrir, visites...) */
.bloc-liste-h2{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:32px !important;
	font-weight:bold;
}
.bloc-detail-h2{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:25px !important;
	font-weight:bold;
}
.bloc-liste-h3{
	font-family:'OmnesMedium', Arial, sans-serif;
	font-size:22px;
	font-weight:normal;
	padding:0 !important;
	margin:10px 0 10px 0 !important;
}
.bloc-liste-h3 a:hover{
	text-decoration:none;
}
.liste-parente li{
	width:222px;
}
.liste-parente .autre{
	margin-right:20px;
}
.menu-gauche-h2{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:18px !important;
	font-weight:bold;
}


/*** Page FAQ ***/
/* Menu gauche (faq) */
ul.menu-left li.actif a{
	color:#FFFFFF;
}


/*** Pages Médiathèque ***/
/* Affichage du bloc de description de la Médiathèque */
.chapeau.gallery{
	margin-right:102px;
}
.chapeauMedia.gallery{
	margin-right:102px;
}
/* Bloc de recherche dans les pages de la médiathèque */
.bloc-search label{
	margin-right:10px;
	font-weight:bold;
}
/* Bloc video dans la page de détail d'une video */
.container-diapo .video{
	text-align:center;
}
/* Bloc video dans en popin */
.popin-top{
	text-align:center;
}
.popin-top a{
	color:white;
}
/* Bloc galerie Flickr dans la page de détail d'une galerie de type Flickr */
.container-diapo .flickr{
	text-align:center;
}
/* Pagination des pages de la médiathèque */
.taille-pagination{
	width:1048px;
	/*width:1100px; ne pas toucher pour le moment */
}


/*** Page Plan du site ***/
.site-map ul li{
	margin: 0 0 10px 0;
	padding: 0px;
}
.site-map > ul > li > a{
	font-weight:bold;
	font-size: 16px;
	display: block;
	padding-bottom: 10px;
}

.site-map ul li ul li{
	margin:0 0 5px 20px;
}
.site-map ul li ul li a{
	color: #E644AC;
	background: url("/extension/ayaline/design/ayaline/images/puce-contenu.png") no-repeat scroll 0 3px transparent;
	padding-left: 10px;
}

.site-map ul li ul li ul li{
	margin:0 0 0 25px;
}
.site-map ul li ul li ul li a{
	/*color: #BCC601;*/
	color: #02BDFF;
	background: url("/extension/ayaline/design/ayaline/images/puce-contenu-bleu.png") no-repeat scroll 0 3px transparent;
	padding-left: 10px;
}


/*** Page de formulaire ***/
.content-view-full{
	background:white;
	padding:30px;
	margin-bottom:15px;
}
.survey-view{
	background:#F6EFE9;
	border:1px solid #E9E3DE;
	margin:20px 0 20px 0;
	padding:20px 0 20px 30px;
}
.survey-view .message-warning h2{
	color:#E643AC;
}
.survey-view .message-warning{
	border-bottom:1px solid #E9E3DE;
	padding-bottom:25px;
	margin-right:35px;
}
.survey-view .label-erreur{
	width:100px;
	float:left;
	text-align:right;
}
.survey-view .block{
	margin-top:15px;
}
.survey-view .block h2{
	font-size:14px;
}
.survey-view .block .lsdo-label{
	float:left;
	width:100px;
	margin-right:15px;
}
div.survey-view .required{
	color:#E643AC !important;
}
.survey-view .radio-ligne{
	float:left;
	margin-right:15px;
}
.survey-view .radio-ligne span{
	position:relative;
	bottom:2px;
	left:3px;
}
.element-column span{
	position:relative;
	bottom:2px;
	left:2px;
}
.survey-view .element-column{
	margin-left:110px;
}
.survey-view .block .non-textarea{
	text-align:right;
}
.survey-view .lsdo-recaptcha{
	margin-left:110px;
}
.survey-view .button{
	margin-left:115px;
}
.survey-view .button-envoyer, .survey-view .button-effacer{
	margin:10px 0 30px 0;
}
.survey-view .button-effacer{
	margin-right:10px;
	float:left;
	margin-left: 4px;
}


/*** Page Contactez-nous ***/
.page-contact .chapeau{
	margin-right:30px;
	padding:0 0 25px 0 !important;
}
.page-contact .bloc-error h2{
	color:#E643AC;
}
.page-contact .bloc-error{
	border-bottom:1px solid #E9E3DE;
	padding-bottom:25px;
	margin-bottom:25px;
	margin-right:35px;
}
.page-contact .label-erreur{
	width:100px;
	float:left;
	text-align:right;
}
.page-contact textarea{
	height:50px;
}
.page-contact .civilite{
	margin-left:70px;
}
.page-contact .deux-colonnes input{
	width:300px;
}
.page-contact .deux-colonnes.droite label{
	margin-left:100px;
}
.page-contact .checkbox-column{
	margin-left:110px;
}
.page-contact .checkbox-column label{
	position:relative;
	bottom:2px;
	left:2px;
}
.page-contact .required{
	color:#E643AC !important;
}
.page-contact .border-haut{
	border-top:1px solid #E9E3DE;
	margin-top:35px;
	padding-top:20px;
	margin-right:30px;
}
.page-contact .message h2{
	color:#0BBCFF;
}
.page-contact #recaptcha_area{
	/*margin-left:110px;*/
}
.page-contact .recaptcha-droite{
	margin-left:110px;
}


/*** Page de résultats de recherche photos ***/
.bloc-container.recherche{
	padding:50px 0 0 29px;
}


/*** Page de resultats ***/
.bloc-similaire a{
	font-weight:bold;
	text-decoration:underline;
	font-size:1.3em;
}
.bloc-similaire a:hover{
	text-decoration:none;
}
.list-result-search{
	border-top:1px dotted #8C9195;
	margin:0 10px 0 0;
	padding:15px 0 0 0;
}
.list-result-search li:first-child{
	border-top:none;
	padding:0 !important;
}
.list-result-search li{
	border-top:1px dotted #8C9195;
	margin:0 0 20px 0;
	padding:15px 0 0 0 !important;
}
.bloc-pertinence-global{
	margin:0 0 5px 0;
}
.bloc-pertinence-global .modification{
	float:right;
}
.bloc-pertinence-global span{
	float:left;
}
.bloc-pertinence{
	background:url("/extension/ayaline/design/ayaline/images/bg_pertinence.png") no-repeat scroll 0 0 transparent;
	float:left;
	height:9px;
	margin:4px 4px 0 4px;
	position:relative;
	width:64px;
}
.bloc-pertinence div{
	background:url("/extension/ayaline/design/ayaline/images/bg_pertinence-on.png") no-repeat scroll 0 0 transparent;
}
.bloc-pertinence-global span.date{
	float:none;
	text-transform:capitalize;
}
.list-result-search li h3 {
	padding:0;
	font-size:1.5em;
}


/*** Reprise des styles uniquement pour l'autocompletion du champs de recherche contenu dans pagelayout.tpl ***/
div#ezautocomplete2 {
	z-index:500;
}
.customResult {
	display:block;
}
div#ezautocomplete2 .yui-ac, div#ezautocomplete2 .yui-ac-input {
	position:relative;
}
div#ezautocomplete2 .yui-ac-container {
	position:absolute;
	top:1.6em;
	text-align:left;
}
div#ezautocomplete2 .yui-ac-content {
	width:100%;
	border:1px solid #808080;
	background:#fff;
	overflow:auto;
	overflow-y:hidden;
	z-index:9050;
	padding-bottom:15px;
}
div#ezautocomplete2 .yui-ac-shadow {
	position:absolute;
	margin:.3em;
	width:100%;
	background:#000;
	-moz-opacity:.10;
	opacity:.10;
	filter:alpha(opacity = 10);
	z-index:9049;
}
div#ezautocomplete2 .yui-ac iframe {
	opacity:0;
	filter:alpha(opacity = 0);
	padding-right:.3em;
	padding-bottom:.3em;
}
div#ezautocomplete2 .yui-ac-content ul {
	margin:0;
	padding:0;
	width:100%;
}
div#ezautocomplete2 .yui-ac-content li {
	background-image:none !important;
	margin:0 !important;
	padding:2px 5px !important;
	cursor:default !important;
	white-space:nowrap !important;
	list-style:none !important;
	zoom:1 !important;
	display:block !important;
	float:none !important;
	color:black !important;
}
div#ezautocomplete2 .yui-ac-content li.yui-ac-prehighlight {
	background:#BABABA !important;
}
div#ezautocomplete2 .yui-ac-content li.yui-ac-highlight {
	background:#B0B0B0 !important;
	color:#FFF !important;
}


/*** Page liste hotels ***/
.bloc-liste-h2-recherche{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:23px !important;
	font-weight:bold;
	padding-bottom:15px;
}
.menu-gauche-h2-recherche{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:18px !important;
	font-weight:bold;
	padding-bottom:5px;
	display:block;
}
.choisissez{
	background:url("/extension/ayaline/design/ayaline/images/fleche-r.png") no-repeat scroll 98% 50% #303A43;
	color:#FFFFFF;
	display:block;
	padding:2px 0 2px 4px;
}
.choisissez strong{
	display: block;
    width: 175px;
}
.liste-modalites{
	background:none repeat scroll 0 0 #FAF9F7; padding:5px 0 5px 4px;
}
.list-inline-bis .titre-top2{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:32px !important;
	padding-top:0;
}
.list-inline-bis .top2{
	margin-right:10px;
}
.criteres.liste-hotel li{
	border-top:1px solid #D2CBC5;
	border-bottom:none;
	border-right:none;
	border-left:none;
	float:none;
	display:block;
}
.criteres.liste-hotel li:first-child{
	border-top:none;
}
.criteres{
	border-bottom:1px solid #D2CBC5;
	margin-bottom:5px;
}
.criteres img{
	float:none !important;
}
.form-search-left button{
	background:none repeat scroll 0 0 #303A42;
	color:#FFFFFF;
	margin:0;
	padding:1px 0 !important;
	text-align:center;
	width:138px;
}

.moninfobulle{
	height:180px;
}
.moninfobulle .titre{
	margin-bottom:10px;
}
.moninfobulle .titre h3{
	display:inline;
}
.moninfobulle .etoile{
	position:relative;
	top:3px;
	margin-left:5px;
}
.moninfobulle .photo{
	margin-right:10px;
}
.moninfobulle span.float-d{
	margin-right:10px;
	margin-bottom:5px;
	color:#BABABA;
	font-style:italic;
	font-weight:bold;
	/*width:160px*/;
	width:155px;
	text-align:right;
}
.moninfobulle .commentaire{
	padding-bottom:5px;
	text-align:justify;
}
.moninfobulle p.lien{
	margin-right:5px;
	padding:0;
}

a.liste-goutte{
	/*background: url("/extension/ayaline/design/ayaline/images/picto-google-map.gif") no-repeat;
	width: 40px;
	height: 39px;
	font-size: 0px;
	color: white;*/
	display: block;
}
a.liste-goutte img{
	float: left;
	margin: 10px 7px 0 0;
}
a.liste-goutte h3{
	position: relative;
	top: 9px;
}


/*** Page liste activites ***/
.liste-act-border{
	border-top:1px solid #F6EFE9;
	margin:24px 0 20px 0;
	padding:20px 0 0;
}
.criteres.liste-act li{
	border-top:1px solid #D2CBC5;
	border-bottom:none;
	border-right:none;
	border-left:none;
	margin:0;
	float:none;
	display:block;
}
.criteres.liste-act li:first-child{
	border-top:none;
}

.moninfobulle .titre-defaut{
	margin:0 0 10px 0;
	padding:0;
}


/*** Page fiche hotel ***/
.galerie-fiche#galleria{
	height:300px;
}
.galerie-fiche .galleria-container{
	background:none repeat scroll 0 0 #ECE5DF;
}

.galerie-fiche .galleria-thumb-nav-left,
.galerie-fiche .galleria-thumb-nav-right,
.galerie-fiche .galleria-info-link,
.galerie-fiche .galleria-info-close,
.galerie-fiche .galleria-image-nav-left,
.galerie-fiche .galleria-image-nav-right {
	background-image:url("/extension/ayaline/design/ayaline/images/classic-map.png");
}


/*** Menu A la Une - Meteo-Maree ***/
.meteo-maree{
	background-color:#FFFFFF;
	width:205px;
}


/*** Menu A la Une - Meteo ***/
.rubrique2 .meteo{
	border:none !important;
	background:none !important;
	margin-top:10px;
}
.rubrique2 .meteo a{
	border-left:none !important;
}
.rubrique2 .meteo-lien{
	display:none;
}


/*** Menu A la Une - Maree ***/
.maree{
	color:black;
	margin-top:10px;
	padding:5px;
	width:195px;
}
.maree thead th{
	font-weight:bold;
}
.maree .vert{
	color:#BEC505;
}
.maree .taille{
	width:80px;
}
.maree .centre{
	text-align:center;
}
.maree .centre.vert{
	font-weight:bold;
}
.maree a{
	padding:0 !important;
	border-left:none !important;
	float:none !important;
	font-size:11px !important;
	position:relative !important;
	top:0 !important;
	text-transform:none !important;
	color:black !important;
}
.maree tfoot th{
	text-align:right;
}


/*** Bloc Voir aussi ***/
.bloc-liste-h2-cote{
	font-family:'OmnesLight', Arial, sans-serif;
	font-size:27px !important;
	font-weight:bold;
}

.liste-voir-aussi{
	margin:14px 0 20px 0 !important;
}
.liste-voir-aussi li{
	border-top:1px solid #E9E3DE;
	border-bottom:none;
	margin:10px 0 0 0;
	padding:10px 0 0 0 !important;
}
.liste-voir-aussi li:first-child{
	border-top:none;
	border-bottom:none;
	margin:0;
	padding:0 !important;
}

.lien-plus-infos{
	background:url("/extension/ayaline/design/ayaline/images/+dinfos-noir.png") no-repeat;
	display:block;
	width:63px;
	height:19px;
}


/*** Bloc Accueil SIT ***/
.bloc-accueil-h2 .contenu{
    padding-bottom: 5px;
}
/* Diaporama */
.bxslider{
	width:338px;
	margin:0 0 20px 10px;
}


/*** Espace presse ***/
.espace_presse h2{
	float: none;
	font-size: 16px;
}


/*** Phototheque ***/
ul.phototheque .no-vignette img{
	width: 225px;
}
ul.phototheque li.last{
	margin: 0px 0px 34px 0px;
}
ul.phototheque li.last{
	margin: 0px 0px 34px 0px;
}
div.phototheque{
	text-align: center;
}
div.image{
	margin-top: 5px;
}


/*** Page user login / identification ***/
.user-login h2{
	float: none;
	font-size:18px;
}
.user-login label{
	display: block;
    float: left;
	margin-right: 5px;
	width: 100px;
	text-align: right;
	position: relative;
	top: 1px;
}
.user-login .defaultbutton{
	margin-left: 105px;
}


/*** Remontee a la une ***/
.remontee-alaune{
	width: 190px;
	color: black !important;
}
.remontee-alaune a{
	padding: 0px !important;
	border-left: none !important;
    float: none !important;
    font-size: 100% !important;
    color: black !important;
}
.remontee-alaune img{
    float: none !important;
    margin: 0px !important;
    padding: 0px !important;
}
.remontee-alaune p{
	padding: 5px 0 5px !important;
}


/*** Avis Tripadvisor ***/
#CDSWIDSSP{
	width:282px !important;
}


/*** Bloc Reserver ***/
#bloc-ac-res .bloc-accueil-h3{
	color: #FF8B33;
}
#OSRechercheDetail #OsBarreOnglet {
	width: 98%;
}
#OSRecherche #OsBarreOnglet {
	width: 100%;
}
#OSRechercheDetail {
/*	float:left;*/
}

#bloc-ac-res{
	padding: 15px 10px 9px;
}
#bloc-ac-res .bloc-accueil-h2{
	padding-left: 13px;
}
#bloc-ac-res .bloc-accueil-h3{
	padding: 0px 0px 15px 13px !important
}
#OSRecherche .accordion-contenu{
	background-color: #FF8B33;
	color: white;
	padding-left: 12px;
}
#OSRecherche .OsCritP {
    border-bottom: none;
}
#OSRecherche span.OsImgDateDebut img {
    background-image: url("/extension/ayaline/design/ayaline/images/calendrier.png");
    background-position: left 1px;
    padding-right: 2px;
}
#OSRecherche a.OsBtnEnvoi{
    background: url("/extension/ayaline/design/ayaline/images/bouton-rech-dispo.png") no-repeat transparent;
    border: none;
    width: 231px;
    margin: 10px 10px 10px 0px;
    color: transparent;
    font-size: 0px;
    height: 29px;
    display: block;
    padding: 0px;
}


/*** Mise en avant Diaporama embarque ***/
.bxslider.embarque{
	width: 593px;
}


/*** Mise en avant - Remonte de type diaporama ***/
.bxslider.remonte_liste{
	width: 593px;
}
.bxslider.remonte_liste .pager{
	text-align: center;
}
.bxslider.remonte_liste .pager img{
	width: auto;
	max-width: 593px;
	float: none;
	max-height: 370px;
}
.bxslider.remonte_liste .pager span{
	font-size: 16px;
}
.bxslider.remonte_liste .bx-window{
	height: 460px;
}

/*** Menu de recherche dans les pages SIT ***/
.new-image-fleche{
	background:url("/extension/ayaline/design/ayaline/images/picto-on.png") no-repeat scroll 98% 50% #303A43 !important;
}


/*** Popup aide navigation ***/
.icone-aide-saison{
	margin: 0px 0px 0px 10px;
	position: relative;
    top: 3px;
}
.icone-aide-saison img{
	cursor: pointer;
}
.ui-effects-transfer { border: 2px solid black; }

/************************/
/*** Fin ajout Alexia ***/
/************************/

/* styles pour remontée standard dans colonne de droite */
.bloc-right-bis ul.miseAvantStandard {
	padding: 10px 0 10px 10px;
	margin-bottom:-20px;
	background:#fff;
}
.bloc-right-bis ul.miseAvantStandard li {
    height: 1%;
    overflow: hidden;
    padding: 0 0 16px;
}
.bloc-right-bis ul.miseAvantStandard li img{
	margin:0 14px 0 0;
	float:left;
}
.bloc-right-bis ul.miseAvantStandard li p{
	padding:0;
}
.bloc-right-bis ul.miseAvantStandard li p img {
    padding: 0 0 0 5px;
    float: right;
}

/* style pour lien aYaline dans le footer */
li.ayaline a {
	margin: -5px 0 0 0;	
}
li.ayaline a span {
	display:none;
}
li.ayaline a img {
	margin:-10px 0 0 0;
	position: relative;
    top: 5px;
}
li.ayaline a:hover {
	 text-decoration: none;
}
/**
 * Recaptcha 
 */
#captcha .recaptchatable {
    border: medium none !important;
}
#captcha .recaptcha_image_cell {
	background-color: transparent;
    width: 261px !important;
}
#captcha #recaptcha_image {
    border: 1px solid #C8C7C1 !important;
    float: left !important;
    width: 261px !important;
}
#captcha #recaptcha_image img {
    width: 261px !important;
}
#captcha #recaptcha_logo, #captcha #recaptcha_tagline, #captcha #recaptcha_switch_audio, #captcha #recaptcha_reload_btn, #captcha #recaptcha_whatsthis_btn {
    display: none;
}
#captcha input {
    border: 1px solid #C8C7C1 !important;
    float: left !important;
    width: 261px !important;
}
.form-search-left div select {
	font-size:1em;
}
.list-inline-bis li#mise-en-avant-agenda {
	width:266px !important;
}
.visualiserCarte {
	position: relative;
}
.visualiserCarte > div {
	position: absolute;
	top: 20px;
	right: 10px; 
	width:160px;
 }
 .visualiserCarte > div.top40 {
	top: 40px;
 }
 #dialogPopupSaison.popup-accueil {
	background: rgb(50, 61, 73);
	background: rgba(50, 61, 73, 0.95);
	color: white;
 }
 #dialogPopupSaison.popup-accueil h2, #dialogPopupSaison.popup-accueil h2 a {
	color: white;
	font-size:130%;
}
#dialogPopupSaison.popup-accueil h3 {
	color: #AFC04D;
	font-size:120%;
}
#dialogPopupSaison.popup-accueil p.contenu {
	padding-bottom:0;
}
#dialogPopupSaison.popup-accueil .object-left {
	float:left;
	padding-right: 10px;
}
#dialogPopupSaison.popup-titre {
	text-transform:uppercase;
}
#dialogPopupSaison p.contenu a {
	color: white;
	font-weight:bold;
}
body>div.ui-corner-all {
	border: none;
	background:none;
}
body>div.ui-dialog>div.ui-corner-all {
	border:none;
	background: rgb(40, 51, 63);
	background: rgba(40, 51, 63, 0.95);
    border: medium none;
    color: white;
}
body>div.ui-dialog>div.ui-corner-all {
	border-radius:0;
	padding: 9px 0 9px 15px;
}
.button-submit-effacer, .button-submit-valider {
	background: #9C9289;
    border: 0 none;
    color: white;
    float: left;
    font-weight: bold;
    margin: 5px;
    padding: 4px 20px;
}
.button-submit-valider {
	background: #E643AC;
}

.galleria-lightbox-title{
	color: #000;
	font-weight: bold;
}

/*** Mantis 349 ***/
.legende-phototheque{
	text-align: center;
	font-style: italic;
	display: block;
}
/******************/
{/literal}