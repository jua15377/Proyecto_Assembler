'''
Universidad del Valle de Guatemala
Taller de Assembler - Seccion 31
Rodrigo Barrios - 15009
Juan Andres Garcia - 15046
Jonnathan Juarez - 15377
Status.py - Funciones utilizadas para cambiar estado del sitio web 
que informa sobre la disponibilidad de los salones en tiempo real
Se van a llamar en ARM via C, con embedding
'''
# Idea original: https://www.youtube.com/watch?v=ZszlVVY1LXo
import threading, re, time, os
from time import strftime
from BeautifulSoup import BeautifulSoup
import RPi.GPio as GPIO
# Setup de pines GPIO

GPIO.setmode(GPIO.BCM)
GPIO.setup(17,GPIO.IN) # Numero de pin 'dummy', sujeto a cambiar
GPIO.setup(27, GPIO.IN) # Numero de pin 'dummy', sujeto a cambiar
GPIO.setup(24, GPIO.OUT) # Numero de pin 'dummy', sujeto a cambiar
GPIO.setup(25, GPIO.OUT) # Numero de pin 'dummy', sujeto a cambiar

# Declaracion de variables
c1 =0
c2 =0
pollTime =1
path = "/home/pi/estado.html"

def revisarEstado1():
	threading.Timer(pollTime, revisarEstado).start() # Se usa para que la funcion corra indefinidamente
	global c1
	global c2 # Accesar a contadores
	if (GPIO.input(17)):
		# Salon no disponible
		updateHTML("Salon A211",1)
		c1 +=pollTime
		GPIO.output(25, GPIO.LOW) # Verificar si es logica inversa o directa
	else:
		# Salon disponible
		updateHTML("Slaon A211",0)
		c1 =0
		GPIO.output(25, GPIO.HIGH) # Verificar si es logica inversa o directa
	if(c1 >=4500):
		# En caso que un salon este siendo utilizado por mucho tiempo (45 min
		# Y alguien haya olvidado oprimir el switch
		updateHTML("Salon A211",2)

def revisarEstado2():
	threading.Timer(pollTime, revisarEstado).start() # Se usa para que la funcion corra indefinidamente
	global c1
	global c2 # Accesar a contadores
	if (GPIO.input(17)):
		# Salon no disponible
		updateHTML("Salon A212",1)
		c1 +=pollTime
		GPIO.output(25, GPIO.LOW) # Verificar si es logica inversa o directa
	else:
		# Salon disponible
		updateHTML("Slaon A212",0)
		c1 =0
		GPIO.output(25, GPIO.HIGH) # Verificar si es logica inversa o directa
	if(c1 >=4500):
		# En caso que un salon este siendo utilizado por mucho tiempo (45 min
		# Y alguien haya olvidado oprimir el switch
		updateHTML("Salon A212",2)

def revisarEstado3():
	threading.Timer(pollTime, revisarEstado).start() # Se usa para que la funcion corra indefinidamente
	global c1
	global c2 # Accesar a contadores
	if (GPIO.input(17)):
		# Salon no disponible
		updateHTML("Salon A213",1)
		c1 +=pollTime
		GPIO.output(25, GPIO.LOW) # Verificar si es logica inversa o directa
	else:
		# Salon disponible
		updateHTML("Slaon A213",0)
		c1 =0
		GPIO.output(25, GPIO.HIGH) # Verificar si es logica inversa o directa
	if(c1 >=4500):
		# En caso que un salon este siendo utilizado por mucho tiempo (45 min
		# Y alguien haya olvidado oprimir el switch
		updateHTML("Salon A213",2)

def updateHTML(salon, estado):
	global c1
	global c2 # Accesar a contadores
	with open(path, "r+") as n:
		data = n.read()
		if (estado ==1): # No disponible
			replaceString = salon + "no esta disponible \n A las: " + strftime("%H:%M:%S")
			soup = BeautifulSoup(data)
			div = soup.find('div',{'class': salon})
			div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
			div.string = replaceString
			n.close
			html = soup.prettify("utf-8")
			with open(path, "wb") as file:
				file.write(html)
		if (estado==0): # Disponible
			replaceString = salon + "¡esta disponible! \n A las: " + strftime("%H:%M:%S")
			soup = BeautifulSoup(data)
			div = soup.find('div',{'class': salon})
			div['style'] = 'background-color: #008000; font-size:xx-large;' # Probar e ir cambiando despues
			div.string = replaceString
			n.close
			html = soup.prettify("utf-8")
			with open(path, "wb") as file:
				file.write(html)
		if (estado ==2): # Ha estado sin cambiar por 45 minutos
			replaceString = " "
			if (salon == "Salon 1"):
				replaceString = salon + " ha estado cerrado por " + str(c1) + " segundos"
			else:
				replaceString = salon + " ha estado cerrado por " + str(c2) + " segundos"
			soup = BeautifulSoup(data)
			div = soup.find('div',{'class': salon})
			div['style'] = 'background-color: #008000; font-size:xx-large;' # Probar e ir cambiando despues
			div.string = replaceString
			n.close
			html = soup.prettify("utf-8")
			with open(path, "wb") as file:
				file.write(html)
def upload():
	threading.Timer(15, upload).start()
	os.system('xyz') # Aqui va el directorio de Dropbox