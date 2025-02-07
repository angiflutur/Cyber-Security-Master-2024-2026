# Let's encrypt

Using [Cryptool](https://www.cryptool.org/en/) implement different scenarios that will process a given .txt file. The text file contains the next message: "This is a secret message from _____________", in which you replace ______ with your name.

In the same [Cryptool](https://www.cryptool.org/en/) workspace (you can zoom out to put all components in the same window) implement a flow for each of the following scenarios and get the output as a hexadecimal string and save it as your assignment results:
```
1. generate and display the hash value (you can choose between MD5, SHA-1 or SHA-256)
2. choose a classic cipher (Playfair, Vigenere, XOR) and a password and encrypt the file
3. choose a setting and encrypt the text using Enigma
4. choose a password and encrypt the text using AES in ECB mode
5. choose a password and encrypt the text using AES in CBC mode
6. choose a password and encrypt the text using 3DES in CBC mode
7. choose a HMAC and generate the corresponding value
8. choose any PRNG available in Cryptool and implement a scenario in which the text is encrypted using an OTP approach.
```
For all required scenarios, you need to give details, in your assignment response (text file), regarding

 - Input text
 - Used Passwords
 - Used algorithms and their settings
 - Output

The details should sufficient for anyone else to reproduce the scenario and the results. For the last requirement upload the [Cryptool](https://www.cryptool.org/en/) project file. Failing to provide the necessary details, your assignment will not be graded. 

Each requirement has 1 point, with the exception of the last one that has 3 points. A total of 10 points can be obtained if all the requirements are implemented.

We need to upload 2 files

- the .txt file 
- the CrypTool workspace file

Failing to upload either of the 2 files will make the evaluation impossible. You get 0 points.
Not given the requested details for any of the scenarios, will make the evaluation of that scenario impossible.