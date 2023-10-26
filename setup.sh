#!/bin/bash
base_path=$(pwd)

for dir in $(ls -d */); do
  ln -s $base_path/$dir ~/.config/$dir
done
