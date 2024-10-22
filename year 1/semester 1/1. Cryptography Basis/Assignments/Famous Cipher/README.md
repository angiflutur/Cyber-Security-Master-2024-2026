# Famous Cipher
Choose a famous quote that you like. After writing it here please copy it locally in notepad so you will not forget it. **Don't use trailing spaces**.

Using [Cryptool](https://www.cryptool.org/en/) hash the previous quote using **MD5** and use the obtained value to encrypt the quote text file using **AES in CBC mode**.

The **IV** value is known and is **0x0000…0011** (the value is in hex). Name the encrypted file ***YourLastNameFirstName.enc*** and upload it.

To assure the file data integrity compute its **SHA1 HMAC** with password "*assignment1*" and write the value as a text in your submission.

Before you submit your solution do another [Cryptool](https://www.cryptool.org/en/) project and check if the decryption works. If does not work, then it will not work either for me and you don't get any points. 

### Upload

* the text file with the famous quote;
* the generated encrypted file ***LastNameFirstName.enc***;
* the [Cryptool](https://www.cryptool.org/en/) project with this flow (open the text file, hash it, use the message digest value as key for CBC encryption of the same input file (with the given IV);
* you can choose the padding and write the standard name as answer
and write the HMAC of ***LastNameFirstName.enc*** here.

**Time required to do the assignment, approx. 30 minutes - 1 hour.** 