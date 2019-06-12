#!/bin/bash

# Update pkg lists
echo ''
echo "Updating package lists..."
sudo apt-get update

# zsh install
echo ''
echo 'Installing zsh...'
sudo apt install zsh -y

# Installing git completion
echo ''
echo "Now installing git and bash-completion..."
sudo apt-get install git bash-completion -y

# Install commonly used packages
echo ''
echo "Installing commonly used packages..."
sudo apt get install -y \
    gcc \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-commons \
    make \
    vim \
    wget \
    tmux

# Install go
echo ''
echo "Installing golang..."
wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz

# Install kubectl
echo ''
echo "Installing kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install thefuck
echo ''
echo "Installing thefuck..."
sudo apt install -y python3-dev python3-pip python3-setuptools
sudo pip3 install thefuck

echo ''
echo "Now configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# oh-my-zsh install
if [ -d ~/.oh-my-zsh/ ] ; then
echo ''
echo "oh-my-zsh is already installed..."
read -p "Would you like to update oh-my-zsh now?" -n 1 -r
echo ''
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
    cd ~/.oh-my-zsh && git pull
        if [[ $? -eq 0 ]]
        then
            echo "Update complete..." && cd
        else
            echo "Update not complete..." >&2 cd
        fi
    fi
else
echo "oh-my-zsh not found, now installing oh-my-zsh..."
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Copy dotfiles to home directory
cp .zshrc ~/.zshrc 

# Set default shell to zsh
echo ''
echo "Setting default shell to zsh"
echo ''
chsh -s $(which zsh)
if [[ $? -eq 0 ]]
then
    echo "Successfully set your default shell to zsh..."
else
    echo "Default shell not set successfully..." >&2
fi