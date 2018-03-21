#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

ln -s $SCRIPTPATH/.gitconfig ~
ln -s $SCRIPTPATH/.gitignore ~
ln -s $SCRIPTPATH/.vimrc ~
ln -s $SCRIPTPATH/.zshrc ~
ln -s $SCRIPTPATH/.lessfilter ~

mkdir -p ~/.vim/backups
