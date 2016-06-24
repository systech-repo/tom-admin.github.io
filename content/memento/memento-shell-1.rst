Shell Memento #I
################

:date: 2015-02-22
:author: Mobius
:category: Memento

Effectuer des tests
-------------------
Structure de base
~~~~~~~~~~~~~~~~~

.. code:: bash
    
    # si ma condition est vraie alors faire
    if condition
        then action(s)
    fi
    
    # si ma condition est vraie faire sinon faire
    if condition
        then action(s)
        else action(s)
    fi
    
    # si ma condition est vraie faire sinon si ma condition2 est vraie faire sinon 
    if condition
        then action(s)
        elif condition; then action(s) # libre à nous de rajouter encore des elif 
        else action(s)
    fi

Exemples :
~~~~~~~~~~

.. code:: bash
    
    # exemple avec une seule condition 
    if [ $(whoami) != "root" ]; then echo "only root can perform this action"; exit 1;fi

    # exemple avec plusieurs conditions
    read -p "Saisir votre note : " note
    if [ "$note" -ge 16 ]; then echo "Excellent"
        elif [ "$note" -ge 14 ]; then echo "Bravo"
        elif [ "$note" -ge 12 ]; then echo "Assez bien"
        elif [ "$note" -ge 10 ]; then echo "Passable"
        elif [ "$note" -le 10 ]; then echo "Nul"
    fi

Opérateurs comparaisons fichiers :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **-a** vrai si le fichier existe bel et bien (*a* -> **all**)
- **-b** vrai si le fichier existe **et** est de type bloc (*b* -> **block-type**)
- **-c** vrai si le fichier existe **et** est de type caractère (*c* -> **character**)
- **-f** vrai si le fichier existe **et** est de type fichier (*f* -> **file type**)
- **-d** vrai si le fichier existe **et** est un répertoire (*d* -> **directory**)
- **-r** vrai si le fichier existe **et** est accessible en lecture (*r* -> **read**)
- **-w** vrai si le fichier existe **et** est accessible en écriture (*w* -> **write**)
- **-x** vrai si le fichier existe **et** est exécutable (*x* -> **execute**)
- **-G** vrai si le fichier existe **et** appartient au groupe de l'utilisateur courant (*G* -> **Group**)
- **-O** vrai si le fichier existe **et** appartient à l'utilisateur courant (*O* -> **Owner**)
- **-S** vrai si le fichier est de type socket (*S* -> **socket file**)
- **-k** vrai si le fichier possède le sticky-bit en mode actif (*k* -> **socket On**)
- **-s** vrai si le fichier existe et à une taille non nulle (*s* -> **size**)
- **-L** vrai si le fichier existe et est de type lien symbolique (*L* -> **symbolic Link**)
- **-ef** vrai si le fichier 1 est égale au fichier 2 (*ef* -> **equal file**)
- **-nt** vrai si le fichier existe et est plus récent que le fichier 2 (*nt* -> **newer than**)
- **-nt** vrai si le fichier existe et est plus récent que le fichier 2 (*nt* -> **newer than**)
- **-ot** vrai si le fichier existe et est plus ancien que le fichier 2 (*ot* -> **older than**)

Exemples :
~~~~~~~~~~

.. code:: bash
    
    # Paramètres
    fichier="$1" 
    fichier2="$2"

    # Actions
    if [ -a "$fichier" ];then echo "$fichier existe";fi 
    if [ -b "$fichier" ];then echo "$fichier est de type bloc";fi 
    if [ -c "$fichier" ];then echo "$fichier est de type caractère";fi 
    if [ -f "$fichier" ];then echo "$fichier est de type fichier";fi 
    if [ -d "$fichier" ];then echo "$fichier est un répertoire";fi 
    if [ -r "$fichier" ];then echo "$fichier est accessible en lecture";fi
    if [ -w "$fichier" ];then echo "$fichier est accessible en écriture";fi
    if [ -G "$fichier" ];then echo "$fichier appartient au groupe de l'utilisateur";fi
    if [ -O "$fichier" ];then echo "$fichier appartient à l'utilisateur";fi
    if [ -L "$fichier" ];then echo "$fichier est un lien symbolique";fi
    if [ -S "$fichier" ];then echo "$fichier est un socket";fi
    if [ -k "$fichier" ];then echo "$fichier possède le sticky bit";fi
    if [ -s "$fichier" ];then echo "$fichier a une taille non nulle";fi
    if [ "$fichier" -ef "$fichier2" ];then echo "$fichier est égal à $fichier2";fi
    if [ "$fichier" -nt "$fichier2" ];then echo "$fichier est plus récent que le $fichier2";fi
    if [ "$fichier" -ot "$fichier2" ];then echo "$fichier est plus ancien $fichier2";fi


Opérateurs comparaisons chaînes de caractère :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **-n** vrai si la longueur de la chaîne est non-nulle (*n* -> **null**)
- **-z** vrai si la longueur de la chaîne est nulle (*z* -> **zero**)
- **=** vrai si les deux expressions si identiques 
- **==** vrai si les deux expressions si identiques 
- **!=** vrai si les deux expressions sont différentes

Exemples :
~~~~~~~~~~

