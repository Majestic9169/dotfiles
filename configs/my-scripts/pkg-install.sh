#!/usr/bin/env bash

sudo pacman --needed -S $(awk '{print $1}' pacman-pkg-list.txt)
yay --needed -S $(awk '{print $1}' yay-pkg-list.txt)
