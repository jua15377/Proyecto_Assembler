/******************************************************************************
*	Proyecto
*	main.s  
*	Programa principal 
*	Por: Rodrigo Barrios, Carnet: 15009
*		 Juan Garcia, Carnet:	15046
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/

@@compliar con: gcc -o main main.s  metodos.s pixelV2.c phys_to_virt.c timeLibV2.c gpio0_2.s intro.s salones.s
 
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

@@--------------------INICIANDO DIRECCIONES Y POSICIONES----------------------*/
	bl getScreenAddr 			@Se obtiene la direccion de la pantalla 
	ldr r1,=pixelAddr
	str r0,[r1]


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
	bl blackScreenImg
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
@@pausa
	mov r0,#3
	bl better_sleep

@@-------------------------------

welcomeLoop: 										@El loop que se mantiene en la pagina de inicio hasta que un boton es presionado
	bl welcomeImg
	bl checkButtons
	@revisar boton Start
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	bleq printResults	

b welcomeLoop 

checkButtons:
	push {lr}

	@revisar boton a211
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	bleq a211O
	mov r0,#13
	bl GetGpio
	cmp r0,#0
	bleq a211L

	@revisar boton a210
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	bleq a210O
	mov r0,#19
	bl GetGpio
	cmp r0,#0
	bleq a210L	

	@revisar boton a212
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	bleq a212O
	mov r0,#26
	bl GetGpio
	cmp r0,#0
	bleq a212L	

pop {pc}

@@muestra informacion de como acceder al sitio web
InfoPage:
	push {lr}
	bl welcomeImg2
	mov r0,#5
	bl better_sleep
	bl checkButtons
pop {pc}
@@CADA UNA DE LAS SIGUIENTES SUBRUTINAS ES SELECCIONADA SEGUN EL ESTAO DEL INTERRUPTOR DEL SALON
@@LA TERMINACION L SIGINFCA LIBRE Y LA TERMINACION O a211OcupadoImg
@@SE ENCARGAN DE ENCENDER Y APAGAR LOS LEDs ASI COMO DE CAMBIAR EL ESATO DE UA VARIABLE UTILIZADA PARA SABER QUE SE VA A IMPRIMIR
a211L:
	push {lr}
	@enciende LED Verde 
	mov r0,#16
	mov r1,#1
	bl SetGpio
	@apaga LED rojo
	mov r0,#12
	mov r1,#0
	bl SetGpio

	ldr r0,=a211Estado
	mov r1,#1
	str r1,[r0]
pop {pc}

a211O:
	push {lr}
	@enciende LED rojo
	mov r0,#12
	mov r1,#1
	bl SetGpio
	@apaga LED verde
	mov r0,#16
	mov r1,#0
	bl SetGpio

	ldr r0,=a211Estado
	mov r1,#2
	str r1,[r0]
pop {pc}

a210L:
	push {lr}
	@enciende LED Verde 
	mov r0,#23
	mov r1,#1
	bl SetGpio
	@apaga LED rojo
	mov r0,#24
	mov r1,#0
	bl SetGpio

	ldr r2,=a210Estado
	mov r3,#1
	str r3,[r2]
pop {pc}

a210O:
	push {lr}
	@enciende LED rojo
	mov r0,#24
	mov r1,#1
	bl SetGpio
	@apaga LED verde
	mov r0,#23
	mov r1,#0
	bl SetGpio

	ldr r2,=a210Estado
	mov r3,#2
	str r3,[r2]
pop {pc}

a212L:
	push {lr}
	push {lr}
	@enciende LED Verde 
	mov r0,#21
	mov r1,#1
	bl SetGpio
	@apaga LED rojo
	mov r0,#20
	mov r1,#0
	bl SetGpio

	ldr r0,=a212Estado
	mov r1,#1
	str r1,[r0]
pop {pc}

a212O:
	push {lr}
	@enciende LED rojo
	mov r0,#20
	mov r1,#1
	bl SetGpio
	@apaga LED verde
	mov r0,#21
	mov r1,#0
	bl SetGpio

	ldr r0,=a212Estado
	mov r1,#2
	str r1,[r0]
pop {pc}


printResults:
	push {lr}

	bl InfoPage

	@Imprimiendo fondo
	bl blackScreenImg
	moveq r0,#1
	bl better_sleep

	@@imagen a211

	@@decidiendo que imagen mostrar
	ldr r0,=a211Estado
	ldr r1,[r0]
	cmp r1,#1
	bleq a211LibreImg
	blne a211OcupadoImg

	@@imagen a210

	@@decidiendo que imagen mostrar
	ldr r0,=a210Estado
	ldr r1,[r0]
	cmp r1,#1
	bleq a210LibreImg
	blne a210OcupadoImg

	@@imagen a212
	@@decidiendo que imagen mostrar
	ldr r0,=a212Estado
	ldr r1,[r0]
	cmp r1,#1
	bleq a212LibreImg
	blne a212OcupadoImg

	bl checkButtons
	@pausa
	moveq r0,#10
	bl better_sleep
	bl checkButtons
	bl InfoPage

@regrea a la  pantalla de inicio
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
.global pixelAddr,origenY
	pixelAddr: .word 0
	bign: .word 0xfffffff
	origenY: .word 100
@@UBICACION EN LA PANTALLA DE CADA UNO DE LOS ROTULOS DE LOS SALONES
.global origenX1,origenX2,origenX3
	origenX1: .word 0
	origenX2: .word 430
	origenX3: .word 830
.global myloc
	myloc: .word 0
@@SE UTILIZA PARA SABER SI EL SALON ESTA DISPONIBLE O NO
a210Estado: .word 1
a211Estado: .word 1
a212Estado: .word 1
