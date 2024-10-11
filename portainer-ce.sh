#!/bin/bash

#   Script header:
echo "Installing the portainer-ce:lts Docker container."
#	Run the portainer server docker container:
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
