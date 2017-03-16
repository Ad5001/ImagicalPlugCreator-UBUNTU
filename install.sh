#!/bin/sh
echo "Installing dependencies..."
sudo apt install libubuntu-download-manager-common-dev
sudo apt install qtdeclarative5-ubuntu-download-manager0.1
echo "Installing app..."
sudo cp ImagicalPlugCreator.desktop /usr/share/applications
sudo mkdir /usr/share/ImagicalPlugCreator
sudo cp -r * /usr/share/ImagicalPlugCreator
echo "Done !"