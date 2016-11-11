/*importane INSTALAR PRIMERO python-dev*/
/*importante colocar todo el path*/
#include </usr/include/python2.7/Python.h>
#include <stdio.h>
/*comppila con: gcc -lpython2.7 -o name prueba2.c*/
/*tomado de https://www.tutorialspoint.com/c_standard_library/c_function_system.htm*/
/*https://www.tutorialspoint.com/python/python_command_line_arguments.htm*/

/*1 est disponible; 0 est ocupado*/
int htmlUpdaterA210(int est){
   char command[72];

   if( est == 1 ) {
    //printf("entro libre a210\n");
    strcpy(command, "sudo python /home/pi/Desktop/TallerDeAssembler/proyecto/status.py 210 1");
    system(command);
   }
   else {
    //printf("entro ocupado a210\n");
    strcpy(command, "sudo python /home/pi/Desktop/TallerDeAssembler/proyecto/status.py 210 0");
    system(command);
   }

   return(0);
}
int htmlUpdaterA211(int est){
   char command[72];

   if( est == 1 ) {
    //printf("entro libre a211\n");
    strcpy(command, "sudo python /home/pi/Desktop/TallerDeAssembler/proyecto/status.py 211 1");
    system(command);
   }
   else {
    //printf("entro libre a211\n");
    strcpy(command, "sudo python /home/pi/Desktop/TallerDeAssembler/proyecto/status.py 211 0");
    system(command);
   }

   return(0);
}

int htmlUpdaterA212(int est){
   char command[72];

   if( est == 1 ) {
    strcpy(command, "sudo python /home/pi/Desktop/TallerDeAssembler/proyecto/status.py 212 1");
    system(command);
   }
   else {
    strcpy(command, "sudo python /home/pi/Desktop/TallerDeAssembler/proyecto/status.py 212 0");
    system(command);
   }

   return(0);
}

