#!/bin/bash
base_path=$(pwd)

for i in $(ls -d */); do
  dir=$(echo $i |cut -d "/" -f 1)
  target=~/.config/$dir
  ln -si $base_path/$dir ~/.config/$dir
done
echo "Setting up allowed signers file"
