Installation PIP
################

:date: 2015-02-27
:author: Mobius
:category: Python

Pourquoi installer PIP
======================

**PIP** permet d'installer facilement et sans encombre tous les *packages* disponibles pour agrémenter la saveur de **Python**. Il est donc vivement conseillé de procéder à son installation. Ensemble nous allons voir les différentes étapes pour pouvoir bénéficier de cet outil de package sous les distributions Ubuntu ainsi que ses distributions dérivées.

Les étapes de l'installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ouvrez votre terminal *préféré* ou bien celui par défaut ([CTRL]+[ALT]+[T]) et saisissez les informations suivantes :

.. code:: bash

    $ sudo apt-get install python-pip python-dev build-essential
    $ sudo pip install --upgrade pip

Voilà **PIP** est installé, à cela nous pouvons ajouter l'installation des environnements virtuels avec *virtualenv* :

.. code:: bash

    $ sudo pip install --upgrade virtualenv
