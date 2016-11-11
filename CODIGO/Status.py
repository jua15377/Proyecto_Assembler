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
import  re, time, os, sys
from time import strftime
from BeautifulSoup import BeautifulSoup

# Declaracion de variables
c1 =0
c2 =0
path = "/home/pi/Desktop/TallerDeAssembler/proyecto/estado.html"

def actualizarEstadoAula1(entrada):
	if (entrada == 0):
		#Salon no disponible
		updateHTML("Salon A210",0)
	else:
		#Salon disponible
		updateHTML("Salon A210",1)

def actualizarEstadoAula2(entrada):
	if (entrada == 0):
		# Salon no disponible
		updateHTML("Salon A211",0)
	else:
		# Salon disponible
		updateHTML("Salon A211",1)
def actualizarEstadoAula3(entrada):
	if (entrada == 0):
		# Salon no disponible
		updateHTML("Salon A212",0)
	else:
		# Salon disponible
		updateHTML("Salon A212",1)

def updateHTML(salon, estado):
	global c1
	global c2 # Accesar a contadores
	with open(path, "r+") as n:
		data = n.read()
		if (salon == "Salon A210"):
			if (estado == 0): # No disponible
				replaceString = salon + " no esta disponible\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A210"})
				div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
			if (estado==1): # Disponible
				replaceString = salon + " esta disponible!\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A210"})
				div['style'] = 'background-color: #33cc33; font-size:xx-large;'
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
		if (salon == "Salon A211"):
			if (estado ==0): # No disponible
				replaceString = salon + " no esta disponible\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A211"})
				
				div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
			if (estado==1): # Disponible
				replaceString = salon + " esta disponible!\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A211"})
				div['style'] = 'background-color: #33cc33; font-size:xx-large;'
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
		if (salon == "Salon A212"):
			if (estado ==0): # No disponible
				replaceString = salon + " no esta disponible\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A212"})
				
				div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
			if (estado==1): # Disponible
				replaceString = salon + " esta disponible!\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A212"})
				div['style'] = 'background-color: #33cc33; font-size:xx-large;'
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
#http://stackoverflow.com/questions/17544307/how-do-i-run-python-script-using-arguments-in-windows-command-line

def actualizacion(aulaParam,condcionParam):
    if(aulaParam == 210):
    	actualizarEstadoAula1(condcionParam)
    elif(aulaParam == 211):
    	actualizarEstadoAula2(condcionParam)
    elif(aulaParam == 212):
    	actualizarEstadoAula3(condcionParam)

if __name__ == "__main__":
    aula = int(sys.argv[1])
    #print aula
    condcion = int(sys.argv[2])
    #print condcion
    actualizacion(aula, condcion)