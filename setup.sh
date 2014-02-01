#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

ln -s $SCRIPTPATH/.gitconfig ~
ln -s $SCRIPTPATH/.gitignore ~
ln -s $SCRIPTPATH/.vimrc ~

mkdir -p ~/.vim/backups
