#!/usr/bin/env bash

clear

# CLEAN
rm -f  ./input*
rm -f ./output*

# # INIT DATA
echo 'crypt0' > ./input.txt 

# BASE CASE
./app.rb encode ./input.txt ./output.txt 1
./app.rb decode ./output.txt ./input.txt 1

# CUSTOM SHIFTING EQUALS 33
echo 'crypt0' > ./input.txt 
./app.rb encode ./input.txt ./output.txt 33
./app.rb decode ./output.txt ./input.txt 33

# PERFORMANCE

# ENCODE AND DECODE 'WAR AND PEACE' by grad Leo Tolstoy
echo -e "ENCODING... PLEASE WAIT!"
time ./app.rb encode ./war_and_peace.txt ./output.txt 33
echo -e "\nDECODING... PLEASE WAIT!"
time ./app.rb decode ./output.txt ./input.txt 33

# ENCODE AND DECODE 'BRAVE NEW WORLD' by Oldos Haxley
echo -e "ENCODING... PLEASE WAIT!"
time ./app.rb encode ./brave_new_world_original.txt ./output.txt 33
echo -e "\nDECODING... PLEASE WAIT!"
time ./app.rb decode ./output.txt ./input.txt 33


# CLEAN
rm ./input*
rm ./output*

echo -e "[+] ALL TESTS PASSED\n"
