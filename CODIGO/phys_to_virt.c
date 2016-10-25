#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>


// map a page (4096 bytes) starting at physical address base
int *phys_to_virt(long base)
{
  int mem_fd;
  char *io_mem;
  char *io_m;
  volatile unsigned *io;

  mem_fd=open("/dev/mem",O_RDWR|O_SYNC);

// create page-aligned pointer to 4096 bytes
  io_mem=(char *) malloc(8192);
  io_mem+=4096;
  io_mem=(char*) (((int) io_mem) & 0xfffff000);

  io_m=(char *) mmap((caddr_t)io_mem,4096,
                     PROT_READ|PROT_WRITE,
                     MAP_SHARED|MAP_FIXED,
                     mem_fd,base);
  //io=(volatile unsigned *)io_m;
  return((int *)io_m);
}
