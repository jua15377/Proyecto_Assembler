@/******************************************************************************
@*	MazeMethods.s
@*	Subrutinas del juego MazeCase
@*	Por: Diego Castaneda, Carnet: 15151
@*   	 Jonnathan Juares, Carnet: 15377
@*   Taller de Assembler, Seccio: 30
@*******************************************************************************/
@ ******************************************************************
@	background1
@	Subrutina que imprime en pantalla el fondo que se desea colocar
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ ******************************************************************
.global background1
background1: 
	push {lr}
		x	  .req r1
		y         .req r2
		colour 	  .req r3
		addrPixel .req r5
		countByte .req r6
		ancho	  .req r7
		alto	  .req r8

	mov countByte,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr ancho,=laberintoL1Width
	ldr ancho,[ancho]
	ldr alto,=laberintoL1Height
	ldr alto,[alto]
	mov y,#0

	@Ciclo que dibuja filas
	drawRow:
		mov x,#0
		drawPixel:
			cmp x,ancho				@comparar x con el ancho de la imagen
			bge end
			ldr addrPixel,=laberintoL1 	@Obtenemos la direccion de la matriz con los colores
			ldrb colour,[addrPixel,countByte]	@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add countByte,#1 		@Incrementamos los bytes dibujados
			add x,#1 				@Aumenta el contador del ancho de la imagen
		
			b drawPixel
	end:	
		@ aumentamos y
		add y,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq y,alto
		bne drawRow

	.unreq x		  
	.unreq	y         
	.unreq	colour 	  
	.unreq	addrPixel 
	.unreq	countByte 
	.unreq	ancho	  
	.unreq	alto
pop {pc}

@ ****************************************************************************
@	character
@	Subrutina que imprime una imagen segun coordenadas, ancho y largo de la misma
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ *****************************************************************************
@ 	Asignaciones: 
@	r1 - comparador de x
@	r2 - comparador de y
@	r3 - matriz de colores
@   r4 - addrPixel 
@	r5 - direccion de la matriz
@	r6 - contador de bytes
@	r7 - ancho
@ 	r8 - alto
@*******************************************************************************
.global character
character: 
	push {lr} 
	
	mov r6,#0 	

	ldr r9, =origenX
	ldr r9, [r9]										@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=gallinaSprite1Width 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	add r7, r9

	ldr r10, =origenY
	ldr r10, [r10]
	ldr r8,=gallinaSprite1Height
	ldr r8,[r8]
	add r8, r10

	ldr r2, =origenY
	ldr r2, [r2]
	filas:
		
		ldr r1, =origenX
		ldr r1, [r1]

		dibujaPixel:
			
			ldr r5,=gallinaSprite1
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			cmp r3,#39
			blne pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 

			cmp r1, r7
			blt dibujaPixel				@Aumenta el contador del ancho de la imagen
		

	finIm:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas

	pop {pc}

@ ****************************************************************************
@	character
@	Subrutina que imprime una imagen segun coordenadas, ancho y largo de la misma
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ *****************************************************************************
@ 	Asignaciones: 
@	r1 - comparador de x
@	r2 - comparador de y
@	r3 - matriz de colores
@   r4 - addrPixel 
@	r5 - direccion de la matriz
@	r6 - contador de bytes
@	r7 - ancho
@ 	r8 - alto
@*******************************************************************************
.global character2
character2: 
	push {lr} 
	
	mov r6,#0
	ldr r9, =origenX
	ldr r9, [r9]				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=gallinaSprite2Width 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	add r7, r9

	ldr r10, =origenY
	ldr r10, [r10]
	ldr r8,=gallinaSprite2Height
	ldr r8,[r8]
	add r8, r10

	ldr r2, =origenY
	ldr r2, [r2]
	filas2:
		ldr r1, =origenX
		ldr r1, [r1]
		
		dibujaPixel2:
			
			ldr r5,=gallinaSprite2
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			cmp r3,#39
			blne pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 

			cmp r1, r7
			blt dibujaPixel2				@Aumenta el contador del ancho de la imagen
		
	finIm2:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas2

	pop {pc}


