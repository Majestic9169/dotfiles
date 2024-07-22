#!/usr/bin/env bash

sudo pacman --needed --debug -S $(awk '{print $1}' pacman-pkg-list.txt)