.. code:: bash

    # Variables
    chaine_1="bash"
    chaine_2=""

    # Actions
    if [ -n "$chaine_1" ];then echo "La chaîne $chaine_1 est non nulle";fi
    if [ -n "$chaine_2" ];then echo "La chaîne $chaine_1 est nulle";fi
    if [ "$chaine_1" = "$chaine_2" ];then echo "La chaîne 1 est égale à la chaîne 2";fi
    if [ "$chaine_1" == "$chaine_2" ];then echo "La chaîne 1 est égale à la chaîne 2";fi
    if [ "$chaine_1" != "$chaine_2" ];then echo "La chaîne 1 est != de la chaîne 2";fi

Opérateurs comparaisons entiers :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **-eq** vrai en cas d'égalité (*eq* -> **equal**)
- **-ne** vrai en cas d'inégalité (*ne* -> **not equal**)
- **-gt** vrai en cas de supériorité stricte (*gt* -> **grower than**)
- **-ge** vrai en cas de supériorité ou d'égalité (*ge* -> **grower or equal**)
- **-lt** vrai en cas d'infériorité stricte (*lt* -> **lower than**)
- **-le** vrai en cas d'infériorité ou d'égalité (*le* -> **lower or equal**)

Exemples :
~~~~~~~~~~

.. code:: bash

    # Vérification utilisateur
    if [ $(echo $UID) -ne 0 ]; then echo "Pas root";fi
    if [ $(echo $UID) -ge 1000 ]; then echo "Simple utilisateur";fi

    # Comparons des nombres
    if [ 4 -eq 4 ]; then echo "Les deux nombres sont égaux";fi
    if [ 5 -ne 4 ]; then echo "Les deux nombres sont inégaux";fi
    if [ 5 -gt 4 ]; then echo "Nombre 1 est plus grand que nombre 2";fi
    if [ 4 -ge 4 ]; then echo "Nombre 1 est plus grand ou égal à nombre 2";fi
    if [ 3 -lt 4 ]; then echo "Nombre 1 est plus petit que nombre 2";fi
    if [ 4 -le 4 ]; then echo "Nombre 1 est plus petit ou égal à nombre 2";fi

Cas spéciaux / complexes :
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash
    
    # Tester le code de retour de la commande précédente 
    if [ $? -ne 0 ];then 
        echo "la commande précédente n'a pas rencontré de problème(s)";
    fi

    if [ $(ls /home/) ]; then
        echo "La commande précédente n'a pas rencontré de problème(s)";
    fi

    # Test --> ET LOGIQUE
    # Variables
    prenom="Antoine"
    nom="LeBarbu"
    role="admin"
    
    # Actions 
    if [ "$prenom" = "Antoine" ] && [ "$nom" = "LeBarbu" ] && [ "$role" = "admin" ];then
        echo "Les trois conditions sont respectées"
    fi

    # Test --> OU LOGIQUE
    #Variables
    prenom="Antoine"
    nom="LeBarbu"
    role="admin"

    # Actions
    if [ "$prenom" = "Antoine" ] || [ "$nom" = "LeBarbu" ] || [ "$role" = "admin" ];then
        echo "Une (ou +) des trois conditions est au moins respectée"
    fi


Exemple
~~~~~~~

.. code:: bash
    
    # Variables
    prenom="Thomas"

    # Testons le ET LOGIQUE
    if [ "$prenom" = "Thomas" ] && [ $(echo $UID) -ne 0 ]; then 
        echo "Thomas - simple utilisateur";
    fi

**Case** en BASH :
~~~~~~~~~~~~~~~~~~

Ce que l'on appelle *case* est une instruction permettant de gérer plusieurs cas. Cette action est implémentée dans beaucoup de langages avec des noms différents (**switch** en *PHP*, *C* ...). Une application concrète va vous éclairer rapidement sur son utilisation :

.. code:: bash

    # le switch de bash
    
    # affichage d'un menu

    cat<<-EOF

    [1]. Steak
    [2]. Poisson
    [3]. Salade Salakis

    EOF

    # action
    read -p "Saisir votre choix : " choix

    case "$choix" in
        1   ) echo "Un bon gros Charal y'a rien de mieux !"     ;;
        2   ) echo "C'est un bon poissonnet !"                  ;;
        3   ) echo "Salakis au bon lait de brebisssss !"        ;;
        *   ) echo "Erreur de repas, bye !"                     ;;
    esac

Cet exemple affiche dans un premier temps le choix des menus à l'écran (**cat<<-EOF** jusqu'au second **EOF**) puis demande à l'utilisateur de saisir son voeu (**read -p "Saisir votre choix " choix**) qui sera stocké dans la variable *choix*. Ensuite vient la partie intéressante le case qui peut se résumer de la manière suivante ici : si le contenu de la variable *choix* est égal à 1 (soit le steak) alors afficher *Un bon gros Charal y'a rien de mieux !"*, sinon si la variable *choix*
égale à 2 alors afficher *C'est un bon poissonnet* sinon si la variable *choix* est égale à3 afficher *Salakis au bon lait de brebisssss* sinon dans tous les autres cas non traités afficher *Erreur de repas, bye*.

D'autres possibilités de **case** :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    # variable note sur 15
    read -p "Saisir votre note sur 15 : " note

    case "$note" in
    
    1[0-5]              )   echo "Votre note est excellent"                ;;
    [0-9]               )   echo "Votre note sur 60 est variable"          ;;
    absent|inapte|abs   )   echo "Une chance que vous ayez été malade"     ;;
    *                   )   echo "Erreur"                                  ;;
    esac

Ainsi comme vous le voyez il est possible de combiner plusieurs cas avec **|** signifiant *ou* mais aussi de mettre des expressions régulières **[0-9]**...
