#!/usr/bin/env bash

# CLEAN
rm ./input*
rm ./output*

# INIT DATA
echo 'crypt0' > ./input.txt 

# BASE CASE
./app.rb encode ./input.txt ./output.txt 1
./app.rb decode ./output.txt ./input.txt 1

# CUSTOM SHIFTING EQUALS 33
echo 'crypt0' > ./input.txt 
./app.rb encode ./input.txt ./output.txt 33
./app.rb decode ./output.txt ./input.txt 33

# CLEAN
rm ./input*
rm ./output*
