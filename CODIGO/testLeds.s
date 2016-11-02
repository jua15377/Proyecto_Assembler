/******************************************************************************
*	PRUEBA DE LEDs
*	main.s  
*	Programa principal 
*	Por: Rodrigo Barrios, Carnet: 15009
*		 Juan Garcia, Carnet:	15046
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/

@@compliar con: gcc -o pruebaLED testLeds.s phys_to_virt.c gpio0_2.s
 
@PUERTOS DE GPIO
@@-----ENTRADA-----
@ GPIO 6 = BTN Start (provisional) 
@ GPIO 13 = BTN estado salon a211
@ GPIO 19 = BTN estado salon a210
@ GPIO 26 = BTN estado salon a212
@@-----SALIDA-----
@ GPIO 24 = LED rojo salon a210
@ GPIO 23 = LED verde salon a210
@ GPIO 12 = LED rojo salon a211
@ GPIO 16 = LED verde salon a211
@ GPIO 20 = LED rojo salon a212
@ GPIO 21 = LED verde salon a212


 .text
 .align 2
 .global main
main:


@@--------------------utilizando la biblioteca GPIO (gpio0_2.s)------------------
	bl GetGpioAddress @solo se llama una vez
@@--------------------Estableciendo puertos para la lectura------------------	
	@GPIO para lectura puerto 6 
	mov r0,#6
	mov r1,#0
	bl SetGpioFunction	

	@GPIO para lectura puerto 13 
	mov r0,#13
	mov r1,#0
	bl SetGpioFunction	

	@GPIO para lectura puerto 19 
	mov r0,#19
	mov r1,#0
	bl SetGpioFunction	

	@GPIO para lectura puerto 26 
	mov r0,#26
	mov r1,#0
	bl SetGpioFunction	

@@--------------------Estableciendo puertos para la escritura------------------	
	@GPIO para escritura puerto 24 
	mov r0,#24
	mov r1,#1
	bl SetGpioFunction

	@GPIO para escritura puerto 23 
	mov r0,#23
	mov r1,#1
	bl SetGpioFunction	

	@GPIO para escritura puerto 12 
	mov r0,#12
	mov r1,#1
	bl SetGpioFunction

	@GPIO para escritura puerto 16 
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction	

	@GPIO para escritura puerto 20 
	mov r0,#20
	mov r1,#1
	bl SetGpioFunction	

	@GPIO para escritura puerto 21 
	mov r0,#21
	mov r1,#1
	bl SetGpioFunction	

@--------------------------
@@apgando los LEDs y limpieza de pantalla
welcomeLoop:
	mov r0,#23
	mov r1,#0
	bl SetGpio
	mov r0,#24
	mov r1,#0
	bl SetGpio
	mov r0,#12
	mov r1,#0
	bl SetGpio
	mov r0,#16
	mov r1,#0
	bl SetGpio
	mov r0,#20
	mov r1,#0
	bl SetGpio
	mov r0,#21
	mov r1,#0
	bl SetGpio
	bl wait

	mov r0,#23
	mov r1,#1
	bl SetGpio
	mov r0,#24
	mov r1,#1
	bl SetGpio
	mov r0,#12
	mov r1,#1
	bl SetGpio
	mov r0,#16
	mov r1,#1
	bl SetGpio
	mov r0,#20
	mov r1,#1
	bl SetGpio
	mov r0,#21
	mov r1,#1
	bl SetGpio
b welcomeLoop 

checkButtons:
	push {lr}

	@revisar boton a211
	mov r0,#13
	bl GetGpio
	cmp r0,#1

	@revisar boton a210
	mov r0,#19
	bl GetGpio
	cmp r0,#1


	@revisar boton a212
	mov r0,#26
	bl GetGpio
	cmp r0,#1

pop {pc}



@@PEQUENA PAUSA
wait: 												@Subrutina de delay
	ldr r0, =bign	 @ big number
	ldr r0, [r0]
	sleepLoop:
	sub r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr 

 @@VARIABLES
.data 												@variables globales a utilizar
	bign: .word 0xfffffff
.global myloc
	myloc: .word 0
