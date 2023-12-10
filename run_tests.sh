#!/usr/bin/env bash

rm ./input*.txt 
rm ./output*.txt

echo 'crypt0' > ./input1.txt 
./app.rb encode ./input1.txt ./output1.txt 1
./app.rb decode ./output1.txt ./input1.txt 1