<?php

if ( !$isQuiet )
    $cli->output( "Generating Sitemap...\n"  );

    
// Get a reference to eZINI. append.php will be added automatically.
$ini = eZINI::instance( 'site.ini' );
$googlesitemapsINI = eZINI::instance( 'googlesitemaps.ini' );

// Settings variables
if ( $googlesitemapsINI->hasVariable( 'all2eGoogleSitemapSettings', 'SitemapRootNodeID' ) &&
	 $googlesitemapsINI->hasVariable( 'all2eGoogleSitemapSettings', 'Filename' ) &&
	 $googlesitemapsINI->hasVariable( 'all2eGoogleSitemapSettings', 'Path' ) &&
	 $googlesitemapsINI->hasVariable( 'Classes', 'ClassFilterType' ) &&
	 $googlesitemapsINI->hasVariable( 'Classes', 'ClassFilterArray' ) &&
	 $ini->hasVariable( 'SiteSettings','SiteURL' )
	 )
{
    $sitemapRootNodeID = $googlesitemapsINI->variable( 'all2eGoogleSitemapSettings','SitemapRootNodeID' );
    
	$sitemapFilename = $googlesitemapsINI->variable( 'all2eGoogleSitemapSettings','Filename' );
    $sitemapPath = $googlesitemapsINI->variable( 'all2eGoogleSitemapSettings','Path' );
    $xmlDataFile = $sitemapPath . $sitemapFilename;
    
    $classFilterType = $googlesitemapsINI->variable( 'Classes','ClassFilterType' );
    $classFilterArray = $googlesitemapsINI->variable( 'Classes','ClassFilterArray' );
    
    $siteURL = $ini->variable( 'SiteSettings','SiteURL' );
}
else
{
    eZDebug::writeError( 'Missing INI Variables in configuration block GeneralSettings.' );
    return;
}

// Get the Sitemap's root node
$rootNode = eZContentObjectTreeNode::fetch( $sitemapRootNodeID );

if (!is_object($rootNode)) {
	eZDebug::writeError( 'Invalid SitemapRootNodeID in configuration block GeneralSettings.' );
	return;
}

// Fetch the content tree
$nodeArray =& $rootNode->subTree( array( 'ClassFilterType' => $classFilterType,
                                         'ClassFilterArray' => $classFilterArray ) );
                                         
                                         

$xmlRoot = "urlset";
$xmlNode = "url";

// Define XML Child Nodes
$xmlSubNodes = array("loc","lastmod","changefreq","priority");

// Create the DOMnode
$dom = new DOMDocument("1.0","UTF-8");

// Create DOM-Root (urlset)
$root = $dom->createElement($xmlRoot);
$root->setAttribute( "xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9" );
$root = $dom->appendChild($root);

// Generate XML data
foreach ($nodeArray as $subTreeNode) {

	// Values
	$urlAlias = 'http://'.$siteURL.'/'.$subTreeNode->attribute( 'url_alias' );
	$object = $subTreeNode->object();
	$depth = $subTreeNode->attribute( 'depth' );
	$modified = date("c" , $object->attribute( 'modified' ));	
	
	// Create new url element
	$node = $dom->createElement($xmlNode);
	// append to root node
	$node = $root->appendChild($node);
	
	// create new url subnode
	$subNode = $dom->createElement($xmlSubNodes[0]);
	$subNode = $node->appendChild($subNode);
	// set text node with data
	$date = $dom->createTextNode($urlAlias);
	$date = $subNode->appendChild($date); 

	// create modified subnode
	$subNode = $dom->createElement($xmlSubNodes[1]);
	$subNode = $node->appendChild($subNode);	
	// set data
	$lastmod = $dom->createTextNode($modified);
	$lastmod = $subNode->appendChild($lastmod);
	
}

// write XML Sitemap to file
$dom->save($xmlDataFile);

if ( !$isQuiet )
    $cli->output( "Sitemap has been generated!\n" );

?>
