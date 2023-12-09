# CCODE

## Caesar Text Encoding

Description from [Wiki](https://en.wikipedia.org/wiki/Caesar_cipher)

```
In cryptography, a Caesar cipher, also known as Caesar's cipher, the shift cipher, 
Caesar's code,  or Caesar shift, is one of the simplest and most widely known encryption
techniques. It is a type  of substitution cipher in which each letter in the plaintext is
replaced by a letter some fixed  number of positions down the alphabet. For example, with 
a left shift of 3, D would be replaced  by A, E would become B, and so on. The method is 
named after Julius Caesar, who used it in his private correspondence.
```

## Usage

```
 $ ./app.rb help

./app.rb encode|decpde ./input.txt ./output.txt 5

The last param is shifting number, e.g. 25
```


## Example

```
$ echo 'hi! this string will be chiphered' > input.txt  
$ ./app.rb encode ./input.txt ./output.txt 10           

rs+8DrsC8CDBsxq8Gsvv8lo8mrszroBon

$ ./app.rb encode ./input.txt ./output.txt 10

rs+8DrsC8CDBsxq8Gsvv8lo8mrszroBon

$ echo 'rs+8DrsC8CDBsxq8Gsvv8lo8mrszroBon' > ./input.txt 
$ ./app.rb decode ./input.txt ./output.txt 10           

hi! this string will be chiphered

```




