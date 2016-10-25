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


 .text
 .align 2
 .global main
main:

@@--------------------INICIANDO DIRECCIONES Y POSICIONES----------------------*/
	@ldr r0,=xRes
	@ldr r1,=yRes
	bl getScreenAddr 			@Se obtiene la direccion de la pantalla 
	ldr r1,=pixelAddr
	str r0,[r1]


@@--------------------utilizando la biblioteca GPIO (gpio0_2.s)------------------
	bl GetGpioAddress @solo se llama una vez
	
	@GPIO para lectura puerto 6 
	mov r0,#6
	mov r1,#0
	bl SetGpioFunction	

	@GPIO para lectura puerto 13 
	mov r0,#13
	mov r1,#0
	bl SetGpioFunction	

welcomeLoop: 										@El loop que se mantiene en la pagina de inicio hasta que un boton es presionado
	bl welcomeImg
	mov r0,#3
	@revisar boton Start
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	beq printResults

	@revisar boton a211
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	beq a211	
	mov r0,#1								
	bl better_sleep 

	bl welcomeImg2
	@revisar boton Start
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	beq printResults

	@revisar boton a211
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	beq a211									
	mov r0,#5
	bl better_sleep 								


	@revisar boton Start
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	beq printResults

	@revisar boton a211
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	beq a211
b welcomeLoop 

a211:
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
	@Imprimiendo fondo
	bl blackScreenImg
	moveq r0,#1
	bl better_sleep
	@@ajustando posicion de imagen
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
	@pausa
	moveq r0,#8
	bl better_sleep

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
a211Estado: .word 1
