{def $rNode = fetch('content','node', hash('node_id',  ezini('NodeSettings','RootNode','content.ini')))}
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN"
    "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	{include uri="design:header.tpl"}
	<body>
		{literal}<script>
			if(geo_position_js.init()){
				geo_position_js.getCurrentPosition(success_callback,error_callback,{enableHighAccuracy:true});
			}
			else{
				//alert("Functionality not available");
			}
	
			function success_callback(p)
			{
				//alert('lat='+p.coords.latitude.toFixed(2)+';lon='+p.coords.longitude.toFixed(2));
			}
			
			function error_callback(p)
			{
			//	alert('error='+p.code);
			}		
		</script>{/literal}
		<div data-role="page">
			<!-- MAIN CONTAINER BEGINNING -->
			<div id="container">
				<!-- CONTENT PAGE TITLE -->
				<div id="Header">
					<div class="logo">
						<h1>
							<a href="#" class="ui-link"><img alt="" src={'images/logo.png'|ezdesign()} width="276" height="49"></a>
						</h1>
					</div>
					<div class="TopNavBar">
						<div class="menu">
							{foreach $rNode.data_map.header_menu.content.main_node.children as $sMenu}
								{node_view_gui content_node=$sMenu view='menu'}
							{/foreach}
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="clear"></div>

				<div id="Main">

					<div class="icons">   
						<div class="icon">
						<a href="#">
						<img src={'images/icon1.png'|ezdesign()} alt="Hébergement" width="88" height="88" />
						</a><br />
						<div class="title">Hébergement<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon2.png'|ezdesign()} alt="Météo" width="88" height="88" />
						</a><br /><div class="title">Météo<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon3.png'|ezdesign()} alt="Marées" width="88" height="88" />
						</a><br /><div class="title">Marées<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon4.png'|ezdesign()} alt="Marchés" width="88" height="88" />
						</a><br /><div class="title">Marchés<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon5.png'|ezdesign()} alt="Restaurants" width="88" height="88" />
						</a><br /><div class="title">Restaurants<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon6.png'|ezdesign()} alt="Agenda" width="88" height="88" />
						</a><br /><div class="title">Agenda<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon7.png'|ezdesign()} alt="Circuits" width="88" height="88" />
						</a><br /><div class="title">Circuits<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon8.png'|ezdesign()} alt="Sports/loisirs" width="88" height="88" />
						</a><br /><div class="title">Sports/loisirs<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon9.png'|ezdesign()} alt="Sorties" width="88" height="88" />
						</a><br /><div class="title">Sorties<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon10.png'|ezdesign()} alt="Visites" width="88" height="88" />
						</a><br /><div class="title">Visites<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon11.png'|ezdesign()} alt="Blog" width="88" height="88" />
						</a><br /><div class="title">Blog<br />&nbsp;</div></div><div class="icon">
						<a href="#">
						<img src={'images/icon12.png'|ezdesign()} alt="Infos pratiques" width="88" height="88" />
						</a><br /><div class="title">Infos pratiques<br />&nbsp;</div></div>   

						<div class="clear"></div>
						<!-- END OF ICON SUITE -->
				   </div>
				   
					<!-- PAGE ROOT -->
					<div class="recherche accueil">
						<div class="search">
							<form action="#" method="post" class="form-recherche">
								<label class="none" for="recherche">Votre recherche</label>
								<table>
									<td><input type="search" id="recherche" value="Recherche" name="recherche" /></td>
									<td><input type="submit" value="OK" data-role="button" data-theme="b" data-inline="true" /></td>
								</table>
							</form>
						</div>
					</div>
					
					<div class="PageRoot">
						Vous êtes sur :
						<b>Accueil</b>
					</div>
					
					<a href="#">
						<div class="push">
							<div class="arrow"><img alt="arrow" src={'images/arrow1.png'|ezdesign()} /></div>
							<div class="text">
							  <span>suggestion</span>	
							  <span class="title">Les Sables d'Olonne</span>
							  <span class="description">Promenades et pêches en mer - cie vendéenne</span>
							</div>
						</div>
					</a>
					<div class="clear"></div>
				</div>

				<!-- COPYRIGHTS AND LEGAL MENTIONS -->
				<div id="Copyrights">
					<p>&copy; 2011 Tourisme des Olonnes<br />
						<a href="#" class="ui-link">Mentions légales</a>
					</p>
				</div>

			<!-- END OF MAIN CONTAINER -->
			</div>

		</div>
		<!-- END OF HTML -->
	</body>
</html>
