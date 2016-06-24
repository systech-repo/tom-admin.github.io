Astuces du terminal
===================

:date: 2015-02-22
:author: Mobius
:category: Astuces
:tags: astuces, terminal, rapidité, console, raccourcis

Voici quelques raccourcis pratiques que vous pouvez utiliser facilement en vue de gagner de la rapidité lors de vos saisies dans un terminal :

- **[CTRL]+[A]** qui repositionne votre curseur au début de la ligne
- **[CTRL]+[e]** qui repositionne votre curseur en fin de ligne
- **[CTRL]+[l]** qui efface l'écran (équivalent de la commande **clear**)
- **[CTRL]+[s]** masque la sasie de l'utilisateur
- **[CTRL]+[q]** réaffiche la saisie de l'utilisateur
- **[CTRL]+[u]** efface tout ce qui se trouve à gauche du curseur
- **[CTRL]+[k]** efface tout ce qui se trouve à droite du curseur
- **[CTRL]+[w]** efface tout ce qui se trouve à droite du curseur
- **[CTRL]+[r]** effectue une recherche dans l'historique (**history**)
- **[CTRL]+[e]** puis **[CTRL]+[x]** permet d'éditer une ligne avec votre éditeur par défaut (le fichier est entreposé dans le dossier /tmp)
- **[CTRL]+[s]** permet de suspendre le terminal (saisie + le reste). Ainsi cette commande effectuée lors du boot permet de lire les messages du kernel 
- **[CTRL]+[q]** permet de débloquer le terminal (saisie + le reste)
- **[CTRL]+[y]** colle la saisie précédente 
- **[CTRL]+[d]** permet d'effacer le caractère sur lequel le curseur est positionné ou déconnecte (**logout**) si la ligne est vierge de toute saisie 
- **[CTRL]+[t]** permet d'inverser deux lettres successives
- **[ALT]+[b]** permet de se déplacer de mot en mot
- **[ALT]+[f]** permet de se déplacer de mot en mot
- **[ALT]+[d]** permet d'effacer le mot suivant 
- **[ALT]+[t]** permet d'échanger le mot suivant avec celui qui le précède 
- **[ALT]+[c]** permet de mettre en **uppercase** la lettre sur laquelle le curseur est positionné 

Désactiver les notifications d'erreurs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pour désactiver les rapports d'erreurs survenant parfois dans des situations inexpliquables, voici comment il faut procéder :

- **Ouvrir un terminal** souvent le raccourci est **[CTRL]+[ALT]+[t]**
- Taper cette commande au sein de votre terminal

.. code:: bash

    $ vim /etc/default/apport

- Changer l'état de **enabled=1** à **enabled=0**
- Enregistrer les modifications (*:x* pour *Vim*)

Autre solution pour les *feignasses* et uniquement pour eux :

.. code:: bash

    $ sudo sed -i 's/1/0/' /etc/default/apport

Voilà, les notifications d'erreurs ne seront plus affichées.
