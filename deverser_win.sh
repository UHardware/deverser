#!/bin/bash

if test -f "dump.raw"; then
    rm -rf dump.raw
fi
echo ""
echo "[!] Welcome to Déverser, a simple script to dump onboard SHSH (Blobs) with a valid Generator for iOS devices..."
echo "[!] This script will allow you to use dumped blobs with futurerestore at a later date (depending on SEP compatibility)..."
echo -e "\e[31mWindows 10 Edition by UHardware\e[0m"
if test -f "/usr/local/bin/img4tool"; then
    echo "[!] Found img4tool at '/usr/local/bin/img4tool'!"
else
    echo "[#] img4tool is not installed, do you want Déverser to download and install img4tool? (If no then the script will close, img4tool is needed)"
    echo "[*] Please enter 'Yes' or 'No':"
    read consent
    if [ $consent == 'Yes' ] | [ $consent == 'yes' ]; then
        echo "[!] Installing IMG4TOOL..."
        

        echo "[*] Terminal may ask for permission to move the files into '/usr/local/bin' and '/usr/local/include', please enter your password if it does..."
        sudo cp ./img4tool/buildroot_ubuntu-latest/usr/local/bin/img4tool /usr/local/bin/img4tool
        sudo cp -R ./img4tool/buildroot_ubuntu-latest/usr/local/include/img4tool /usr/local/include
        sudo chmod +x /usr/local/bin/img4tool

        echo "[*] Installed img4tool"
    elif [ $consent == 'No' ] | [ $consent == 'no' ]; then
        echo "[#] img4tool is needed for this script to work..."
        echo "[#] You must type "Yes" "
        exit
    else
        echo "[#] Unknown input, assuming to be a variant of 'No'..."
        echo "[#] img4tool is needed for this script to work..."
        echo "[#] You must type "Yes" "
        exit
    fi  
fi
echo "[!] Please enter your device's IP address (Found in wifi settings)..."
read ip
echo "Device's IP address is ${ip}"
echo "[*] Assuming given IP to be correct, if connecting to the device fails ensure you entered the IP correctly and have OpenSSh installed..."
echo "[!] Please enter the device's root password (Default is 'alpine')..."
ssh root@${ip} "cat /dev/rdisk1 | dd of=dump.raw bs=256 count=$((0x4000))" &> /dev/null
echo "[!] Dumped onboard SHSH to device, about to copy to this machine..."
echo "[!] Please enter the device's root password again (Default is 'alpine')..."
scp root@${ip}:dump.raw dump.raw &> /dev/null
if test -f "dump.raw"; then
    echo ""
else
    echo "[#] Error: Failed to to copy 'dump.raw' from device to local machine..."
    exit
fi
echo "[!] Copied dump.raw to this machine, about to convert to SHSH..."
img4tool --convert -s dumped.shsh dump.raw &> /dev/null
if img4tool -s dumped.shsh | grep -q 'failed'; then
    echo "[#] Error: Failed to create SHSH from 'dump.raw'..."
    exit
fi
ecid=$(img4tool -s dumped.shsh | grep "ECID" | cut -c13-)
mv dumped.shsh ${ecid}.dumped.shsh # Allows multiple devices to be dumped as each dump/converted SHSH will have a filename that links the SHSH to the device
generator=$(cat ${ecid}.dumped.shsh | grep "<string>0x" | cut -c10-27)
echo "[!] SHSH should be dumped successfully at '${ecid}.dumped.shsh' (The number in the filename is your devices ECID)!"
echo "[!] Your Generator for the dumped SHSH is: ${generator}"
echo "[@] Written by Matty. Ported Tool by UHardware - Enjoy!"
echo ""