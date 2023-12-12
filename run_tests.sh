#!/usr/bin/env bash

clear

# CLEAN
rm -f  ./in*
rm -f ./out*

# # INIT DATA
echo 'crypt0' > ./input.txt 

# BASE CASE
./app.rb encode ./input.txt ./output.txt 1 > /dev/null
./app.rb decode ./output.txt ./output2.txt 1 > /dev/null

let DIFFERENCE=`diff input.txt output2.txt | wc -l | sed -e 's/^[[:space:]]*//'`

if [[ $DIFFERENCE == 0 ]]
then
  echo -e "[+] BASE TEST PASSED SUCCESSFULLY\n"
else
  echo "[-] BASE TEST FAILED!\n"
  exit
fi

# CUSTOM SHIFTING EQUALS 33
echo 'crypt0' > ./input.txt 
./app.rb encode ./input.txt ./output.txt 33 > /dev/null
./app.rb decode ./output.txt ./output2.txt 33 > /dev/null

DIFFERENCE=`diff input.txt output2.txt | wc -l | sed -e 's/^[[:space:]]*//'`

if [[ $DIFFERENCE == 0 ]]
then
  echo -e "[+] SECOND TEST WITH CUSTOM SHIFTING PASSED SUCCESSFULLY\n"
else
  echo "[-] SECOND TEST FAILED!"
  exit 
fi

# PERFORMANCE

# ENCODE AND DECODE 'WAR AND PEACE' by grad Leo Tolstoy
echo -e "ENCODING \"WAR AND PEACE\"... PLEASE WAIT!"
time ./app.rb encode ./war_and_peace.txt ./output.txt 33
echo -e "\nDECODING \"WAR AND PEACE\"... PLEASE WAIT!"
time ./app.rb decode ./output.txt ./input.txt 33

# ENCODE AND DECODE 'BRAVE NEW WORLD' by Oldos Haxley
echo -e "ENCODING \"BRAVE NEW WORLD\"... PLEASE WAIT!"
time ./app.rb encode ./brave_new_world_original.txt ./output.txt 33
echo -e "\nDECODING \"BRAVE NEW WORLD\"... PLEASE WAIT!"
time ./app.rb decode ./output.txt ./input.txt 33

echo -e "\n[+] ALL TESTS PASSED\n"

# CLEAN
rm -f  ./in*
rm -f ./out*

