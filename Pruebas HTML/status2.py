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

# Declaracion de variables
c1 =0
c2 =0
path = "estado.html"

def revisarEstado1(entrada):
	if (entrada == 1):
		# Salon no disponible
		updateHTML("Salon A210",1)
	else:
		# Salon disponible
		updateHTML("Salon A210",0)

def revisarEstado2(entrada):
	if (entrada):
		# Salon no disponible
		updateHTML("Salon A211",1)
	else:
		# Salon disponible
		updateHTML("Slaon A211",0)
def revisarEstado3(entrada):
	if (entrada):
		# Salon no disponible
		updateHTML("Salon A212",1)
	else:
		# Salon disponible
		updateHTML("Salon A212",0)

def updateHTML(salon, estado):
	global c1
	global c2 # Accesar a contadores
	with open(path, "r+") as n:
		data = n.read()
		if (salon == "Salon A210"):
			if (estado ==1): # No disponible
				replaceString = salon + " no esta disponible\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A210"})
				
				div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
			if (estado==0): # Disponible
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
			if (estado ==1): # No disponible
				replaceString = salon + " no esta disponible\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A211"})
				
				div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
			if (estado==0): # Disponible
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
			if (estado ==1): # No disponible
				replaceString = salon + " no esta disponible\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A212"})
				
				div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
			if (estado==0): # Disponible
				replaceString = salon + " esta disponible!\n A las: " + strftime("%H:%M:%S")
				soup = BeautifulSoup(data)
				div = soup.find("div",{"class": "Salon A212"})
				div['style'] = 'background-color: #33cc33; font-size:xx-large;'
				div.string=replaceString
				n.close
				html = soup.prettify("utf-8")
				with open(path, "wb") as file:
					file.write(html)
def upload():
	threading.Timer(15, upload).start()
	os.system('xyz') # Aqui va el directorio de Dropbox
'''def upload():
	repo = git.Repo.clone_from("git@github.com:JuanAndres896/JuanAndres896.github.io.git","JuanAndres896.github.io")
	repo.index.add(["index.html"])
	repo.index.commit("prueba")
	repo.remotes.origin.push()'''
revisarEstado1(0)
revisarEstado2(1)
revisarEstado3(0)
