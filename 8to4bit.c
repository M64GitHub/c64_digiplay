#include <stdio.h>

FILE *ifile;
FILE *ofile;

void main(int argc, char **argv)
{
 	unsigned char c;
	/* ifile = fopen("in.raw", "rb"); */
	ifile = fopen(STDIN, "rb");
	ofile = fopen("out.raw", "wb");

	if(!ifile) { printf("error open read\n"); exit(1); }
	if(!ofile) { printf("error open write\n"); exit(1); }

	while(fread(&c, 1, 1, ifile))
	{
		printf("%02X ", c);
		c = c / 16;
		fprintf(ofile, "%c", c);
	}
	printf("\n");
	
	fclose(ifile);
	fclose(ofile);
}
