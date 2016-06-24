#!/bin/bash - 
#===============================================================================
#
#          FILE: installation_blog.sh
# 
#         USAGE: ./installation_blog.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Mobius (), sys.admin@gmx.fr
#  ORGANIZATION: 
#       CREATED: 03/08/2015 15:58
#      REVISION:  ---
#===============================================================================

user='tom-admin'
name='tom-admin'
email='tom-admin@tuta.io'
repo='tom-admin.github.io'

#read -p "Who is the user ? " user
#read -p "What's your name ? " name
#read -p "What's your email ? " email
#read -p "Repository's name ? (don't forget .git)" repo

#----------------------------------------------------------------
# Git Intialize && set up the config (repository, name, email)
#----------------------------------------------------------------
git init
git remote add origin https://github.com/"$user"/"$repo"
#git remote add origin git@github.com:"$user"/"$repo" # HTTPS -> 
git remote add origin https://github.com/"$user"/"$repo"
git config --global user.name "$name"
git config --global user.email "$email"

echo "output
*.pyc
*.pid
Makefile
develop_server.sh
*.sh
*.py
.gitignore
.*
script_install.html
"> .gitignore

# Master's = > Source
git commit --allow-empty -m "initial commit" 
git branch -m master source
git add .
git commit -m 'sources site'
git push origin source 

# Set up your pelican's site 
make html
ghp-import output
git push origin gh-pages:master
