#!/bin/sh
sudo apt-get install -y vim build-essential 
sudo apt-get install -y gcc-multilib lib32z1 lib32ncurses5 lib32bz2-1.0
sudo apt-get install -y python-all python-all-dev python-pip git socat 
sudo apt-get install -y libc6:i386
sudo apt-get install -y clang
sudo pip install --upgrade git+https://github.com/binjitsu/binjitsu.git
git clone https://github.com/longld/peda.git ~/.peda
echo "source ~/.peda/peda.py" >> ~/.gdbinit
echo "alias gdb='gdb -q'">> ~/.bash_aliases
wget https://github.com/downloads/0vercl0k/rp/rp-lin-x64
sudo chmod +x rp-lin-x64
sudo mv rp-lin-x64 /usr/local/bin
echo "alias rp++='rp-lin-x64 -r 3 -f'">> ~/.bash_aliases
echo "alias less='less -R'">> ~/.bash_aliases
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386

# last
LANG=C xdg-user-dirs-gtk-update
sudo update-alternatives --config editor
sudo visudo
