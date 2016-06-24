I Love Linux #2
###############

:date: 2015-02-26
:author: Mobius
:category: Linux

Tout système **GNU/Linux** interagit avec ce que l'on appelle des *niveaux d'exécution*. Par ailleurs, le système est toujours enfermé dans un *niveau d'exécution* et cela en abstraction de son activité propre (*serveur*, *desktop* ...). Pour donner une définition claire et simple, un *niveau d'exécution* est une sorte d'interface fonctionnelle qui définit scrupuleusement la liste des services qui doivent être en fonctionnement ou bien arrêtés. Ainsi, dès lors que le système change
de *niveau* il va vérifier quels sont les services à démarrer et au contraire quels sont ceux à arrêter.

Présentation des niveaux
========================

- **Niveau 0** : c'est le premier niveau, le système est inopérant, physiquement arrêté. Aussi surprenant que cela puisse paraître, ce *niveau 0* demande une configuration comme tout autre niveau qui se respecte : en effet, dès lors que le système va entrer en *niveau 0*, il faut que la gestion des services soit décrite (les services à arrêter).

- **Niveau 1** ou **Single Level** : ce niveau **1** ce distingue des autres car il a la particularité de correspondre à un état de maintenance. Dès lors, seule le *root* peut se connecter à la machine, la majorité des services sont inopérant car arrêtés, seule l'activité la plus basique est exploitable. Les opérations de maintenance peuvent se dérouler tranquillement.

- **Niveau 2** : ce niveau n'est que rarement utilisé, dédié à l'administrateur qui peut lui conférer un mode de fonctionnement particulier (libre est à lui de choisir les services démarrés et ceux arrêtés). Notons que sur les distributions héritées de **Debian**, ce niveau est fonctionnel par défaut.

- **Niveau 3** : ce niveau démarre tous les services à l'exception de l'interface graphique. Sur la majorité des systèmes, ce service est fonctionnel par défaut.

- **Niveau 4** : à l'instar du niveau 2, ce niveau est réservé à l'administrateur qui peut lui attribuer un fonctionnement particulier.

- **Niveau 5** : tous les services sont démarrés ainsi que l'interface graphique. Sur les distributions dérivées de **Debian**, ce niveau n'est pas utilisé.

- **Niveau 6** : état éphémère correspondant à un état de redémarrage *reboot*. La configuration du **niveau 6** consistera à définir les services à arrêter lors du redémarrage. Ensuite, dès lors que le redémarrge sera terminé, le système entrera dans un autre **niveau d'exécution** (en général celui correspondant au niveau par *défaut*).

Le grand architecte
====================

En effet, il est légitime de se demander qui dispose du choix de changer le niveau d'exécution lorsque l'on a installé son système. La réponse n'est autre que la distribution elle-même. Néanmoins,  **l'administrateur** est libre de préférer une gestion personnelle en modifiant la configuration de ces-dits niveaux et en choisissant le niveau fonctionnel (autrement dit dans quel état de la machine ces niveaux sont opérants) propre à chacun des niveaux. Pour rappel, chaque niveau
d'exécution va interférer dès lors avec les services du système, soit en les arrêtant soit en les démarrant.

Je suis ton père
====================

je vous propose de faire une petite commande en introduction :

.. code:: bash

    $ ps -ef | head
    UID   PID   PPID   C   CTIME   TTY       TIME     CMD
    root    1      0   0   10:08     ?   00:00:14  init[5]

Cette commande listant les processus est particulièrement intéressante : en première position nous pouvons voir qu'un certain processus nommé **init** est lancé avec un PPID (*Parent Process Identification*) égal à **0**. Autrement dit, **init** est le processus père de tous les autres processus. En effet, ce sera le premier à être lancé lors du chargement de votre noyau *kernel*. Toute sa configuration est disponible dans le fichier **/etc/inittab** vous pourrez admirer en tout heure la beauté
de son fonctionnement.

Le fichier **/etc/inittab**
===========================

Il faut savoir en préambule que le contenu du fichier **/etc/inittab** diffère d'une distribution à une autre. Malgré cela, ce fichier adopte toujours des similarités communes : **identifiant**:**niveau**:**mode_action**:**commande**

Explorons */etc/inittab*
~~~~~~~~~~~~~~~~~~~~~~~~

- *identifiant* : chaîne alphanumérique composée d'un ou deux caractères, permettant d'identifier précisemment la ligne. Restriction : une ligne à un identifiant propre

- *niveau* : définit le niveau d'exécution (en chiffres)

- *mode_action* : correspond à des modes modèles permettant de définir l'exécution de la commande

- *commande* : la commande à exécuter en fonction d'un niveau ou des niveaux paramétré(s) en fonction du mode d'action

Les modes d'actions habituels 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- *initdefault* : dans ce mode le champ *commande* est inexistant (vide). Sa fonction ne sert qu'à définir le niveau d'exécution du système par défaut

- *sysinit* : permet d'exécuter des scripts lors de la phase d'initialisation du système et cela en totale abstraction du niveau d'exécution. Ainsi le deuxième champ est inexistant (vide)

- *wait* : exécute la commande ou le script précisé en attendant la fin de l'exécution de ce-dernier ou de cette-dernière pour passer aux autres lignes du fichier inittab

- *respawn* : permet d'exécuter la commande en veillant à ce que son processus figure en background. Interprète les lignes suivantes du fichier inittab ; si le processus de la commande vient à s'arrêter alors init le rappelera de manière systématique.

Exemple d'un fichier **inittab** d'une distribution RedHat
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    id:5:initdefault:
    si::sysinit:/etc/rc.d/rc.sysinit
    10:0:wait:/etc/rc.d/rc 0
    11:1:wait:/etc/rc.d/rc 1
    12:2:wait:/etc/rc.d/rc 2
    13:3:wait:/etc/rc.d/rc 3
    14:4:wait:/etc/rc.d/rc 4
    15:5:wait:/etc/rc.d/rc 5
    16:6:wait:/etc/rc.d/rc 6
    x:5:respawn:/etc/X11/prefdm -nodaemon

Les services du système
=======================

Tout système GNU/Linux exécute les différents services par l'intermédiaire de scripts normalisés, situés dans le répertoire **/etc/init.d/** (physiquement ou en tant que lien symbolique) et comportent deux états, paramètres obligatoires : **start** pour lancer le service et **stop** pour l'arrêt du service.

.. code:: bash

    /etc/init.d/nom_du_service start
    /etc/init.d/nom_du_service stop

ou bien 

.. code:: bash

    service nom_du_service start
    service nom_du_service stop

D'autres paramètres sont souvent utilisés comme *restart* pour redémarrer le service ou encore *status* indiquant l'état du service. Il faut savoir maintenant que l'utilisation de la commande *service* est couramment préférée puisqu'en effet le service sera lancé en s'affranchissant au maximum de l'environnement (pwd, variables ...). Le service sera dès lors démarré au sein d'un environnement plus sain, neutre et moins exposé aux différentes anomalies éventuelles découlant de
l'environnement.

Format d'un script de service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    #!/bin/bash -
    case $1 in
    start)
        # commande permettant de lancer le service
    ;;
    stop)
        # commande permettant d'arrêter le service
    ;;
    esac

79
