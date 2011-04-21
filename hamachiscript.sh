#!/bin/bash

# Legg til IP-tunnelering i kjerna
sudo modprobe tun
sudo echo -e "\ntun" >> /etc/modules

# Sjekk om det var vellykka. Viss ikkje, fiks manuelt
if [ ! -e /dev/net/tun ] ; then
	sudo mkdir /dev/net
	sudo mknod /dev/net/tun c 10 200
fi

# Last ned og pakk ut hamachi
cd /home/$USERNAME
wget http://files.hamachi.cc/linux/hamachi-0.9.9.9-20-lnx.tar.gz
tar -zxvf hamachi-0.9.9.9-20-lnx.tar.gz
sudo mv hamachi-0.9.9.9-20-lnx/ .hamachi-0.9.9.9-20-lnx
sudo rm hamachi-0.9.9.9-20-lnx.tar.gz
cd .hamachi-0.9.9.9-20-lnx/

# Installer hamachi
sudo make install
sudo tuncfg

# Lasta ned og installert. 'For security sake, we are going to set the permissions of Hamachi so that it can only be started by members of the ‘hamachi’ group. '
sudo groupadd hamachi
sudo gpasswd -a $USERNAME hamachi
sudo gpasswd -a root hamachi
sudo chmod 760 /var/run/tuncfg.sock
sudo chgroup hamachi /var/run/tuncfg.sock

# Bugfiks
sudo apt-get install upx-ucl
cd /usr/bin
sudo upx -d hamachi
 
# Sett opp hamachi
sudo hamachi-init -c /etc/hamachi
sudo hamachi -c /etc/hamachi start
sudo hamachi -c /etc/hamachi set-nick $1
sudo hamachi -c /etc/hamachi login
sudo hamachi -c /etc/hamachi join $2
sudo hamachi -c /etc/hamachi go-online $2

echo -e "\nalias hamchi=\"sudo hamachi -c /etc/hamachi\"" >> /home/$USERNAME/.bash_aliases

sudo wget http://www.fostad.net/hamachiscr.sh
sudo mv hamachiscr.sh /etc/init.d/hamachi
sudo chmod +x /etc/init.d/hamachi
sudo update-rc.d hamachi defaults
