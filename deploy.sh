#!/bin/bash

DOMAIN="foo.bar"

# make sure external network is available
docker network ls | grep public-gateway &> /dev/null
if [ $? -ne 0 ]; then
  docker network create --driver=overlay public-gateway
fi

# deploy/update the stack
docker stack deploy -c docker-compose-gateway.yml gateway
