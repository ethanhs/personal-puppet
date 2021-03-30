#!/usr/bin/env bash
set -eux
sudo apt update
sudo apt upgrade
sudo apt install git scdaemon ruby ruby-dev ssh build-essential

if ! ssh-add -l; then
     ssh-keygen -t ed25519
fi

if [ ! -d personal-puppet ]; then
    git clone https://github.com/ethanhs/personal-puppet.git
fi

pushd personal-puppet

if [ ! -f pubkey.gpg ]; then
    wget https://ethanhs.me/pubkey.gpg
fi

gpg --import pubkey.gpg

gpg --card-status
echo "Please trust the newly imported GPG key"
gpg --edit-key 0x1E2D7B92636E8A77
read -p "Please remove and re-insert your yubikey then press enter"
gpg --card-status

./run-puppet.py
