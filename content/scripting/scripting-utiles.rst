Scripts utiles
##############

:date: 2015-02-25
:author: Mobius
:category: Scripting

Vérification root
~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    # Be root or not to be

    # Toutes les lignes contenant un $(commande) font appel à un sous-shell.
    # Une autre solution consiste à utiliser les back-quotes `ma commande` qui ne feront toutefois pas appel à un sous-shell (rapidité moindre)
    # exemple : $(whoami) est "équivalent" dans le résultat à l'utilisation de `whoami`

    # variables couleurs
    RC='\e[1;31m'
    NC='\e[0;m'

    # vérification avec USER ID 
    if [ $(echo $UID) -ne 0 ];then 
        echo -e "$RC Must be root to perform this action !$NC"; 
        exit 1;
    fi

    # vérification avec LOGNAME
    if [ $(echo $LOGNAME) != 'root' ];then

        echo -e "$RC Must be root to perform this action !$NC"; 
        exit 1;
    fi

    # vérification avec WHOAMI
    if [ $(whoami) != 'root' ];then
        echo -e "$RC Must be root to perform this action !$NC"; 
        exit 1;
    fi

    # vérification avec $USER 
    if [ $(echo $USER) != 'root' ];then
        echo -e "$RC Must be root to perform this action !$NC"; 
        exit 1;
    fi


Opérations utiles variables String
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    # Uppercase ou Lowercase, longueur d'une chaîne

    # variable
    min='un texte en minuscule qui doit apparaître en majuscule'
    maj='UN TEXTE EN MAJUSCULE QUI DOIT APPARAITRE EN MINUSCULE' 

    echo ${min^^}
    echo ${maj,,}
    echo "la variable 'min' a une longueur de : ${#min}"
    echo "la variable 'maj' a une longueur de : ${#maj}"

Parcourir un fichier
~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    # Parcourir un fichier ligne par ligne
    while read line
    do
        echo -e "$line"
    done < mon_fichier

Manipuler les tableaux
~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    # Tableau coloré
    declare -a colors='(
                            [0]="\e[0;m"
                            [1]="\e[1;31m"
                            [2]="\e[1;32m"
                            [3]="\e[1;33m"
                            [4]="\e[1;34m"
                            [5]="\e[1;35m"
                       )'

    # Parcourir un tableau
    for i in ${!colors[*]}
    do
        echo -e "${colors[i]} waow c'est beau !"
    done

Créer des fonctions
~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    # création d'une super fonction
    bonjour()
    {
        echo "bonjour $1"
    }

    bonjour "mobius"

Générer des mots de passe
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    # Générer un mot de passe avec x caractères (ici 36)
    cat /dev/urandom | tr -dc '0-9a-zA-Z!@#$%^&*_+-' | head -c 36
