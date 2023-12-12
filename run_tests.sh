#!/usr/bin/env bash

GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)

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
  echo -e "${GREEN}[+] BASE TEST PASSED SUCCESSFULLY\n"
else
  echo "${RED}[-] BASE TEST FAILED!\n"
  exit
fi

# CUSTOM SHIFTING EQUALS 33
echo 'crypt0' > ./input.txt 
./app.rb encode ./input.txt ./output.txt 33 > /dev/null
./app.rb decode ./output.txt ./output2.txt 33 > /dev/null

DIFFERENCE=`diff input.txt output2.txt | wc -l | sed -e 's/^[[:space:]]*//'`

if [[ $DIFFERENCE == 0 ]]
then
  echo -e "${GREEN}[+] SECOND TEST WITH CUSTOM SHIFTING PASSED SUCCESSFULLY\n"
else
  echo "${RED}[-] SECOND TEST FAILED!"
  exit 
fi

# PERFORMANCE

# ENCODE AND DECODE 'WAR AND PEACE' by grad Leo Tolstoy
echo -e "${BLUE}[~] ENCODING \"WAR AND PEACE\"... PLEASE WAIT!"
time ./app.rb encode ./war_and_peace.txt ./output.txt 33 > /dev/null
echo -e "${BLUE}\n[~] DECODING \"WAR AND PEACE\"... PLEASE WAIT!"
time ./app.rb decode ./output.txt ./input.txt 33 > /dev/null

# ENCODE AND DECODE 'BRAVE NEW WORLD' by Oldos Haxley
echo -e "${BLUE}\n[~] ENCODING \"BRAVE NEW WORLD\"... PLEASE WAIT!"
time ./app.rb encode ./brave_new_world_original.txt ./output.txt 33 > /dev/null
echo -e "${BLUE}\n[~] DECODING \"BRAVE NEW WORLD\"... PLEASE WAIT!"
time ./app.rb decode ./output.txt ./input.txt 33 > /dev/null

echo -e "${GREEN}\n[+] ALL TESTS PASSED SUCCESSFULLY\n"

# CLEAN
rm -f  ./in*
rm -f ./out*

