#include "bmp.h"
#include <math.h>

/*
Function: LoadImage.
Usage: load main content of input BMP image to a specific image pointer.
*/

Image* LoadImage(const char* path)  
{  
    Image* bmpImg;  
    FILE* fpbmp;  //the bmp file pointer.
    unsigned short fileType;  
    BiFileHeader bmpfileheader;  
    BiInfoHeader bmpinfoheader;  
    int channels = 1;  
    int width = 0;  
    int height = 0;  
    int step = 0;  //step means times needed to read and write image data.
    int offset = 0;  //help complete the 4-byte.
    unsigned char pixVal;  //pixel value,using unsigned char to represent 8-bit.
    RGBQuad* quad;  //the palette.
    int i, j, k;  
  
    bmpImg = (Image*)malloc(sizeof(Image));  
    fpbmp = fopen(path, "rb");  
    if (!fpbmp)  
    {  
        free(bmpImg);  
        return NULL;  
    }  //if the read failed,return.
  
    fread(&fileType, sizeof(unsigned short), 1, fpbmp);  //check whether the bfType is "BM".
    if (fileType == 0x4D42)  
    {  
        fread(&bmpfileheader, sizeof(BiFileHeader), 1, fpbmp);  
        fread(&bmpinfoheader, sizeof(BiInfoHeader), 1, fpbmp);  
   
        if (bmpinfoheader.biBitCount == 24)  //this is a real color image.
        {   
            channels = 3;  
            width = bmpinfoheader.biWidth;  
            height = bmpinfoheader.biHeight;  
  
            bmpImg->width = width;  
            bmpImg->height = height;  
            bmpImg->channels = 3;  //load contents.
            //bmpImg->imageData = (unsigned char*)malloc(sizeof(unsigned char)*width*3*height);  
            bmpImg->imageData = (unsigned char**)malloc(sizeof(unsigned char*)*height);
            for(i=0;i<height;i++) bmpImg->imageData[i] = (unsigned char*)malloc(sizeof(unsigned char)*width*3);
            //step = channels*width;  
  
            offset = (channels*width)%4;  
            if (offset != 0)  
            {  
                offset = 4 - offset;  
            }  //if the step is not the multiple of 4,complete it.
  
            for (i=0; i<height; i++)  
            {  
                for (j=0; j<width; j++)  
                {  
                    for (k=0; k<3; k++)  
                    {  
                        fread(&pixVal, sizeof(unsigned char), 1, fpbmp);  
                        bmpImg->imageData[height-1-i][j*3+k] = pixVal;  //read the image data to the array imageData[][].
                    }  
                }  
                if (offset != 0)  
                {  
                    for (j=0; j<offset; j++)  
                    {  
                        fread(&pixVal, sizeof(unsigned char), 1, fpbmp);  
                    }  
                }  
            }  
        }  
    }  
    //bmpImg->YUVflag = 0;  //set the change value to 0.
    return bmpImg;  
}  

void BMP2COE (Image* bmpImg, const char* path)
{
	FILE* coefile;
	coefile = fopen(path, "w");
	int i, j, r, g, b;
	
	fprintf(coefile, "memory_initialization_radix=2;\n");
    fprintf(coefile, "memory_initialization_vector=\n");
    
    for(i=bmpImg->height-1; i>-1; i--)
    {
    	for(j=0; j<bmpImg->width; j++)
    	{
    		b = bmpImg->imageData[i][j*3] / 16;
    		int* bs = change(b);
    		fprintf(coefile, "%d%d%d%d", bs[3], bs[2], bs[1], bs[0]);
    		g = bmpImg->imageData[i][j*3+1] / 16;
    		int* gs = change(g);
    		fprintf(coefile, "%d%d%d%d", gs[3], gs[2], gs[1], gs[0]);
    		r = bmpImg->imageData[i][j*3+2] / 16;
    		int* rs = change(r);
    		fprintf(coefile, "%d%d%d%d", rs[3], rs[2], rs[1], rs[0]);
    		fprintf(coefile, ",\n");
    	}
    }
    
    fclose(coefile);
    return ;
}
 
int* change (int x)
{
	int a [4] = {0};
	int i = 3;
	while(x != 0)
	{
		a[i--] = x%2;
		x/=2; 
	}
	int* res = a;
	return res;
} 

const char* fileName1 = "input.bmp";
const char* fileName2 = "output.coe";

int main()  
{  
	Image* img = LoadImage(fileName1);  
    BMP2COE(img, fileName2);
	return 0;  
} 
