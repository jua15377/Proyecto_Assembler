/* Proyecto 
* Programa principal 
* Por: Rodrigo Barrios, Carnet: 15009
*    Juan Garcia, Carnet: 15046
*      Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30*/


#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<fcntl.h>
#include<linux/fb.h>
#include<sys/mman.h>

int fbfd = 0;
struct fb_var_screeninfo vinfo;
struct fb_fix_screeninfo finfo;
long int screensize = 0;
int   xRes = 0;
int   yRes = 0; 
char  *fbp = 0;

//-----------------------------------------------
// Get screen buffer memory address
//-----------------------------------------------
int getScreenAddr(){

  int addr;

  // Open the file for reading and writing
  fbfd = open("/dev/fb0", O_RDWR);
  if (!fbfd) {
    printf("Error: cannot open framebuffer device.\n");
    return(1);
  }

  // Get fixed screen information
  if (ioctl(fbfd, FBIOGET_FSCREENINFO, &finfo)) {
    printf("Error reading fixed information.\n");
  }

  // Get variable screen information
  if (ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo)) {
    printf("Error reading variable information.\n");
  }
  printf("%dx%d,%d bits per pixel\n", vinfo.xres, vinfo.yres, vinfo.bits_per_pixel );

  xRes = vinfo.xres;
  yRes = vinfo.yres;

  // map framebuffer to user memory 
  screensize = finfo.smem_len;

  fbp = (char*)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0);
  addr = (int)fbp;
  close(fbfd);
  return(addr);
}
int getScreenXSize(){
  int x = vinfo.xres;
  return (x);
}
int getScreenYSize(){
  int y = vinfo.yres;
  return (y);
}

//-----------------------------------------------
// Draw pixel in x,y coordinates with color c
//-----------------------------------------------
void pixel(int memPtr, int x, int y, int c){
  memset((char*)memPtr + 2*(xRes*y +x), c, 2);
}
