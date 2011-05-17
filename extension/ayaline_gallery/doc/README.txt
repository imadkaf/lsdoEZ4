Pour installer :
1. mettre l'extension dans le répertoire "extension" d'eZ Publish
2. activer l'extension dans le back office.
3. Vider tous les caches
4. Le plugin galleria (http://galleria.aino.se/) nécessite jquery. L'extension ezjscore devrait suffire, c'est elle qui est utilisée pour le jquery par défaut.
Si le plugin galleria n'était pas compatible avec cette version, l'extension embarque jquery 1.5.2 qui n'est pas activé par défaut.
 S'il fallait le faire, il suffit de le faire dans le design.ini de l'extension et décommenter la ligne correspondante, et commenter celle du jscore.

Pour l'utiliser :
1. Créer les contenus : TODO


Personnaliser le thème :
- Le thème utilisé par défaut se trouve dans javascript/galleria/themes/classic
- il faut modifier le "galleria.classic.css" dans ce répertoire pour modifier le thème
- la taille de la gallerie est définie dans les css de l'extension "ayaline_gallery.css"


Photos du site :
- la description de la photo est faite à partir du texte alternatif de l'image  

Photos Flickr :
1. Se créer un compte
2. Se connecter
3. Uploader des photos et les ajouter à un album
4. Afficher le diaporama de cet album, et récupérer le code "HTML incorporé" qui est dans "Partager"
5. Coller ce code dans le champ Flickr d'une gallerie photo. Il faut changer les valeurs "height" (hauteur) et "width" (largeur) dans le html pour obtenir la taille souhaitée.