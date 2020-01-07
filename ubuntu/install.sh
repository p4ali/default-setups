#!/bin/bash

# Ask for sudo access at start of script
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# initial upgrade of system
sudo apt-get update -yy
sudo apt-get upgrade -yy
sudo apt-get dist-upgrade -yy

# apt repositories
echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

# ppa
sudo add-apt-repository -yy ppa:nathan-renniewaldock/flux
sudo add-apt-repository -yy ppa:danielrichter2007/grub-customizer
sudo add-apt-repository -yy ppa:neovim-ppa/stable
sudo add-apt-repository -yy universe

# repository keys
## chrome
wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -
## docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-get update

# Installations
## Essential
sudo apt-get install -yy neovim
# migrated to neovim. Left for reference
    # sudo apt-get install -yy vim
    # sudo apt-get install -yy vim-gui-common

apt-get install silversearcher-ag # ag command
sudo apt-get install -yy software-properties-common
sudo apt-get install -yy apt-transport-https
sudo apt-get install -yy ca-certificates
sudo apt-get install -yy curl
sudo apt-get install -yy gnupg-agent
sudo apt-get install -yy git
sudo apt-get install -yy tmux
sudo apt-get install -yy ctags

## C/CPP Specific
sudo apt-get install -yy build-essential
sudo apt-get install -yy cmake
sudo apt-get install -yy valgrind
sudo apt-get install -yy cscope
sudo apt-get install -yy cgdb
sudo apt-get install -yy libbsd-dev # bsd c library
sudo apt-get install -yy bear # tool for extracting compilation database
sudo apt-get install -yy checkinstall
sudo apt-get install -yy maven

## Programming Languages/Tools
sudo apt-get install -yy python
sudo apt-get install -yy python3
sudo apt-get install -yy python-dev
sudo apt-get install -yy python-pip
sudo apt-get install -yy python3-pip
sudo apt-get install -yy npm
sudo apt-get install -yy nodejs
sudo apt-get install -yy docker-ce
sudo apt-get install -yy docker-ce-cli
sudo apt-get install -yy containerd.io

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install golang
./install_go.sh

# # install go binaries
# go install github.com/zmb3/gogetdoc
# go install golang.org/x/tools/cmd/guru
# go install golang.org/x/tools/gopls@latest
# go install github.com/davidrjenni/reftools/cmd/fillstruct
# go install github.com/rogpeppe/godef
# go install github.com/fatih/motion
# go install github.com/kisielk/errcheck
# go install github.com/go-delve/delve/cmd/dlv
# go install github.com/mdempsky/gocode
# go install github.com/josharian/impl
# go install github.com/golangci/golangci-lint/cmd/golangci-lint
# go install github.com/jstemmer/gotags
# go install golang.org/x/tools/cmd/gorename
# go install golang.org/x/tools/cmd/goimports
# go install github.com/stamblerre/gocode
# go install github.com/fatih/gomodifytags
# go install honnef.co/go/tools/cmd/keyify
# go install golang.org/x/lint/golint
# go install github.com/koron/iferr
# go install github.com/klauspost/asmfmt/cmd/asmfmt
# go install github.com/alecthomas/gometalinter

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose

## Desktop Apps
#sudo apt-get install -yy shutter # screenshot capture sw
#sudo apt-get install -yy fluxgui # eye protection sw
#sudo apt-get install -yy meld # file diff comparer sw
#sudo apt-get install -yy google-chrome-stable
#sudo apt-get install -yy grub-customizer
#sudo apt-get install -yy gnome-tweak-tool
#sudo snap install telegram-desktop

## Other Options
# switch from wayland to xorg in ubuntu 17 for shutter to work
sudo sed /etc/gdm3/custom.conf -i -e \
    's/#WaylandEnable=false/WaylandEnable=false/g'

# Add current user to docker group to avoid permission denied errors
sudo groupadd docker
sudo usermod -aG docker $(whoami)

# change default resolution of grub menu on bootup
#sudo sed 's/#GRUB_GFXMODE="[[:digit:]]\+x[[:digit:]]\+"/GRUB_GFXMODE="640x480"/' /etc/default/grub
#sudo update-grub

# git configurations
git config --global user.email "chengdong.li@walmart.com"
git config --global user.name "Alex Li"
git config --system core.editor "vim"

# add bulgarian phonetic keyboard input
#gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'bg+phonetic')]"

# clicking on app in dock minimizes it
#gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# set terminal background color to match vim molokai colorscheme
#PROF_ID=$(dconf list /org/gnome/terminal/legacy/profiles:/ | sed -n 2p)
#dconf write /org/gnome/terminal/legacy/profiles:/${PROF_ID}background-color "'rgb(28, 28, 28)'"

# set default wallpaper
#mkdir -p $HOME/Pictures/Wallpapers
#cp ./default_wallpaper.jpg $HOME/Pictures/Wallpapers/
#gsettings set org.gnome.desktop.background picture-uri \
#    "file://$HOME/Pictures/Wallpapers/default_wallpaper.jpg"

# change ubuntu computer name
hostnamectl set-hostname 'winterfell'

# add dotfiles
git clone --recurse-submodules https://github.com/PreslavMihaylov/dotfiles
cd dotfiles && ./install.sh
rm -rf dotfiles
