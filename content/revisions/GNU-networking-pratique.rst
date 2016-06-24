GNU/Linux Networking - Technique
################################

:date: 2015-09-11
:author: Mobius
:category: Révisions

Configuration du matériel
=========================

Aujourd'hui, la prise en charge du matériel réseau pour la plupart des distributions GNU/Linux n'est plus un problème, particulièrement la gestion des interfaces réseau filaires qui seront généralement fonctionnelles post-installation. La prise en charge de la technologie **wireless fidelity** est quant elle plus tendancieuse, en effet de nombreuses cartes ne sont pas directement reconnues après l'installation de votre distribution et cela en raison de la non implémentation des drivers appropriés. Il faut savoir que des paquets sont néanmoins disponibles pour remédier à ces problèmes récurrents : 

- **firmware-realtek** permettant la prise en charge des équipements Realteck
- **firmware-ralink** permettant la prise en charge des équipements Ralink
- **firmware-iwlwifi** permettant la prise en charge des équipements Intel
- **firmware-atheros** permettant la prise en charge des équipements Atheros.

Mais malgré ces pilotes disponibles sous GNU/Linux, parfois les cartes peuvent se montrer récalcitrantes et ne voudront toujours pas fonctionner. Sachez à titre d'information qu'un outil **ndiswrapper** permettra d'utiliser les pilotes Windows pour les implémenter dans votre distribution GNU/Linux.

Les commandes pour interférer sur le matériel réseau
----------------------------------------------------

La première commande à connaître sous GNU/Linux pour vérifier que votre matériel réseau est bel et bien fonctionnel est la commande **ifconfig**, diminutif de l'anglais *interface configuration*. Il faut savoir que cette commande aujourd'hui est dépréciée au profit de la commande **ip** mais reste encore très largement répandue et utilisée. Cette commande va permettre de contrôler l'état de votre interface réseau, autrement dit savoir si votre carte ethernet, wifi sont actives, démarrées, si elles bénéficient d'un adressage IP opérationnel ... Voici les principales combinaisons 

.. code:: bash

	# voir l'ensemble des cartes actives et fonctionnelles
	$ ifconfig	
	
	# voir toutes les cartes présentes (actives et non actives)
	$ ifconfig --all 

	# Désactiver l'interface ethernet n°1
	$ ifconfig eth1 down

	# activer l'interface ethernet n°1
	$ ifconfig eth1 up

	# attribuer dynamiquement un adressage IP à l'interface ethernet n°1
	$ ifconfig eth1 192.168.1.1 netmask 255.255.255.0

	# ajouter une adresse virtuelle à l'interface ethernet n°1
	$ ifconfig eth1:0 10.1.1.1 netmask 255.255.0.0

Pour ceux qui viennent à se demander à quoi sert d'ajouter une adresse virtuelle à une interface, je les invite à lire mon prochain cours traitant justement de l'**IP aliasing**. Pour expliquer très rapidement, cela consiste à attribuer une deuxième adresse IP à notre interface, autrement si vous amusez à faire un ping sur votre adressage principal (192.168.1.1 ici) et un autre sur votre alias virtuel (10.1.1.1) voici les résultats :

.. code:: bash

	$ ping 192.168.1.1
	PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
	64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=0.073 ms
	64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=0.078 ms
	--- 192.168.1.1 ping statistics ---
	4 packets transmitted, 4 received, 0% packet loss, time 2999ms
	rtt min/avg/max/mdev = 0.073/0.075/0.078/0.009 msu

	$ ping 10.1.1.1
	PING 10.1.1.1 (10.1.1.1) 56(84) bytes of data.
	64 bytes from 10.1.1.1: icmp_seq=3 ttl=64 time=0.073 ms
	64 bytes from 10.1.1.1: icmp_seq=4 ttl=64 time=0.078 ms
	--- 10.1.1.1  ping statistics ---
	4 packets transmitted, 4 received, 0% packet loss, time 2999ms
	rtt min/avg/max/mdev = 0.073/0.075/0.078/0.009 msu

Les deux résultats s'avèrent être concluant, votre interface répond désormais à deux adresses IP différentes. Intéressons nous dès à présent à la notion de routes, étape fondamentale dans le monde des réseaux. Ce nom route est à assimiler aux routes ferroviaires, routières que nous connaissons très bien. Il s'agit de créer un itinéraire pour permettre l'acheminer de vos paquets TCP/IP, à travers le réseau pour garantir l'échange entre par exemple une machine cliente et un serveur web. Les commandes les plus efficientes pour la gestion des routes sont les suivantes :

.. code:: bash

	# ajouter une route pour le réseau 172.15.0.0/16 ayant comme passerelle par défaut 192.168.1.254
	$ route add -net 172.15.0.0 netmask 255.255.0.0 gw 192.168.1.254

	# supprimer une route emmenant au réseau 172.15.0.0/16
	$ route del -net 172.15.0.0 netmask 255.255.0.0

	# supprimer la route par défaut
	$ route del default 

	# ajouter la route par défaut
	$ route add default gw 192.168.1.254
