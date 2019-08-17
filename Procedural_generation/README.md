# Fonctionnement de la génération procédurale de la map

- Love2D possède parmis les autres, 3 méthodes liées à la boucle de rendu: draw, update et load

	- Draw sert dans la boucle de rendu à la gestion de l'affichage
	- Update, sert dans la boucle à l'intervale d'affichage, exprimée notamment en DeltaTime
	- Load, sert quand à lui à l'initialisation de la boucle

- Plus d'information sur la boucle de rendu:
	- https://alexandre-laurent.developpez.com/tutoriels/programmation-jeux/boucle-de-jeu/
- La génération de cette carte est faite selon le modèle du jeu "Binding of Isaac", en d'autres termes: une série de colonnes et de lignes s'affichent à l'écran indicant dans cette série les pièces à ou visitées.

# Prodédure de génération

- Pour générer la carte, il va donc faloir prodéder comme suite:
	- Initialiser dans le rendu graphique (Draw) l'affichage des lignes et des colonnes
	- Initialiser dans le rendu de ces lignes et des colonnes une salle servant de point de départ pour la génération des autres salles
	- Depuis la génération de la salle initiale, pour générer les autres salles:
		- Affecter lors de la génération des salles, aléatoirement un coté de la salle (Haut, Bas, Gauche, Droite)
		- Une fois le coté affecté à la salle de départ, générer les autres salles depuis la position de la salle de départ, en regardant le coté et la position de la salle
		- Générer la nouvelle salle depuis une valeur aléatoire liée à la position de la salle précédente et du coté de la salle, tant que l'ensemble de la génération n'est pas supérieur au nombre maximale fixé de génération de salles et que le coté de la salle généré permet d'être en liaison avec le coté de la salle précedente, bien evidémment tant que cela de est inférieur aux colonnes et lignes existantes.
		- En d'autres termes, une salle A a été généré avec un coté gauche, la salle B sera par exemple généré à gauche de la salle A, avec obligatoirement une porte au coté opposé à la salle A, soit une porte au coté droit de la salle B [ porte-] [ -porte] A