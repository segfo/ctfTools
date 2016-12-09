#!/bin/bash
# this script is Ubuntu14.04 bash( bash is /bin/bash not /bin/sh ) only.
sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt-get install -y vim
# sudo authentication not require.
LANG=C xdg-user-dirs-gtk-update
sudo update-alternatives --config editor
sudo visudo
# required modules.
sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt-get install -y build-essential libffi-dev
sudo apt-get install -y python-all python-all-dev python-pip libssl-dev git socat 
sudo apt-get install -y gcc-multilib lib32z1 lib32ncurses5 lib32bz2-1.0
sudo apt-get install -y clang gdbserver

# virtualenv / mkvirtualenv
sudo apt-get install -y virtualenvwrapper
# bash enable mkvirtualenv
echo "source /etc/bash_completion.d/virtualenvwrapper" >> ~/.bashrc
# enable mkvirtualenv
source /etc/bash_completion.d/virtualenvwrapper
# angr / pwntools
mkvirtualenv ctf
pip install --upgrade pwntools
pip install --upgrade angr
# etc
git clone https://github.com/longld/peda.git ~/.peda
echo "source ~/.peda/peda.py" >> ~/.gdbinit
echo "alias gdb='gdb -q'">> ~/.bash_aliases
# rp++
wget https://github.com/downloads/0vercl0k/rp/rp-lin-x64
sudo chmod +x rp-lin-x64
sudo mv rp-lin-x64 /usr/local/bin
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

echo "pwntools / angr is installed in the virtual environment." > usingCtfEnviromnent.txt
echo "For instructions on how enter the virtual environment," >> usingCtfEnviromnent.txt
echo "see the following command." >> usingCtfEnviromnent.txt
echo "======================================================" >> usingCtfEnviromnent.txt
echo "$ workon ctf <== move to virtual environment \"ctf\""  >> usingCtfEnviromnent.txt
echo "(ctf)$ <== virtual environment" >> usingCtfEnviromnent.txt
echo "(ctf)$ deactivate <== move to real environment" >> usingCtfEnviromnent.txt
echo "$  <== real environment" >> usingCtfEnviromnent.txt
echo "======================================================" >> usingCtfEnviromnent.txt
echo "ctf enjoy!" >> usingCtfEnviromnent.txt
