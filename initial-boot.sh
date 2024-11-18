#!/bin/bash

xfce4-panel-profiles load $HOME/configs/xfce-panel.conf load
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s $HOME/Pictures/background.jpg

rm -- "$0"