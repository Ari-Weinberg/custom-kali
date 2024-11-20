#!/bin/bash

xfce4-panel-profiles load $HOME/configs/panel.tar.bz2
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s $HOME/Pictures/background.jpg
rm $HOME/.config/autostart/initial-boot.desktop
rm -- "$0"