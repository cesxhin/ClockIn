#!/bin/bash
echo "--------------------------"
echo "| Welcome to ClockIn     |"
echo "--------------------------"

#Ask privilege root
if [ "$EUID" -ne 0 ]
then
  echo "Eseguire come root"
  exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: docker-compose is not installed. Please install docker-compose."
    exit 1
fi

# start installation of the script
FILE_COMPOSE="docker-compose.yml"
SERVICE_POSTGRES=true
DEFAULT_FOLDER=true

for arg in "$@"
do
    if [ "$arg" == "-h" ]
    then
        echo "Short explane this script of installation: "
        echo "Create default folder for mount point and start docker compose"
        echo ""
        echo "Following commands: "
        echo "dev -> Launch docker compose unstable"
        echo ""
        echo "Manage:"
        echo "down -> stop all services"
        echo ""
        echo "Actions for start:"
        echo "no-default-folder -> No create default folder for volumes"
        echo "no-postgres -> Not start service postgres"
        exit 1
    fi

    if [ "$arg" == "dev" ]
    then
        FILE_COMPOSE="docker-compose-unstable.yml"
        continue
    fi

    if [ "$arg" == "down" ]
    then
        sudo docker compose -f $FILE_COMPOSE down --timeout 120
        exit 1
    fi

    if [ "$arg" == "no-default-folder" ]
    then
        DEFAULT_FOLDER=false
        continue
    fi

    if [ "$arg" == "no-postgres" ]
    then
        SERVICE_POSTGRES=false
        continue
    fi

    echo "Unknow command: $arg"
    echo "Use -h for get more information"
    exit 1
done

# check folder
if [ "$DEFAULT_FOLDER" = true ]
then
    if [ ! -d "/clockin/dataPostgres" ]
    then
        sudo mkdir -p /clockin/dataPostgres
        echo "Created folder: /clockin/dataPostgres"
        echo ""
    fi
fi

# start service
sudo docker compose -f $FILE_COMPOSE pull
sudo docker compose -f $FILE_COMPOSE down

COMMAND_COMPOSE="docker compose -f $FILE_COMPOSE up -d"

if [ "$SERVICE_POSTGRES" = false ]
then
    COMMAND_COMPOSE="$COMMAND_COMPOSE --scale postgres=0 "
fi

COMMAND_COMPOSE="$COMMAND_COMPOSE"
sudo $COMMAND_COMPOSE
sudo docker image prune