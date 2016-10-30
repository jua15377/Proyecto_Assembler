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
@ GPIO 13 = BTN estado salon a211(provisinal)
@ GPIO 19 = BTN estado salon a210(provisinal) 
@ GPIO 26 = BTN estado salon a212(provisinal) 


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

@@-----------------------------------------------------------------------------
welcomeLoop: 										@El loop que se mantiene en la pagina de inicio hasta que un boton es presionado
	bl welcomeImg
	mov r0,#3

	@revisar boton Start
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	beq printResults
	bl checkButtons					

b welcomeLoop 

checkButtons:
	push {lr}

	@revisar boton a211
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	beq a211L
	bne a211O

	@revisar boton a210
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	beq a210L
	bne a210O	

	@revisar boton a212
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	beq a212L
	bne a212O	

pop {pc}

InfoPage:
	push {lr}
	bl welcomeImg2
	mov r0,#5
	bl better_sleep
pop {pc}

a211L:
	push {lr}
	ldr r0,=a211Estado
	ldr r1,[r0]
	cmp r1,#1
	moveq r1,#2
	movne r1,#1
	str r1,[r0]
pop {pc}

printResults:
	push {lr}

	bl InfoPage

	@Imprimiendo fondo
	bl blackScreenImg
	moveq r0,#1
	bl better_sleep

	@@ajustando posicion de imagen a211
	ldr r0,=origenY
	ldr r1,[r0]
	mov r1,#10
	ldr r2,=origenX
	ldr r3,[r2]
	mov r1,#10
	str r1,[r0]
	str r3,[r2]
	@@decidiendo que imagen mostrar
	ldr r0,=a211Estado
	ldr r1,[r0]
	cmp r1,#1
	bleq a211LibreImg
	blne a211OcupadoImg

	@@ajustando posicion de imagen a210
	ldr r0,=origenY
	ldr r1,[r0]
	mov r1,#20
	ldr r2,=origenX
	ldr r3,[r2]
	mov r1,#10
	str r1,[r0]
	str r3,[r2]
	@@decidiendo que imagen mostrar
	ldr r0,=a210Estado
	ldr r1,[r0]
	cmp r1,#1
	bleq a210LibreImg
	blne a210OcupadoImg

	@@ajustando posicion de imagen a212
	ldr r0,=origenY
	ldr r1,[r0]
	mov r1,#10
	ldr r2,=origenX
	ldr r3,[r2]
	mov r1,#10
	str r1,[r0]
	str r3,[r2]
	@@decidiendo que imagen mostrar
	ldr r0,=a212Estado
	ldr r1,[r0]
	cmp r1,#1
	bleq a212LibreImg
	blne a212OcupadoImg

	@pausa
	moveq r0,#10
	bl better_sleep
	bl InfoPage

@regrea a la  pantalla de inicio
pop {pc}

wait: 												@Subrutina de delay
	ldr r0, =bign	 @ big number
	ldr r0, [r0]
	sleepLoop:
	sub r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr 

  
.data 												@variables globales a utilizar
.global pixelAddr,origenX,origenY
	pixelAddr: .word 0
	bign: .word 0xfffffff
	origenY: .word 0
	origenX: .word 0
.global myloc
	myloc: .word 0
a210Estado: .word 1
a211Estado: .word 1
a212Estado: .word 1
