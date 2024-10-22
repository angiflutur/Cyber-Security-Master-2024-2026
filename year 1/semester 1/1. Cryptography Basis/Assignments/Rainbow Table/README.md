# Rainbow table

Using [Cryptool](https://www.cryptool.org/en/) generate a Rainbow table for all English dictionary words (the one available in [Cryptool](https://www.cryptool.org/en/)) using SHA2 function.

The hash values for all the words can be printed in a text output or in a text file. Your choice.

In the same workspace create also another flow which will require the PBKDF component with the next settings (SHA2, 600 iterations, 32 bytes output). Compute the rainbow table with a "ism" salt value for all dictionary entries.

Do a benchmark between the 2 solutions (with PBKDF and without)

Upload the workspace file with the [Cryptool](https://www.cryptool.org/en/) solution and write in the response the duration of each

There are no partial evaluations of the solution. We work in binary system.