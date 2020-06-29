#!/bin/bash

# Mads's install script.
# Much of this is stolen (with permission) from Gunnar Inge Sortland and Hallgeir Lien modified by me (Mads).

# Major changes from their versions:
# - I install (some) different programs (d'oh)
# - The Hamachi script
# - Added mounting of the NTNU data areas
# - NTNU VPN setup
# - Saving repositories to *.sources.list (instead of *.list) - now it works ;)
# - Changed from echo to echo -e in order to activate the newline commands (\n)
# - Some different aliases
# - Widely use of apt-get -y

# Possible todo:
# - Set up Dropbox
# - Set up Unison

# Enjoy.
#$username_linux = 'mads'
#$password_ntnu = ''
$username_ntnu = "madsop"
#$hamachi_id = 'Havsteinbakken 3'

# Usage:
# make_header "your header"
function make_header {
  local RESULT=###\\n##\ ${1}\ ##\\n###
  for i in $(seq 1 $((${#1} + 3)))
  do
    RESULT=#${RESULT}#
  done
  
echo -e \\n$RESULT\\n
}


# PS: Only works with bash, not dash. So "./install-common" (or "bash install-common"), not "sh install-common".


##################
## Repositories ##
##################

# Canonical backports and partner
echo -e "\ndeb http://no.archive.ubuntu.com/ubuntu $(lsb_release -cs)-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo -e "\ndeb http://archive.canonical.com/ubuntu $(lsb_release -cs) partner" >> /etc/apt/sources.list

# Dropbox
make_header "Installing Dropbox repository..."
gpg --no-permission-warning --keyserver pgp.mit.edu --recv-keys 5044912E
echo -e "# Dropbox\ndeb http://linux.dropbox.com/ubuntu  $(lsb_release -cs) main \ndeb-src http://linux.dropbox.com/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/dropbox.sources.list

# Google
make_header "Installing Google repository..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
echo -e "# Google software repository \ndeb http://dl.google.com/linux/deb/ stable non-free main" > /etc/apt/sources.list.d/google.sources.list

# Medibuntu
make_header "Installing Medibuntu repository..."
wget http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list --output-document=/etc/apt/sources.list.d/medibuntu.sources.list
apt-get --yes -q --allow-unauthenticated install medibuntu-keyring

# Spotify (Linux-versjonen)
make_header "Installing Spotify repository..."
gpg --keyserver wwwkeys.de.pgp.net --recv-keys 4E9CFF4E
gpg --export 4E9CFF4E | apt-key add - 
echo -e "# Spotify software repository \ndeb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.sources.list
# Opera
#make_header "Installing Opera repository..."
#gpg --keyserver subkeys.pgp.net --recv-key 6A423791
#gpg --fingerprint 6A423791
#gpg --armor --export  6A423791| apt-key add -
#echo -e "# Opera\ndeb http://deb.opera.com/opera stable non-free \n#deb-src http://deb.opera.com/opera stable non-free" > /etc/apt/sources.list.d/opera.sources.list

#############
## Aliases ##
#############

make_header "Making aliases..."

echo -e alias apti=\"sudo apt-get install\" >> ~/.bash_aliases
echo -e alias update=\"sudo apt-get update \&\& sudo apt-get upgrade -y\" >> ~/.bash_aliases
echo -e alias aptc=\"apt-cache search\" >> ~/.bash_aliases
echo -e alias apts=\"sudo aptitude search\" >> ~/.bash_aliases
echo -e alias mount_iso=\"sudo o mount -o loop -t iso9660\" >> ~/.bash_aliases
echo -e alias apt-clean=\"sudo apt-get autoremove \&\& sudo apt-get clean\" >> ~/.bash_aliases

bash ~/.bash_aliases

chmod 644 ~/.bash_aliases
chown ${SUDO_USER}:${SUDO_USER} ~/.bash_aliases

############
## Update ##
############

make_header "Updating software..."

apt-get update
#apt-get upgrade

################
## NTNU-mount ##
################

#make_header "Mounting NTNU areas..."

#apt-get install -y --force-yes smbfs
#echo -e "workgroup=win-ntnu-no \nusername=$username_ntnu" > /root/.ntnupwd # Change my username with your own
#echo -e "password=$password_ntnu" >> /root/.ntnupwd # Insert your password on this line
#chmod 600 /root/.ntnupwd

#mkdir /mnt/progdist
#mkdir /mnt/folk
#mkdir /mnt/stud

#echo -e "
#Koble opp progdist
#//progdist.ntnu.no/progdist /mnt/progdist smbfs ro,credentials=/root/.ntnupwd 0 0
#koble opp stud-hjemmeomr
#//sambaad.stud.ntnu.no/$username_ntnu /mnt/stud smbfs rw,credentials=/root/.ntnupwd,uid=$username_linux 0 0
#koble opp hjemmesideomr
#//webedit.ntnu.no/folk /mnt/folk smbfs rw,credentials=/root/.ntnupwd,uid=$username_linux 0 0" >> /etc/fstab 

#mount -a

##############
## NTNU-VPN ##
##############

make_header "Installs NTNU VPN. To activate, use sudo vpnc-connect"

apt-get install -y --force-yes vpnc
echo -e "Interface name vpn0
IKE DH Group dh2
Perfect Forward Secrecy nopfs
IPSec gateway vpn.ntnu.no
IPSec ID alle
IPSec secret passord
Xauth username $username_ntnu" > /etc/vpnc/vpnc.conf
vpnc-connect /etc/vpnc/vpnc.conf
# Replace username with your NTNU username

######################
## Install programs ##
######################

make_header "Installing software..."

#apt-get install -y --force-yes build-essential calibre codeblocks dosbox filezilla flac gnome-do gobby google-chrome-beta gparted gtkvncviewer guake nautilus-dropbox opera pidgin pyrenamer pydsm skype speedcrunch sun-java6-jdk sun-java6-jre sun-java6-plugin ubuntu-restricted-extras unison-gtk unrar vlc vorbis-tools wine zsnes

apt-get install -y --force-yes build-essential			# Important development files (For compiling C/C++ programs)
apt-get install -y --force-yes calibre				# Program for managing e-books
apt-get install -y --force-yes codeblocks  	    		# C/C++ IDE
#apt-get install -y --force-yes damnvid				# Download and convert videos (YouTube, Google Video...)
apt-get install -y --force-yes dosbox				# DOS emulator
apt-get install -y --force-yes filezilla			# FTP client
apt-get install -y --force-yes flac				# For decoding/encoding FLAC audio files
apt-get install -y --force-yes gnome-do				# Launcher
apt-get install -y --force-yes gobby				# Collaborative text editor
apt-get install -y --force-yes google-chrome-unstable		# The Google Chrome browser
apt-get install -y --force-yes gparted				# Partition editor
apt-get install -y --force-yes gtkvncviewer			# Graphical remote controlling over VNC
apt-get install -y --force-yes guake				# Dropdown terminal
apt-get install -y --human-theme
apt-get install -y --force-yes mercurial			# Mercurial HG
apt-get install -y --force-yes nautilus-dropbox			# File sharing and more
#apt-get install -y --force-yes octave				# Matlab
#apt-get install -y --force-yes opera				# The Opera web browser
apt-get install -y --force-yes pidgin				# Instant messaging
apt-get install -y --force-yes pyrenamer			# For mass-renaming files
apt-get install -y --force-yes pysdm				# Storage Device Manager (GUI for editing fstab, basically)
apt-get install -y --force-yes python				# Python
apt-get install -y --force-yes skype				# Phone
apt-get install -y --force-yes speedcrunch			# Calculator
apt-get install -y --force-yes spotify-client-qt		# Spotify
apt-get install -y --force-yes spotify-client-gnome-support	# Needed for Spotify
apt-get install -y --force-yes sun-java6-jdk			# Java Developer's Kit
apt-get install -y --force-yes sun-java6-jre			# Java Runtime Environment
apt-get install -y --force-yes sun-java6-plugin			# Java Plugin for browsers
apt-get install -y --force-yes texmaker				# For LaTeX
apt-get install -y --force-yes ubuntu-restricted-extras		# Useful proprietary stuff not included in release due to licence
#apt-get install -y --force-yes unison-gtk			# Synchronization program
apt-get install -y --force-yes unrar				# For unpacking/packing RAR files
apt-get install -y --force-yes vim				# vim text editor
apt-get install -y --force-yes vlc				# Video player
apt-get install -y --force-yes vorbis-tools			# For decoding/encoding OGG vorbis audio files
apt-get install -y --force-yes wine				# Wine Is Not an Emulator
#apt-get install -y --force-yes zsnes				# SNES emulator

#wget -c http://www.spotify.com/download/Spotify%20Installer.exe -O /tmp/Spotify.exe && wine /tmp/Spotify.exe # Spotify, music streaming

#############
## Hamachi ##
#############

# Hamachi is a straight-forward easy-to-use just-working VPN service

make_header "Installing Hamachi"

# hamachi install script
# Hamachi is a straight-forward easy-to-use just-working VPN service

wget http://files.hamachi.cc/linux/hamachi-0.9.9.9-20-lnx.tar.gz
tar -xvf hamachi-0.9.9.9-20-lnx.tar.gz
mkdir .hamachi-0.9.9.9-20-lnx
mv hamachi-0.9.9.9-20-lnx/* .hamachi-0.9.9.9-20-lnx
rmdir hamachi-0.9.9.9-20-lnx
cd .hamachi-0.9.9.9-20-lnx
cd tuncfg
make install
/sbin/tuncfg
cd ..
make install
cd ../.hamachi
hamachi-init
rm hamachi-0.9.9.9.20-lnx.tar.gz
#hamachi start
#hamachi login
#hamachi join $hamachi_id

#############
## Cleanup ##
#############

make_header "Cleaning up..."

apt-get autoremove
apt-get clean

make_header "Upgrading"
apt-get update
apt-get upgrade -y --force-yes

################################
## Hasta la victoria siempre! ##
################################
