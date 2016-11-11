import  re, time, os
from time import strftime
from BeautifulSoup import BeautifulSoup
path = '/home/pi/Desktop/TallerDeAssembler/proyecto/estado.html'
with open(path, "r+") as n:
	data = n.read()
	replaceString = "A210 no esta disponible A las:\n"+ strftime("%H:%M:%S")\n"
	soup = BeautifulSoup(data)
	div = soup.find("div",{"class": "Salon A210"})
	div['style'] = 'background-color: #FF0000; font-size:xx-large;' # Probar e ir cambiando despues\n"
	div.string=replaceString
	n.close
	html = soup.prettify("utf-8")
	with open(path, "wb") as file:
		file.write(html)