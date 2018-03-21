#!/bin/sh

SCRIPT=$(greadlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

ln -s $SCRIPTPATH/.gitconfig ~
ln -s $SCRIPTPATH/.gitignore ~
ln -s $SCRIPTPATH/.vimrc ~
ln -s $SCRIPTPATH/.zshrc ~

mkdir -p ~/.vim/backups
