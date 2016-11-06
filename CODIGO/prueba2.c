/*importane INSTALAR PRIMERO python-dev*/
/*importante colocar todo el path*/
#include </usr/include/python2.7/Python.h>
/*comppila con: gcc -lpython2.7 -o name prueba2.c*/

/*si funciona al llamar se arm*/
int holaMundo(){
  	Py_Initialize();
  	PyRun_SimpleString("print 'Hola mundo :)'\n");
  	Py_Finalize();
  	return 0;
}
/*si funciona al llamar se arm*/
int texto2(){
  	Py_Initialize();
  	PyRun_SimpleString("print 'esta es la funcion 2'\n");
  	Py_Finalize();
  	return 0;
}
/*algo mas complejo para probar, compila. Erro en timepo de ejecucion*/
void conversor(){
    Py_Initialize();
    PyRun_SimpleString("from PIL import Image\n"
"def rbg323(r,g,b):\n"
"\tnR = int(round(r/255.0*7.0))\n"
"\tnG = int(round(g/255.0*7.0))\n"
"\tnB = int(round(b/255.0*3.0))\n"
"\treturn (nR<<5)+(nB<<3)+nG\n"
/*la imagen debe esta en la misma carpeta*/
"name = 'a212Ocupado'\n"
"path_imagen = 'a212Ocupado.jpg'\n"
"img = Image.open(path_imagen)\n"
"matriz = img.load()\n"
/*en la  siguiente linea truena*/
"output = '\n'\n"
"output += '.data'+'\n'\n"
"output += '.align 2'+'\n'+'\n'\n"
"output += '.global ' + name + 'Height'+'\n'\n"
"output += '' + name +'Height: .word '+str(img.size[1])+'\n'\n"
"output += '.global '+ name +'Width'+'\n'\n"
"output += '' + name +'Width: .word '+str(img.size[0])+'\n'\n"
"output += '.global '+name+'\n'+'\n'\n"
"output += ''+name+':\n'\n"
"for j in range(img.size[1]):\n"
"\tlist_ = []\n"
"\tfor i in range(img.size[0]):\n"
"\t\tif len(matriz[i,j])==3:\n"
"\t\t\tr,g,b = matriz[i,j]\n"
"\t\telif len(matriz[i,j])==4:\n"
"\t\t\tr,g,b,a = matriz[i,j]\n"
"\t\telse:\n"
"\t\t\tprint 'Error'\n"
"\t\t\tbreak\n"
"\t\tnewRGB = rbg323(r,g,b) # convert to 16 bits\n"
"\t\tlist_.append(newRGB)\n"
"\toutput += '\t.byte '+', '.join([str(a) for a in list_])+'\n'\n"
"# save the file\n"
"open(name+'.s','w').write(output)\n"
);
  	Py_Finalize();
}
