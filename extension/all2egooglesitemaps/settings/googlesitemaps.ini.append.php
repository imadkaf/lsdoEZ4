<?php /*

[all2eGoogleSitemapSettings]
#Define Subtree to create Sitempa from
SitemapRootNodeID=2
#Define the XML file
Filename=sitemap.xml
#related to the eZ Publish root directory
Path=


[Classes]
#include or exclude objects of classes listed in ClassFilterArray
ClassFilterType=exclude

#setting array to include/exclude classes in sitemap
ClassFilterArray[]
#ClassFilterArray[]=folder
#ClassFilterArray[]=article
#ClassFilterArray[]=image
#ClassFilterArray[]=forum
ClassFilterArray[]=ba_flux_rss_blog
ClassFilterArray[]=embed_code
ClassFilterArray[]=dossier_phototheque
ClassFilterArray[]=image_entete
ClassFilterArray[]=image_entete_defaut
ClassFilterArray[]=diapo
ClassFilterArray[]=diaporama
ClassFilterArray[]=gallery_category_photo
ClassFilterArray[]=gallery_category_video
ClassFilterArray[]=gallery_gallery_photo
ClassFilterArray[]=accueil_mobile
ClassFilterArray[]=webcams
ClassFilterArray[]=itineraire
ClassFilterArray[]=footer_menu
ClassFilterArray[]=main_menu
ClassFilterArray[]=season
ClassFilterArray[]=sub_menu
ClassFilterArray[]=topic
ClassFilterArray[]=folder
ClassFilterArray[]=brochure
ClassFilterArray[]=faq
ClassFilterArray[]=sit_mise_en_avant


[NodeSettings]
#set false to include only main node of content object in sitemap
#set true to include all nodse of content object in sitemap
Main_Node_Only=false



# NOT implemented yet
#<changefreq> based on depth of node
Node_Depth_ChangeFreq[]
Node_Depth_ChangeFreq[]=always
Node_Depth_ChangeFreq[]=hourly
Node_Depth_ChangeFreq[]=daily
Node_Depth_ChangeFreq[]=weekly
Node_Depth_ChangeFreq[]=monthly
Node_Depth_ChangeFreq[]=yearly
Node_Depth_ChangeFreq[]=never

#<priority> based on depth of node
Node_Depth_Priority[]
Node_Depth_Priority[]=1
Node_Depth_Priority[]=0.9
Node_Depth_Priority[]=0.8
Node_Depth_Priority[]=0.7
Node_Depth_Priority[]=0.6
Node_Depth_Priority[]=0.5
Node_Depth_Priority[]=0.4

*/ ?>
