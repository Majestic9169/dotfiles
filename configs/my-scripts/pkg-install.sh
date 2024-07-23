#!/usr/bin/env bash

sudo pacman --needed -S $(awk '{print $1}' ../my-lists/pacman-pkg-list.txt)
yay --needed -S $(awk '{print $1}' ../my-lists/yay-pkg-list.txt)
