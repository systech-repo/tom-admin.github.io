Commandes de l'admin #1
#######################

:date: 2015-02-23
:author: Mobius
:category: Memento
:tags: memento, commandes, administration, debian

adduser [options] **utilisateur** [group]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette commande permet à l'administrateur de **rajouter un utilisateur** sur le système. Nous allons voir les principaux arguments que **adduser** peut prendre (*liste non exhaustive*)

- **--home** permet de définir l'emplacement précis du dossier de l'utilisateur (par défaut **/home/nom_du_user/**)
- **--no-create-home** permet de ne pas créer un dossier lors de la création de l'utilisateur
- **--system** permet de préciser que l'utilisateur est un utilisateur système
- **--shell** permet de préciser le shell qui sera utilisé par l'utilisateur
- **--group** permet de créer le groupe de l'utilisateur
- **--ingroup** permet de définir le groupe principal de l'utilisateur
- **--uid** permet de définir le *user id* soit l'identifiant de l'utilisateur
- **--gid** permet de définir le *group id* soit l'identifiant du groupe de l'utilisateur
- **--disabled-password** la commande passwd n'est pas exécutée le compte sera dès lors verrouillé
- **--disabled-login** permet de désactiver l'authentification par mot de passe, seul l'accès avec clés SSH RSA est opérant

apt-cache [options] *commande* **paquet**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cette commande permet d'obtenir des **informations sur les paquets** issus de la base de donnée Internet et du cache mis à jour depuis les sources (*/etc/apt/sources.list*).

- **add** permet de rajouter un paquet au cache
- **search** permet d'effectuer une recherche par mot-clés dans les noms et en-têtes des paquets connus
- **stats** permet de récupérer des informations statistiques de base sur le cache utilisé
- **show** permet de récupérer des informations descriptives sur le paquet ainsi que sur ses dépendances
- **depends** permet de récupérer l'ensemble des dépendances du paquets
- **pkgnames** permet de lister l'ensembles des noms des paquets
- **-i** permet de n'afficher que les dépendances importantes

apt-cdrom [options] [-d] *commande*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cette commande permet de **rajouter un nouveau cd-rom** à la liste des sources d'installation disponibles.

- **add** ajoute un cd-rom à la liste des sources
- **-d point de montage** spécifie le point de montage du cd-rom à analyser
- **-f** permet de copier rapidement (part du principe que les paquets sont valides) en ne procédant à aucune vérification
- **-r** permet de changer le nom d'un disque

apt-get [options] *commande* **paquet**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cette commande permet d'interagir avec la **gestion des paquets**.

- **update** permet de mettre à jour la base de données des paquets du cache (*/etc/apt/sources.list*) en décrivant les paquets
- **install** permet d'installer un paquet ou plusieurs paquets
- **remove** permet de supprimer un paquet ou plusieurs paquets
- **check** permet de mettre à jour le cache des paquets mais aussi de rechercher les dépendances cassées
- **source** permet de récupérer la source d'un paquet
- **clean** permet de nettoyer le dépôt local de paquets téléchargé
- **-d** permet de télécharger le ou les paquets sans procéder à l'installation ni la décompression
- **-f** tenter de corriger les dépendances cassées
- **-s** permet de simuler une commande sans effectuer réellement les opérations à effectuer
- **-y** permet de valider automatiquement les questions (lors des installations, suppressions...)
- **-q** permet d'activer le quiet mode autrement dit un mode moins verbueux
- **--no-upgrade** permet de ne pas mettre à jour les paquets installés
- **--purge** permet de supprimer les fichiers de configuration d'un paquet
- **--reinstall** permet de réinstaller un paquet dans sa dernière version

apt-setup
~~~~~~~~~
cette commande permet **d'ajouter des sources** d'installation supplémentaire.

aptitude
~~~~~~~~
cette commande permet de fournir une interface en mode console en vue de faciliter la **gestion des paquets**.

at [options] *date*
~~~~~~~~~~~~~~~~~~~
Cette commande permet de **planifier l'exécution** unique d'un script ou d'une commande.

- **-f** permet d'inclure un fichier (script)
- **atq** permet de lister les commandes en attente d'exécution
- **atrm** permet de supprimer une tâche en attente

base-config
~~~~~~~~~~~
Cette commande permet de **relancer le processus de post-installation** pour une reconfiguration.

