#!/bin/bash

if [ -z "$DOMAIN" ]
then
  echo "the \$DOMAIN variable is not set."
  echo "add to the command: DOMAIN=www.some-domain.com ./rebuild"
  echo ""
  exit
fi

if [ -z "$PORT" ]
then
  echo "the \$PORT variable is not set."
  echo "add to the command: PORT=808 ./rebuild"
  echo "the specified server number will be added to the PORT like web=8081 and phpmyadmin=8082"
  echo ""
  exit
fi

# cd into the root of this project
cd ..

# make the html file accessable to the user
sudo chmod 777 html -R

# write webserver files
cp nginxProxySettings "/etc/nginx/sites-enabled/$DOMAIN"
sed -i "s/<<SERVER>>/$DOMAIN/g" "/etc/nginx/sites-enabled/$DOMAIN"
sed -i "s/<<PORT>>/$PORT/g" "/etc/nginx/sites-enabled/$DOMAIN"

# stop nginx
sudo systemctl stop nginx

# setup ssl certs
if [ ! -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
  certbot certonly --standalone -d "$DOMAIN"
fi

# start
sudo systemctl start nginx

# setup docker
sudo docker-compose build
sudo docker-compose up -d

# Show tips
echo "-----------"
echo "you might want to do: sudo rm -rf mariadb"
echo "That command reset all the databases!!"
echo ""

# cleanup
cd scripts