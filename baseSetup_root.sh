#!/bin/bash
# this script is Ubuntu14.04 bash( bash is /bin/bash not /bin/sh ) only.
dpkg --add-architecture i386
apt-get update -y
apt-get install -y vim

# required modules.
apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
apt-get install -y build-essential libffi-dev
apt-get install -y libssl-dev git socat wget
apt-get install -y gcc-multilib lib32z1 lib32ncurses5 lib32bz2-1.0
apt-get install -y clang gdb gdbserver

# virtualenv / mkvirtualenv
apt-get install -y virtualenvwrapper
# bash enable mkvirtualenv
echo "source /etc/bash_completion.d/virtualenvwrapper" >> ~/.bashrc
# enable mkvirtualenv
source /etc/bash_completion.d/virtualenvwrapper
# angr / pwntools
mkvirtualenv ctf
apt-get install -y python3 python3-dev python3-pip
pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git
# etc
git clone https://github.com/longld/peda.git ~/.peda
echo "source ~/.peda/peda.py" >> ~/.gdbinit
echo "alias gdb='gdb -q'">> ~/.bash_aliases
# rp++
wget https://github.com/downloads/0vercl0k/rp/rp-lin-x64
chmod +x rp-lin-x64
mv rp-lin-x64 /usr/local/bin
echo "alias rp++='rp-lin-x64 -r 3 -f'">> ~/.bash_aliases
echo "alias less='less -R'">> ~/.bash_aliases

# print usage
echo ""
echo ""
echo "----install success!----"
echo "pwntools / angr is installed in the virtual environment."
echo "For instructions on how enter the virtual environment,"
echo "see the following command."
echo "(*** Plaease restart bash before trying the following command. ***)"
echo "======================================================"
echo "$ workon ctf <== move to virtual environment \"ctf\"" 
echo "(ctf)$ <== virtual environment"
echo "(ctf)$ deactivate <== move to real environment"
echo "$  <== real environment"
echo "======================================================"
echo "ctf enjoy!"

