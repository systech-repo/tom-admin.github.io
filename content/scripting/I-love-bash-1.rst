I love Bash #1
###############

:date: 2015-02-24
:author: Mobius
:category: Scripting

La fameuse STDIN
================

Préambule
~~~~~~~~~

Tout programme informatique est frillant des entrées et sorties en vue d'interagir avec l'utilisateur soit par l'intermédiaire des périphériques *d'entrée* comme par exemple le *clavier* ou encore d'afficher le résultat attendu sur un périphérique de *sortie* comme *l'écran*. Un problème subsiste, la diversité des sorties potentielles. En effet, la sortie sur un périphérique comme *l'écran* aura des mécanismes différents que l'enregistrement de données dans un *fichier*. Voilà
pourquoi, nos systèmes dérivés d'Unix, pallient cette difficulté de traitement en considérant que tout est *fichier* (votre connexion, ...). Cette abstraction est dès lors indispensable en vue de faciliter la prise en charge du pluralisme des sorties.

Faire pointer la sortie dans notre terminal ou encore une fenêtre
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    $ echo Ceci est un exemple

Ce code précédent permet d'afficher dans votre console le texte *Ceci est un exemple* grâce à la commande **echo**. Cette commande n'affiche pas uniquement du texte mais tout type *d'arguments* passés (des variables...). Dans le code ci-dessus, vous remarquerez l'absence de guillemets autour de notre chaîne de caractère et ceci est tout à fait normal : le but est avant tout de comprendre le fonctionnement de la commande, ici la commande echo va bel et bien afficher le texte mais ne va en
réalité pas comprendre qu'il s'agit d'une seule et même chaîne de caractère mais comme trois arguments distincts. Ainsi, si vous faites le test de la commande suivante :

.. code:: bash

    $ echo Ceci             est         un exemple

Tout les espaces ne vont pas être interprétés car les guillemets sont absentes. Ici, bash va comprendre que vous lui soumettez trois arguments et donc séparer les résultats d'un seul espace. Maintenant faites le test suivant :

.. code:: bash

    $ echo "Ceci      est       un exemple"

Dans ce cas, bash va bien interpréter les espaces par l'intermédiaire des guillemets, signifiant qu'il s'agit d'un seul et même argument. Une autre précision, l'utilisation des guillemets et des apostrophes n'a pas les mêmes répercussions : si vous utilisez des guillemets **" "**, bash va *parser* autrement dit analyser véritablement le contenu en interprétant la présence d'éventuelle(s) variable(s) mais si vous optez pour des apostrophes alors les variables seront inopérantes.

.. code:: bash

    #!/bin/bash -
    # variable
    prenom='Thomas'
    echo "$prenom" # va renvoyer à l'écran "Thomas"
    echo '$prenom' # va renvoyer à l'écran $prenom

Dans la mesure du possible, il faut utiliser les guillemets lorsque cela est vraiment nécessaire sinon des apostrophes pour maximiser la vitesse d'exécution du programme, car oui l'analyse sous-jacente à l'utilisation des guillemets va ralentir votre script. Vous me croyez pas ? Faites donc alors ce test : enregistrez dans un premier fichier *guillemets.sh* le code suivant :

.. code:: bash

    #!/bin/bash -
    i=0
    time while [ "$i" -ne 50000 ];
    do
        echo "Ceci est un test de rapidité" 1>/dev/null # on redirige la sortie standard vers le périphérique null
        let i=$i+1
    done

Maintenant faites la même chose en enregistrant le code suivant dans un autre fichier *apostrophes.sh*:

.. code:: bash

    #!/bin/bash -
    i=0
    time while [ "$i" -ne 50000 ];
    do
        echo 'Ceci est un test de rapidité' 1>/dev/null # permet de ne pas voir à l'écran les lignes
        let i=$i+1
    done

Faites les commandes suivantes :

.. code:: bash

    $ bash guillemets.sh
    $ bash apostrophes.sh

Vous verrez directement la différence de temps d'exécution des deux scripts et l'avantage d'utiliser les guillemets uniquement si le besoin se fait sentir ! pour ma part la différence est la suivante :

.. code:: bash

    bash apostrophes.sh
    real 0m1.691s
    user 0m1.470s
    sys  0m0.216s

    bash guillemets.sh
    real 0m1.808s
    user 0m1.568s
    sys  0m0.235s

Designons notre sortie
~~~~~~~~~~~~~~~~~~~~~~

Une autre commande très utile et dérivée du langage C est la grande, l'impertinente *printf*. Le fonctionnement est le suivant : le premier argument est une chaîne de format, les arguments suivants sont mis en forme en toute corrélation avec la chaîne de format matérialisée par **%**. 

.. code:: bash

    $ printf '%s = %d\n' Code $?

Ce code nous permet de récupérer le code de la dernière commande et de mettre en forme à l'écran l'affichage grâce à la commande *printf*. L'instruction *%s* permet de préciser qu'il s'agit d'une chaîne de caractère (*s* pour *string*) et *%d* permet de préciser qu'il s'agit d'un nombre (*d* pour *decimal*). Enfin le caractère *\n* permet de sauter une ligne dans une interface commande (*\n* pour *newline*).

Ecrire une chaîne de caractère sans sauter de ligne :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Les deux instructions *echo* comme *printf* permettent de répondre à cette problématique :

.. code:: bash

    $ echo -n 'Super exemple' # -n permet de ne pas sauter de ligne
    $ echo -e 'Super exemple\c' # -e permet d'interpréter les séquences d'échappement
    $ printf "%s" Super exemple
