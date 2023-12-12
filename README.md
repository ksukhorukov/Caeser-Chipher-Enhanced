# Caeser Chipher Enhanced

## Caesar Text Chipher Description

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
[+] BASE TEST PASSED SUCCESSFULLY

[+] SECOND TEST WITH CUSTOM SHIFTING PASSED SUCCESSFULLY

[~] ENCODING "WAR AND PEACE"... PLEASE WAIT!

real  0m6.559s
user  0m6.411s
sys 0m0.127s

[~] DECODING "WAR AND PEACE"... PLEASE WAIT!

real  0m36.353s
user  0m19.646s
sys 0m16.628s

[~] ENCODING "BRAVE NEW WORLD"... PLEASE WAIT!

real  0m0.128s
user  0m0.108s
sys 0m0.017s

[~] DECODING "BRAVE NEW WORLD"... PLEASE WAIT!

real  0m0.140s
user  0m0.120s
sys 0m0.017s

[+] ALL TESTS PASSED

./run_tests.sh  26.55s user 16.88s system 99% cpu 43.549 total
```