@ ****************************************************************************
@	intro
@*******************************************************************************
.global welcomeImg
welcomeImg: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=introWidth			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=introHeight 
	ldr r8,[r8]
	mov r2,#0
	filas3:
		mov r1,#0
		dibujaPixel3:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm3
			ldr r5,=intro
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel3
	finIm3:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas3

	pop {pc}

@*******************************************************************************
@ GameOver 
@*******************************************************************************
.global GameOverImg
GameOverImg: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=GameOverWidth			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=GameOverHeight 
	ldr r8,[r8]
	mov r2,#0
	filas4:
		mov r1,#0
		dibujaPixel4:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm4
			ldr r5,=GameOver
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel4
	finIm4:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas4

	pop {pc}

@*******************************************************************************
@ background2
@*******************************************************************************
.global background2
background2: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=testlaberintoL2Width			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=testlaberintoL2Height 
	ldr r8,[r8]
	mov r2,#0
	filas5:
		mov r1,#0
		dibujaPixel5:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm5
			ldr r5,=testlaberintoL2
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel5
	finIm5:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas5

	pop {pc}

@*******************************************************************************
@ background3
@*******************************************************************************
.global background3
background3: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=testlaberintoL3Width			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=testlaberintoL3Height 
	ldr r8,[r8]
	mov r2,#0
	filas6:
		mov r1,#0
		dibujaPixel6:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm6
			ldr r5,=testlaberintoL3
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel6
	finIm6:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas6

	pop {pc}


@ ****************************************************************************
@	intro2
@*******************************************************************************
.global welcomeImg2
welcomeImg2: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=intro2Width			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=intro2Height 
	ldr r8,[r8]
	mov r2,#0
	filas7:
		mov r1,#0
		dibujaPixel7:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm7
			ldr r5,=intro2
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel7
	finIm7:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas7

	pop {pc}

@ ****************************************************************************
@	maiz
@	Subrutina que imprime una imagen segun coordenadas, ancho y largo de la misma
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ *****************************************************************************
@ 	Asignaciones: 
@	r1 - comparador de x
@	r2 - comparador de y
@	r3 - matriz de colores
@   r4 - addrPixel 
@	r5 - direccion de la matriz
@	r6 - contador de bytes
@	r7 - ancho
@ 	r8 - alto
@*******************************************************************************
.global maizImg
maizImg: 
	push {lr} 
	
	mov r6,#0 	

	mov r9, #860				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=maizWidth 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	add r7, r9

	mov r10, #100
	ldr r8,=maizHeight
	ldr r8,[r8]
	add r8, r10

	mov r2, #100
	filas8:
		
		mov r1, #860

		dibujaPixel8:
			
			ldr r5, =maiz
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			cmp r3,#39
			blne pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 

			cmp r1, r7
			blt dibujaPixel8			@Aumenta el contador del ancho de la imagen
		

	finIm8:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas8	

	pop {pc}

@ ****************************************************************************
@	winner
@*******************************************************************************
.global WinGameImg
WinGameImg: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=ganadorWidth			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=ganadorHeight 
	ldr r8,[r8]
	mov r2,#0
	filas9:
		mov r1,#0
		dibujaPixel9:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm9
			ldr r5,=ganador
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel9
	finIm9:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas9

	pop {pc}
@ ****************************************************************************
@	intructions
@*******************************************************************************
.global instructionsImg
instructionsImg: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=intruccionesWidth			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=intruccionesHeight 
	ldr r8,[r8]
	mov r2,#0
	filas10:
		mov r1,#0
		dibujaPixel10:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm10
			ldr r5,=intrucciones
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel10
	finIm10:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas10

	pop {pc}
