#!/bin/bash

sbn_deploy () {
    ln -s "$(readlink -f $1)" "/home/$USER/$1"
}


sbn_deploy .emacs.d
sbn_deploy .vimrc

