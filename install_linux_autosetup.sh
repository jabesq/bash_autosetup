#!/bin/bash

echo "include ${HOME}/linux_autosetup/ALL.nanorc" > ~/.nanorc
echo "source ${HOME}/linux_autosetup/bashrc" > ~/.bashrc

if [ "$(uname)" == "Darwin" ]; then
    echo "DARWIN"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    if ! grep -q "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        echo "Updating repository in order to have access to the latest version of Git"
        sudo -E add-apt-repository ppa:git-core/ppa
        sudo apt-get -q update
        sudo apt-get -q upgrade
    fi

    sudo apt-get install git-all terminator tree diffuse meld ctags gedit-plugins nfs-common vim-gtk gcc gcc-arm-linux-gnueabi build-essential libc6-dev-i386 gtk+2.0 libqt4-dev pkg-config
    git --version
    terminator --version
    tree --version
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "MINGW32_NT"
fi

sh ${HOME}/linux_autosetup/install_awesome_vimrc.sh > /dev/null


echo "Please enter Git global username, followed by [ENTER]:"
read name

echo "Please enter Git global user mail, followed by [ENTER]:"
read mail

sed 's/name\ \=/name\ \= \'"$name"'/g' gitconfig | sed 's/email\ \=/email\ \= \'"$mail"'/g' > ~/.gitconfig
echo "Installed the Linux autosetup configuration successfully! Enjoy :-)"
