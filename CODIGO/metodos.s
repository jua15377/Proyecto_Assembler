/******************************************************************************
*	Proyecto
*	metodos.s  
*	Programa con subrutinas
*	Por: Rodrigo Barrios, Carnet: 15009
*		 Juan Garcia, Carnet:	15046
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/

.global welcomeImg
welcomeImg: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=intro1Width			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=intro1Height 
	ldr r8,[r8]
	mov r2,#0
	filas:
		mov r1,#0
		dibujaPixel:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm
			ldr r5,=intro1
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel
	finIm:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas

	pop {pc}

/*******************************************************************************/
/*******************************************************************************/
/*******************************************************************************/
.global welcomeImg2
welcomeImg2: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=intro2Width			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=intro2Height 
	ldr r8,[r8]
	mov r2,#0
	filas1:
		mov r1,#0
		dibujaPixel1:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm1
			ldr r5,=intro2
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel1
	finIm1:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas1

	pop {pc}


.global a211LibreImg
a211LibreImg: 
	push {lr} 
	
	mov r6,#0
	ldr r9, =origenX
	ldr r9, [r9]				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=a211LibreWidth 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	add r7, r9

	ldr r10, =origenY
	ldr r10, [r10]
	ldr r8,=a211LibreHeight
	ldr r8,[r8]
	add r8, r10

	ldr r2, =origenY
	ldr r2, [r2]
	filas2:
		ldr r1, =origenX
		ldr r1, [r1]
		
		dibujaPixel2:
			
			ldr r5,=a211Libre
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
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


.global a211OcupadoImg
a211OcupadoImg: 
	push {lr} 
	
	mov r6,#0
	ldr r9, =origenX
	ldr r9, [r9]				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=a211OcupadoWidth 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	add r7, r9

	ldr r10, =origenY
	ldr r10, [r10]
	ldr r8,=a211OcupadoHeight
	ldr r8,[r8]
	add r8, r10

	ldr r2, =origenY
	ldr r2, [r2]
	filas3:
		ldr r1, =origenX
		ldr r1, [r1]
		
		dibujaPixel3:
			
			ldr r5,=a211Ocupado
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 

			cmp r1, r7
			blt dibujaPixel3				@Aumenta el contador del ancho de la imagen
		
	finIm3:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas3

	pop {pc}

/*******************************************************************************/
/*******************************************************************************/
/*******************************************************************************/
.global blackScreenImg
blackScreenImg: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=blackScreenWidth			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=blackScreenHeight 
	ldr r8,[r8]
	mov r2,#0
	filas4:
		mov r1,#0
		dibujaPixel4:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm4
			ldr r5,=blackScreen
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
