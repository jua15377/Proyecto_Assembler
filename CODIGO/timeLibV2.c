// Universidad del Valle de Guatemala
// Taller de Assembler 2016
// C library to mannage time from ASM
// Christian Medina Armas
// AGO-2016
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>

//CODIGO TOMADO DE : http://www.informit.com/articles/article.aspx?p=23618&seqNum=11
//HECHO POR : Mark L. Mitchell and Jeffrey Oldham (OCT 12,2001)
//ADAPTOADOR POR: Jonnathan Juarez

int better_sleep (int sleep_time)
{
	 struct timespec tv;
	 /* Construct the timespec from the number of whole seconds... */
	 tv.tv_sec = sleep_time;
	 /* ... and the remainder in nanoseconds. */
	 tv.tv_nsec = 0;
	 
	 while (1)
	 {
	  /* Sleep for the time specified in tv. If interrupted by a
	    signal, place the remaining time left to sleep back into tv. */
	  int rval = nanosleep (&tv, &tv);
	  if (rval == 0)
	   /* Completed the entire sleep time; all done. */
	   return 0;
	  else if (errno == EINTR)
	   /* Interrupted by a signal. Try again. */
	   continue;
	  else 
	   /* Some other error; bail out. */
	   return rval;
	 }
	 return 0;
}


