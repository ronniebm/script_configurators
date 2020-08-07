#usr/bin/env sh

# This script helps with DOCKER Installation.
# -------------------------------------------
# TESTED in Ubuntu 18.04 LTS - Bionic Beaver.
# -------------------------------------------
# Creator: Ronnie BM.
# Github:  ronniebm
# Email:   ronnie.coding@gmail.com
# Date:    Aug-07-2020.
# -------------------------------------------

# 1. Updating packages list.
sudo apt -y update

# 2. Installing packages that let apt use of
#    packages trough HTTP.
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 3. Installing Docker's GPG KEY to our system.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 4. Adding Docker repository to APT sources.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# 5. Updating package list after Docker APT sources.
sudo apt -y update

# 6. Checking Docker is ready to be installed
#    on Ubuntu 18.04.
apt-cache policy docker-ce

# 7. Installing Docker.
sudo apt install docker-ce

# 8. Check if Docker is running OK.
sudo systemctl status docker

# STEPS AFTER DOCKER INSTALL ! SUDO PERMISSIONS.
#
#1.  sudo groupadd docker  // if it's already created, it will show you and no problem.
#2.  sudo usermod -aG docker $USER
#3.  RESTART YOUR SHELL TERMINAL (TTY)
#4.  newgrp docker
#5.  docker run hello-world   // it will show you welcome message without using SUDO.

