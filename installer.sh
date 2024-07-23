#!/bin/bash

version=0.1.0
#Colors
white="\033[1;37m"
red='\e[1;31m'
blue='\e[1;34m'
yellow='\e[1;33m'
transparent="\e[0m"

#DUMP_PATH
rm -rf /tmp/Installer/
mkdir /tmp/Installer/
DUMP_PATH="/tmp/Installer/"

function conditional_clear() {

	if [[ "$INSTALLER_output_device" != "/dev/stdout" ]]; then clear; fi
}


#Check root
if [[ $EUID -ne 0 ]]; then
        echo -e "\e[1;31mYou don't have admin privilegies, execute the script as root."$transparent
				exit
fi

clear

#Check for X display

if [ -z "${DISPLAY:-}" ]; then
    echo -e "\e[1;31mThe script should be executed inside a X (graphical) session."$transparent""
    exit 1
fi


function top
{
	clear
	echo -e "$white#########################################################"
	echo -e "$white#                                                       #"
  	echo -e "$white#  $red      WIREFIRE ${yellow} $version   ${yellow}This is  the  installer      $white#"
  	echo -e "$white#                  ${yellow}        for     this  tool        ${white}   #"
	echo -e "$white#                                                       #"
	echo -e "$white#########################################################""$transparent"
	echo
	echo
	sleep 1
}

#Install Main
conditional_clear
top

echo "Updating system..."

#cleaning up
sudo apt-get install -f -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo apt-get update
sudo apt-get install screen -y
clear
top
screen apt-get install software-properties-common --yes
screen python remove.py
screen python add.py
screen python remove.py
echo -ne "Upgrading......."
echo -e "\e[1;32mOK!"$transparent
echo
echo

##############################

echo -ne "Aircrack-ng....."
	if ! hash aircrack-ng 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent
	 screen apt-get --yes install aircrack-ng
	else
    echo -e "\e[1;32mOK!"$transparent
	fi
	sleep 0.025

##############################

echo -ne "Aireplay-ng....."
	if ! hash awk 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent""
		screen apt-get --yes install gawk
	else
		echo -e "\e[1;32mOK!"$transparent
	fi
	sleep 0.025
##############################

echo -ne "Airodump-ng....."
if ! hash airodump-ng 2>/dev/null; then
	echo -e "\e[1;31mInstalling ..."$transparent""
	screen apt-get --yes install aircrack-ng
else
	echo -e "\e[1;32mOK!"$transparent""
fi
##############################
echo -ne "Bind9..........."
if ! hash bind9-config 2>/dev/null; then
	echo -e "\e[1;31mInstalling ..."$transparent""
	screen apt-get --yes install bind9
else
	echo -e "\e[1;32mOK!"$transparent""
fi
##############################

echo -ne "Dhcpd..........."
	if ! hash dhcpd 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent""
		screen apt-get --yes install isc-dhcp-server
	else
		echo -e "\e[1;32mOK!"$transparent
  	fi
	sleep 0.025
##############################

echo -ne "Hostapd........."
	if ! hash hostapd 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent""
		screen apt-get --yes install hostapd
	else
		echo -e "\e[1;32mOK!"$transparent
  	fi
	sleep 0.025
##############################

echo -ne "Iwconfig........"
if ! hash iwconfig 2>/dev/null; then
			echo -e "\e[1;31mInstalling ..."$transparent""
			screen apt-get --yes install iwconfig
else
	echo -e "\e[1;32mOK!"$transparent""
fi
sleep 0.025
##############################

echo -ne "Python.........."
	if ! hash python 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent""
			screen apt-get --yes install python
	else
		echo -e "\e[1;32mOK!"$transparent
  fi
	sleep 0.025

##############################

	echo -ne "rfkill.........."
        if ! hash rfkill 2>/dev/null; then
              echo -e "\e[1;31mInstalling ..."$transparent""
              screen apt-get --yes install rfkill
        else
                echo -e "\e[1;32mOK!"$transparent""
        fi
        sleep 0.025

##############################

echo -ne "strings........."
if ! hash strings 2>/tmp/null; then
        echo -e "\e[1;31mInstalling ..."$transparent""
        screen apt-get --yes install binutils
else
        echo -e "\e[1;32mOK!"$transparent""
fi
sleep 0.025

rm -rf $DUMP_PATH
