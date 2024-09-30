#!/bin/bash

#   Script header:
echo "Installing the Portainer-Agent Docker container."
#   Install and run the portainer agent docker container:
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  -v /:/host \
  portainer/agent:lts
