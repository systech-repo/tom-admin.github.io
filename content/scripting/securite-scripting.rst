Sécurité scripting
##################

:date: 2015-02-24
:author: mobius
:category: Scripting

Faire un script sécurisé
========================

Règles générales
----------------

- **Valider** toutes les entrées externes ainsi que toutes les saisies interactives
- **Ne jamais** utiliser une instruction *eval* sur une entrée non sûre
- **Utiliser** des fichiers *temporaires* **sécurisés**
- **Vérifier** que les programmes *exécutables externes* sont sûrs

Contrer usurpation de l'interpréteur
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Il suffit d'ajouter un tiret à la fin du *shebang* pour éviter les attaques par usurpation avec les droits administrateur (**setuid root**). En effet, en l'absence du tiret, le système va chercher à interpréter les paramètres qui accompagne l'interpréteur c'est pourquoi le rajout d'un tiret permet de *figer* le chemin de bash. Attention toutefois, dans certains cas ce *shebang* peut rencontrer des problèmes de portabilité.

.. code:: bash

	#!/bin/bash -

Fixer la variable $PATH
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

	#!/bin/bash -
	# définir un chemin
	PATH='/usr/local/bin:/bin:usr/bin'
	export PATH

Se méfier toujours des alias
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Un alias malveillant peut conduire à des opérations critiques sur votre système et par corollaire il est impératif de les effacer.

.. code:: bash

	#!/bin/bash -
	# supression des alias
	\unalias -a

En effet, une personne malveillante va chercher à faire exécuter une commande pour obtenir un accès à des données ou des privilèges qui lui sont interdits. Imaginons par exemple que votre commande *ls* a été modifié par un alias malveillant, il y aura de fortes probabilités que le duperie porte ses fruits. Ainsi, la solution la plus adéquate pour pallier à ce problème de sécurité est de supprimer tous les alias. Notons que le caractère \ placé en début de commande unalias permet d'éviter
la programmation d'alias. Voilà à ce quoi par exemple vous êtes exposés si vous n'utilisez pas cette commande :

.. code:: bash
    
    $ alias pwd=echo 
    $ alias echo=ls

Protéger la mémoire
~~~~~~~~~~~~~~~~~~~

Lorsque Bash exécute des commandes, il mémorise l'emplacement de celles qui se trouvent dans la variable $PATH en vue d'accélérer et donc d'optimiser les appels ultérieurs. Ainsi si une personne malveillante réussit à faire exécuter une commande à un utilisateur (voir même au *root*), il pourra réussir à obtenir des accès ou des privilèges qui lui sont interdits. Voilà pourquoi il nous faut utiliser la commande **hash -r** pour effacer les commandes mémorisées.

.. code:: bash

    #!/bin/bash -
    # effacer toutes les commandes enregistrées en mémoire
    hash -r

Récapitulatif d'un script sécurisé :
====================================

Voici le code source d'un script convenablement **sécurisé** :

.. code:: bash

    #!/bin/bash -r
    
    #--------------------------------------------------------------------------------
    # MODELE SCRIPT SECURISE
    #--------------------------------------------------------------------------------

    # Chemin PATH
    PATH='/usr/local/bin:/bin:/usr/bin'
    \export PATH

    # Suppression des alias
    \unalias -a

    # Suppression des commandes mémorisées
    hash -r

    # Désactivation des fichiers core
    ulimit -H -c 0 --

    # IFS sécurisé
    IFS=$' \t\n'

    # Protection umask
    UMASK=002
    umask $UMASK

    until [ -n "$rep_temp" -a ! -d "$rep_temp" ]; do
        rep_temp="/tmp/prefixe.${RANDOM}${RANDOM}${RANDOM}"
    done
    mkdir -p -m 0700 $rep_temp \
        || (echo "Erreur : impossible de créer le répertoire temporaire" \
            "'$rep_temp' : $?"; exit 100)
    
    # Nettoyer les fichiers temporaires
    fich_temp="rm -rf $rep_temp"
    trap "$fich_temp" ABRT EXIT HUP INT QUIT


