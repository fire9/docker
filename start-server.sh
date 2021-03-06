#!/usr/bin/env bash

## The script used to start flow.ci server from docker-compose ##
## 
## HOW TO START: ./start-server.sh {host domain or ip}
## EXAMPLE: ./start-server.sh 172.20.2.1 (if your host ip is 172.20.2.1, then pass ip address at first argument)
##
## DEFAULT ADMIN: can be defined from varaibles:
## - FLOWCI_DEFAULT_ADMIN_EMAIL: 	default admin email
## - FLOWCI_DEFAULT_ADMIN_PASSWORD: default admin password 		

export FLOWCI_SERVER_HOST=$1
export FLOWCI_RABBIT_HOST=$1
export FLOWCI_ZOOKEEPER_HOST=$1

export FLOWCI_SERVER_PORT=8080
export FLOWCI_SERVER_URL="http://$FLOWCI_SERVER_HOST:$FLOWCI_SERVER_PORT"

export FLOWCI_WEB_PORT=2015

export FLOWCI_DEFAULT_ADMIN_EMAIL=$2
export FLOWCI_DEFAULT_ADMIN_PASSWORD=$3

export FLOWCI_DEFAULT_MINIO_ACCESS_KEY=minio
export FLOWCI_DEFAULT_MINIO_SECRET_KEY=minio123

## To define where to store the data of ci server in host
export FLOWCI_SERVER_DIR=$HOME/.flow.ci
export FLOWCI_SERVER_DB_DIR=$FLOWCI_SERVER_DIR/db
export FLOWCI_SERVER_DATA_DIR=$FLOWCI_SERVER_DIR/data

mkdir -p $FLOWCI_SERVER_DIR
mkdir -p $FLOWCI_SERVER_DB_DIR
mkdir -p $FLOWCI_SERVER_DATA_DIR

if [[ ! -n $1 ]]; then
	echo "[ERROR]: The host domain name or ip must be defined"
	exit 1
fi

if [[ ! -n $FLOWCI_DEFAULT_ADMIN_EMAIL ]]; then
	export FLOWCI_DEFAULT_ADMIN_EMAIL=admin@flow.ci
fi
echo "Admin Email: $FLOWCI_DEFAULT_ADMIN_EMAIL"

if [[ ! -n $FLOWCI_DEFAULT_ADMIN_PASSWORD ]]; then
	export FLOWCI_DEFAULT_ADMIN_PASSWORD=123456
fi
echo "Admin Password: $FLOWCI_DEFAULT_ADMIN_PASSWORD"

echo "FLOWCI_SERVER_URL=$FLOWCI_SERVER_URL"
echo "FLOWCI_RABBIT_HOST=$FLOWCI_RABBIT_HOST"
echo "FLOWCI_ZOOKEEPER_HOST=$FLOWCI_ZOOKEEPER_HOST"

docker-compose -f server.yml up