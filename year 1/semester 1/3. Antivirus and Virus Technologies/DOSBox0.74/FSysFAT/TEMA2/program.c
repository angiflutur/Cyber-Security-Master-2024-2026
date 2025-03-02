#include <stdio.h>
#include <stdlib.h>

#define KEY 0x5A 
#define BUFFER_SIZE 512

void xor_encrypt_decrypt(unsigned char *buffer, unsigned int size, unsigned char key) {
    unsigned int i;  
    for (i = 0; i < size; i++) {
        buffer[i] ^= key;  
    }
}

int main() {
    FILE *inputFile;
    FILE *outputFile;
    unsigned char buffer[BUFFER_SIZE];
    unsigned int bytesRead;

    inputFile = fopen("input.txt", "rb");
    bytesRead = fread(buffer, 1, BUFFER_SIZE, inputFile);
    fclose(inputFile);

    xor_encrypt_decrypt(buffer, bytesRead, KEY);
    outputFile = fopen("input.txt", "wb");
    fwrite(buffer, 1, bytesRead, outputFile);
    fclose(outputFile);

    printf("Fisierul a fost criptat cu succes.\n");

    return 0;
}
