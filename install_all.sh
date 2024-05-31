#!/bin/bash

# Update package lists
sudo apt update

# Install Apache2
sudo apt install -y apache2

# Install PHP and Apache PHP module
sudo apt install -y php libapache2-mod-php

# Update and upgrade system
sudo apt-get update && sudo apt-get upgrade -y

# Install ASP.NET Core runtime
sudo apt-get install -y aspnetcore-runtime-8.0

# Download and execute titanAUTO.sh script
wget -O titanAUTO.sh https://raw.githubusercontent.com/abyanzz/TITAN/main/titanAUTO.sh
sudo chmod 777 titanAUTO.sh
./titanAUTO.sh

# Pull and run Mysterium node
docker pull mysteriumnetwork/myst
docker run --log-opt max-size=10m --cap-add NET_ADMIN -d -p 2222:4449 --name myst -v myst-data:/var/lib/mysterium-node --restart unless-stopped mysteriumnetwork/myst:latest service --agreed-terms-and-conditions

# Setup and run Watchtower
sudo docker stop watchtower
sudo docker rm watchtower
sudo docker rmi containrrr/watchtower
sudo docker run -d --restart=always --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --include-stopped --include-restarting --revive-stopped --interval 60 myst

# Run Bitping container and login
docker run -it --mount type=volume,source="bitpingd-volume",target=/root/.bitpingd --entrypoint /app/bitpingd bitping/bitpingd:latest login --email "abyantrader@gmail.com" --password "BZRXJKrtZ2kAzv3"

# Download and execute Traffmonetizer script
curl -O https://raw.githubusercontent.com/tiennm99/traffmonetizer/master/run.sh
sudo bash run.sh kKo6rC6UDnE3thQMxCZ3lL6/XojlIRIcXyG15TjeVd0=

# Download and execute Repocket script
curl -L https://raw.githubusercontent.com/spiritLHLS/repocket-one-click-command-installation/main/repocket.sh -o repocket.sh
chmod +x repocket.sh
bash repocket.sh -m abyantrader@gmail.com -p ufFu4SWIUwWzS2MhpwdhAgsqihh1

# Download and execute Gaganode script
curl -L https://raw.githubusercontent.com/spiritLHLS/gaganode-one-click-command-installation/main/g.sh -o g.sh
chmod +x g.sh
bash g.sh -t ijrvaybcywceslpm4a7bce41414eb716

# Download, extract, and install Meson CDN
wget 'https://staticassets.meson.network/public/meson_cdn/v3.1.20/meson_cdn-linux-amd64.tar.gz'
tar -zxf meson_cdn-linux-amd64.tar.gz
rm -f meson_cdn-linux-amd64.tar.gz
cd ./meson_cdn-linux-amd64
sudo ./service install meson_cdn
sudo ./meson_cdn config set --token=pehduasxpxlqoqxlf1cca525cca64f7e --https_port=443 --cache.size=30
sudo ./service start meson_cdn
cd ..

# Download and execute EarnFM script
curl -L https://raw.githubusercontent.com/spiritLHLS/earnfm-one-click-command-installation/main/earnfm.sh -o earnfm.sh
chmod +x earnfm.sh
bash earnfm.sh -m 144f991d-cde4-40cc-a9f4-892725da3802

# Run 9Hits container
docker run -d --network=host --name=9hits 9hitste/app /nh.sh --token=d432bb33020eca699a9e40e08726ffab --system-session --allow-crypto=no
