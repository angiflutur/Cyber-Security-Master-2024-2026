#define _CRT_SECURE_NO_WARNINGS
#include "stdlib.h"
#include "stdio.h"
#include <iostream>

int main() {
	FILE* src1 = fopen("fields.bmp", "rb");
	FILE* src2 = fopen("horse.bmp", "rb");
	FILE* out = fopen("output.bmp", "wb");

	unsigned char header1[54];
	unsigned char header2[54];

	fread_s(header1, sizeof(header1), sizeof(unsigned char), 54, src1);
	fread_s(header2, sizeof(header2), sizeof(unsigned char), 54, src2);
	fwrite(header1, sizeof(unsigned char), 54, out);

	int width1 = *(int*)&header1[18];
	int height1 = *(int*)&header1[22];
	int width2 = *(int*)&header2[18];
	int height2 = *(int*)&header2[22];

	int dataLength = width1 * 3; // the array for each color RGB
	unsigned char* src1Data = new unsigned char[dataLength];
	unsigned char* src2Data = new unsigned char[dataLength];

	for (int y = 0; y < height1; y++) {
		fread_s(src1Data, sizeof(unsigned char)* dataLength, sizeof(unsigned char), dataLength, src1);
		fread_s(src2Data, sizeof(unsigned char)* dataLength, sizeof(unsigned char), dataLength, src2);

		unsigned char* bmpData = new unsigned char[dataLength];
		
		// bitwise operations
		for (int x = 0; x < width1 * 3; x++) {
			//// horse XOR cu alb 
			//unsigned char step1 = src2Data[x] ^ 0xFF;

			//// AND cu fields
			//unsigned char step2 = src1Data[x] & step1;

			//// OR cu horse
			//unsigned char step3 = src2Data[x] | step2;

			//bmpData[x] = step3;

			unsigned char B1 = src1Data[x];
			unsigned char G1 = src1Data[x+1];
			unsigned char R1 = src1Data[x+2];
			unsigned char B2 = src2Data[x];
			unsigned char G2 = src2Data[x+1];
			unsigned char R2 = src2Data[x+2];

			// 1 - field; 2 - horse
			// horse XOR cu alb 
			bmpData[x] = (B2 != 0 ? 255 : 0) ^ 255;
			bmpData[x+1] = (G2 != 0 ? 255 : 0) ^ 255;
			bmpData[x+2] = (R2 != 0 ? 255 : 0) ^ 255;
			
			// AND cu fields
			bmpData[x] = bmpData[x] & B1;
			bmpData[x + 1] = bmpData[x+1] & G1;
			bmpData[x + 2] = bmpData[x+2] & R1;

			// OR cu horse
			bmpData[x] = bmpData[x] | B2;
			bmpData[x + 1] = bmpData[x + 1] | G2;
			bmpData[x + 2] = bmpData[x + 2] | R2;
		}

		fwrite(bmpData, sizeof(unsigned char), dataLength, out);
 	}
	fclose(src1);
	fclose(src2);

}

