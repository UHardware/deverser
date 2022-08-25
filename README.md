# Déverser
Simple script to dump onboard SHSH with a valid Generator for iOS devices - now availble for Windows users!

## What is this/What does this do

Déverser is a simple Windows 10 script to dump onboard SHSH from iOS devices and convert it to useable SHSH which contains a generator! This is different to just dumping 'ApTicket.der' from the device's filesystem, like some jailbreaks such as Unc0ver allow for, as the 'ApTicket.der' doesn't contain the generator for the ApNonce it is valid for, meaning restores/downgrades using converted ApTicket.der's are not possible unless you know the generator.

This script simply dumps iBoot from /dev/rdisk1 on the device, copies the dump to your computer then converts the dump to valid SHSH using [img4tool](https://github.com/tihmstar/img4tool). This is all possible and easy to do manually, this script just allows for those who are less comfortable with the command line or less knowledgeable to have a simple method to dump onboard SHSH.

Even though this script will give you valid SHSH for the currently installed iOS version on your device, you are still limited by signed SEP compatiblity when restoring/downgrading with this dumped SHSH, so please bare that in mind when using this script.

Déverser is just a small project originally created by MatthewPierson!

## Requirements

A Windows 10 machine

A jailbroken device with OpenSSH installed (Specific jailbreak doesn't matter, E.G checkra1n, Unc0ver, chimera, etc)

## Usage

1. Run "(1) Install WSL"
2. Run "(2) Set your password", press any key and type "passwd root", then set your password and exit.
3. Run "(3) Run Deverser"
4. Follow what the script asks you to do (Mostly just entering your device's IP address and root password for SSH/SCP)

## Credits
Dariusz Szemerda (Me) - [@UHardware](https://twitter.com/UHardware_PL) - For porting to windows10

Matty - [@mosk_i](https://twitter.com/moski_dev) - For writing the script

Tihmstar - [@tihmstar](https://twitter.com/tihmstar) - For creating img4tool
