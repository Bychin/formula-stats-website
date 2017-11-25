#! /bin/bash

image_name=formula_image
container_name=pg_formula
commands_for_sql=./db-setup-commands.sql
pycharm_script="/usr/local/bin/charm"
prop_file="/tmp/properties_formula.tmp"
termination="sudo docker stop $container_name"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m' # No color


# Launching docker container
if sudo docker start $container_name 1> /dev/null # -d Background launch
then
  echo -e "${GREEN}[1] Docker was launched...${NC}"
  port=$(sudo docker ps | grep $container_name | grep ":[0-9][0-9]*->" -o | grep "[0-9][0-9]*" -o) # Find port adress
  host=$(sudo docker ps | grep $container_name | grep "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*" -o) # Find host adress
  echo "$host\n$port" > $prop_file
  echo "$port"
else
  echo -e "${RED}ERROR: Cannot launch docker! Exiting!${NC}"
  $termination 1> /dev/null
  rm $prop_file 2> /dev/null
  exit 1
fi


# Launching PyCharm
if $pycharm_script
then
  echo -e "${GREEN}[2] PyCharm was started...${NC}"
else
  echo -e "${YELLOW}WARNING: Cannot start PyCharm!${NC}"
fi


echo "Enter 'stop' to stop container."
while [[ 1 -eq 1 ]]
do
  read decision
  if [[ $decision == "stop" ]]
  then
    echo -e "${GREEN}[8] Stopping docker container...${NC}"
    $termination 1> /dev/null
    rm $prop_file 2> /dev/null
    sleep 1
    echo "Goodbye!"
    exit
  fi
done

