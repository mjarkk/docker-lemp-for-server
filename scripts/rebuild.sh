#!/bin/bash

if [ -z "$DOMAIN" ]
then
  echo "the \$DOMAIN variable is not set."
  echo "use DOMAIN=www.some-domain.com ./rebuild"
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