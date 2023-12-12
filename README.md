# Caeser Chipher Enhanced

## Caesar Text Chipher

Description from [Wiki](https://en.wikipedia.org/wiki/Caesar_cipher)

***
```
In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, 
Caesar's code,  or Caesar shift, is one of the simplest and most widely known encryption
techniques. It is a type  of substitution cipher in which each letter in the plaintext is
replaced by a letter some fixed  number of positions down the alphabet. For example, with 
a left shift of 3, D would be replaced  by A, E would become B, and so on. The method is 
named after Julius Caesar, who used it in his private correspondence.
```
***

## Requirements

* Ruby 3.2.2 or higher

## Usage

```
$ ./app.rb

./app.rb encode|decode ./input.txt ./output.txt 5

The last param is shifting number, e.g. 33 or 5
```


## Example

```
$ echo 'hi! this string will be chiphered' > input.txt  
$ ./app.rb encode ./input.txt ./output.txt 10

cnMrw6FEcnNDw6FDREJzeHHDoUdzdnbDoWxvw6FtcnN6cm9Cb27DrQ==

$ ./app.rb decode ./output.txt ./output2.txt 10 

hi! this string will be chiphered

```

## Tests

```
$ time ./run_tests.sh

[+] BASE TEST PASSED SUCCESSFULLY

[+] ALL TESTS PASSED

./run_tests.sh  0.14s user 0.05s system 94% cpu 0.211 total
```


