#!/bin/bash

# Usage: auto_join_swarm.sh <consul_ip:port>
# Default: auto_join_swarm.sh 192.168.0.200:8500

export consul_addr=192.168.0.110:8500

if [ ! -z $1 ]; then
	export consul_addr=$1:8500
fi

echo "Using consul: $consul_addr"

export eth0_addr=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
export node_ip=$eth0_addr:2375

echo "Removing old container"

docker rm -f join

export image=hypriot/rpi-swarm:v1.2.4

echo "Starting new container"

docker run --name join -d $image join --advertise=$node_ip consul://$consul_addr/swarm
