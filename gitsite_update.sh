#!/bin/bash - 
#===============================================================================
#
#          FILE: gitsite_update.sh
# 
#         USAGE: ./gitsite_update.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Mobius (), sys.admin@gmx.fr
#  ORGANIZATION: 
#       CREATED: 03/08/2015 16:04
#      REVISION:  ---
#===============================================================================

echo -e "\e[1;34mUpdating sources ... \e[0;m"
git add .
git commit -m 'up'
git push origin source
echo -e "\e[1;34mUpdating site ... \e[0;m"
make html
ghp-import output
git push origin gh-pages:master
