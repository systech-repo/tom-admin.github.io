Github et Pelican
#################

:date: 2015-03-10
:author: Mobius
:category: Pelican
:tags: pelican, github, git

Publier son site Pelican
========================

Nous allons voir les différentes étapes pour publier notre site internet généré par **Pelican** sur la plateforme github. Ainsi, nous disposerons d'un site qui bénéficie d'un *certificat SSL reconnu* (pas d'alerte dans le navigateur de l'internaute donc), mais aussi des sources de notre site internet.

Partons de rien
~~~~~~~~~~~~~~~

Nous allons partir de rien (pas de site Pelican déjà présent) pour illustrer cette simplicité enfantine qu'est de publier pelican sur github. Pour cela première chose à faire, se créer un compte sur github : https://github.com/join

.. image:: images/github_signup.png
	:height: 500px
	:width: 836 px

Saisir l'ensemble des informations requises. Une fois cela effectué, votre espace github s'ouvre à vous (pensez à valider votre email). Cliquez à droite en haut de l'écran sur **New repository**

.. image:: images/github_new_repo.png
	:height: 500px
	:width: 836 px

Respectez cette syntaxe pour le nom de votre repo : **votre-nom-utilisateur.github.io**

.. image:: images/creation_repo.png
	:height: 500px
	:width: 836 px

Si tout ce passe pour le mieux dans le meilleur des mondes, alors github va vous le faire savoir par le message suivant, vous invitant à faire votre premier *commit* :

.. image:: images/repo_ok.png
	:height: 500px
	:width: 836 px


Voilà tout est configuré sur github, maintenant il nous reste à paramétrer git. Mais avant, comme dit précédemment je pars de rien, donc il me faut créer un blog par le divin Pelican. Ainsi, j'entre en mode rambo_ énervé et je rentre frénétiquement dans le terminal les commandes suivantes :

.. code:: bash

	$ mkdir blog && cd blog && pelican-quickstart
	
L'interrogatoire commence, je remplis les questions comme il me convient puis une fois cela réalisé je me déplace dans le dossier content en vue de créer mon premier article.


.. _rambo: https://static.squarespace.com/static/51b3dc8ee4b051b96ceb10de/51ce6099e4b0d911b4489b79/51ce61b8e4b0d911b449e6fe/1313793167043/1000w/ramboV3.jpeg

Git
~~~

Première chose, vérifier que git est installé en ouvrant le terminal ([CTRL]+[ALT]+[T] pour les personnes sous Ubuntu et dérivés)

.. code:: bash
	
	$ whereis git
	git: /usr/bin/git /usr/bin/X11/git /usr/share/man/man1/git.1.gz

Si cette dernière ligne s'affiche *git: /usr/bin/git /usr/bin/X11/git /usr/share/man/man1/git.1.gz* alors tout est bon git est installé, sinon saisir toujours dans le terminal :

.. code:: bash

	$ sudo apt-get install git -y

Maintenant que cette vérification est faites, nous allons configurer *git*.

.. code:: bash

	$ git config --global user.name "saisir-votre-nom"
	$ git config --global user.email "saisir-votre-mot-de-passe"
	$ git config --global http.postBuffer 52428800
	$ git config --global color.ui true
	$ git remote add origin https://github.com/votre-nom-utilisateur/nom-de-votre-repository.git

Maintenant nous allons créer un fichier *.gitignore* permettant de ne pas uploader les fichiers que nous allons spécifier :

.. code:: bash
	
	echo "output
	*.pyc
	*.pid
	Makefile
	develop_server.sh
	*.sh
	*.py
	.gitignore
	.*">.gitignore

Ceci fait, il nous faut créer notre premier commit vide, puis renommer notre *master* en *source* (on transfère notre master dans une branche source plus exactement):

.. code:: bash

	$ git commit --allow-empty -m "le message de votre choix" 
	$ git branch -m master source
	$ git add .
	$ git commit -m 'le message de votre choix'
	$ git push origin source 
	
Les sources sont désormais présentes dans votre repository, il nous reste plus qu'à mettre en place notre site sur github :

.. code:: bash

	$ make html
	$ ghp-import output
	$ git push origin gh-pages:master

Si vous avez rencontré un problème vous avez la possibilité de visionner en vidéo selon la vitesse de votre choix toutes les opérations que nous avons effectuées ci-dessus : voir_

.. _voir: http://antre-du-tux.info/demos/git.html

Scripts pour les feignasses
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Voici le script pour publier votre site internet généré par Pelican sur votre github. Le paramétrage a été fait pour une connexion HTTPS et non SSH, mais libre à vous de le changer en décommentant la ligne 	# SSH connection --> git remote add origin git\@github.com:"$user"/"$repo" et en commentant par un *#* la ligne 	git remote add origin \https://github.com/"$user"/"$repo".

.. code:: bash

	#!/bin/bash - 
	#----------------------------------------------------------------
	# Dependencies - GH-IMPORT
	#----------------------------------------------------------------
	if [ -z $(whereis dh-import) ]; then 
		echo -e "\e[1;31mdh-import not installed, please run 'sudo pip install gh-import'\e[0;m";
		exit 1;
	fi;
	
	#----------------------------------------------------------------
	# Git Intialize && set up the config (repository, name, email)
	#----------------------------------------------------------------
	clear && read -p "Who is the user ? " user
	read -p "What's your name ? " name
	read -p "What's your email ? " email
	read -p "Repository's name ? (don't forget .git)" repo

	#----------------------------------------------------------------
	# Git Intialize && set up the config (repository, name, email)
	#----------------------------------------------------------------
	git init
	git remote add origin https://github.com/"$user"/"$repo"
	# SSH connection --> git remote add origin git@github.com:"$user"/"$repo" 
	git remote add origin https://github.com/"$user"/"$repo"
	git config --global user.name "$name"
	git config --global user.email "$email"
	git config --global http.postBuffer 52428800

	echo "output
	*.pyc
	*.pid
	Makefile
	develop_server.sh
	*.sh
	*.py
	.gitignore
	.*
	"> .gitignore

	#----------------------------------------------------------------
	# Commit website's sources
	#----------------------------------------------------------------
	git commit --allow-empty -m "initial commit" 
	git branch -m master source
	git add .
	git commit -m 'Création du source'
	git push origin source 

	#----------------------------------------------------------------
	# Initialize your web site 
	#----------------------------------------------------------------
	make html
	ghp-import output
	git push origin gh-pages:master
	
Le script suivant a pour objectif de **mettre à jour** votre *site* ainsi que ses *sources*, dès que vous rajoutez de nouveaux articles, pages ... 

.. code:: bash

	#!/bin/bash -
	#----------------------------------------------------------------
	# Sources updates
	#----------------------------------------------------------------
	echo -e "\e[1;34mUpdating sources ... \e[0;m"
	git add .
	git commit -m 'up'
	git push origin source
	
	#----------------------------------------------------------------
	# Site updates
	#----------------------------------------------------------------
	echo -e "\e[1;34mUpdating site ... \e[0;m"
	make html
	ghp-import output
	git push origin gh-pages:master

Vous pouvez maintenant enregistrer le script de mise à jour dans un dossier, créer un *alias* dans votre bashrc qui pointe sur ce script, ou bien créer une fonction directement dans votre bashrc contenant ce code.
	
