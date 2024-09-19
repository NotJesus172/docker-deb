#!/bin/bash

# Update and install nala:
sudo apt-get update
sudo apt-get install -y nala
# Update and upgrade the system:
sudo nala update
sudo nala upgrade -y
#	Install docker engine:
sudo nala install -y curl ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#	Install docker packages
sudo nala update
sudo nala install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Make all nested scripts executable
sudo chmod +x docker-compose.sh
sudo chmod +x portainer-server.sh
sudo chmod +x portainer-agent.sh
# Docker-compose install prompt:
echo "Would you like to install docker-compose? (y/n)"
read composeInstall
if [ $composeInstall == "y" ]; then
  echo "Very well, installing docker-compose."
  sudo ./docker-compose.sh
elif []; then
  echo "Very well, installing docker-compose."
  sudo ./docker-compose.sh
else
  echo "Very well, docker-compose will NOT be installed now."
  echo "If you would like to install it in the future just return to this directory, and run './docker-compose.sh' to begin the installation."
  sleep 3
fi
# Portainer server install prompt:
echo "Would you like to install the Portainer-Server Docker container? (y/n)"
read serverInstall
if [ $serverInstall == "y" ]; then
    echo "Very well, installing the Portainer-Server Docker container."
    sudo ./portainer-server.sh
elif [ $serverInstall == "Y" ]; then
    echo "Very well, installing the Portainer-Server Docker container."
else
    # Portainer agent install prompt:
    echo "Would you like to install the Portainer-Agent Docker container? (y/n)"
    read agentInstall
    if [ $agentInstall == "y" ]; then
      echo "Very well, installing the Portainer-Agent Docker container."
      sudo ./portainer-agent.sh
    elif [ $agentInstall == "Y" ]; then
      echo "Very well, installing the Portainer-Agent Docker container."
      sudo ./portainer-agent.sh
    fi
    exit 1
fi
# Install portainer server docker container:
sudo ./portainer-server.sh