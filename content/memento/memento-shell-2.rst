Shell Memento #2
################

:date: 2015-02-23
:autheur: Mobius
:category: Memento

Les Boucles
===========

Structure de base
~~~~~~~~~~~~~~~~~

.. code:: bash

    # tant que ma condition est vérifiée faire
    while [ condition ];
    do
        action(s)
    done

    # tant que avec un for
    for i in ma_variable
    do
        action(s)
    done

    # jusqu'à ce que ma condition précisée soit réalisée
    until [ condition ]
    do
        action(s)
    done

Exemples :
~~~~~~~~~~

.. code:: bash

    # exemple boucle while
    # variable
    i=0
    
    # action
    while [ "$i" -ne 10 ];
    do
        echo "$i. coucou"
        let i=$i+1
    done

    # exemple boucle for
    #variable
    declare -a tableau='([0]="pomme" [1]="kiwi" [2]="orange")'

    # action
    for i in ${!tableau[*]}
    do
        echo "${tableau[i]}"
    done

    # exemple boucle until
    # variable
    i=0
    until [ "$i" -eq 10 ];
    do
        echo "$i. coucou"
        let i=$i+1
    done

Cas spéciaux / complexes :
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash
    
    # boucle for avec liste des arguments
    for i in $*
    do
        echo "$i"
    done

    # boucle for listant un résultat d'une commande
    for i in $(ls /home/$USER)
    do
        echo "$i"
    done

    # boucle infinie
    while true

    # boucle while tant que le nombre d'arguments est différent de 0
    while [ $# -ne 0 ];
    do
        echo "ok"
    done

Instructions utiles :
~~~~~~~~~~~~~~~~~~~~~

- **break** permet de sortir *casser* une boucle
- **continue** permet de passer à l'itération suivante précisée dans la boucle
- **exit [x]** permet de sortir d'un script shell avec le statut *x* : **0** pour succès, **1** pour erreur ainsi que toute valeur **x** différente de 0

Exemples :
~~~~~~~~~~

.. code:: bash

    # boucle avec l'instruction break
    # variable
    i=0
    
    # action
    while [ "$i" -ne 4 ];
    do
        let i=$i+1
        echo "La boucle s'arrête dès que $i aura la valeur 3 pour le moment i=$i"
        if ["$i" -eq 3 ];then
            break;
        fi
    done

    # boucle avec l'instruction exit
    # variable
    i=0

    # action
    while ["$i" -ne 4 ];
    do
        let i=$i+1
        echo "Le script s'arrête dès que i aura la valeur 3, pour le moment i=$i"
        if [ "$i" -eq 3 ];then
            exit 1;
        fi
    done

En pratique la commande **break** fonctionne mais dans beaucoup de cas elle s'avère inutile, car un script correctement codé devrait bien implémenter les cas dans lesquels la boucle doit s'arrêter.
