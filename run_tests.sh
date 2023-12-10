#!/usr/bin/env bash

rm ./input*
rm ./output*

# BASE CASE
echo 'crypt0' > ./input.txt 
./app.rb encode ./input.txt ./output.txt 1
./app.rb decode ./output.txt ./input.txt 1

# CUSTOM SHIFTING EQUALS 33
echo 'crypt0' > ./input.txt 
./app.rb encode ./input.txt ./output.txt 33
./app.rb decode ./output.txt ./input.txt 33