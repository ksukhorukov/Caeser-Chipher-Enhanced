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
$ time ./run_tests.sh > /dev/null

real  0m0.096s
user  0m0.075s
sys 0m0.018s

real  0m0.079s
user  0m0.060s
sys 0m0.016s

real  0m0.078s
user  0m0.059s
sys 0m0.015s

real  0m0.078s
user  0m0.059s
sys 0m0.016s
./run_tests.sh > /dev/null  0.51s user 0.15s system 95% cpu 0.695 total
```


