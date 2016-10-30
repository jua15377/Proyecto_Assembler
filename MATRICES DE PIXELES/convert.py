from PIL import Image

def rbg323(r,g,b):
    nR = int(round(r/255.0*7.0))
    nG = int(round(g/255.0*7.0))
    nB = int(round(b/255.0*3.0))
    return (nR<<5)+(nB<<3)+nG



name = 'a212Ocupado'
path_imagen = 'a212Ocupado.jpg'

img = Image.open(path_imagen)
matriz = img.load()
output = '\n'
output += '.data'+'\n'
output += '.align 2'+'\n'+'\n'
output += '.global ' + name + 'Height'+'\n'
output += '' + name +'Height: .word '+str(img.size[1])+'\n'
output += '.global '+ name +'Width'+'\n'
output += '' + name +'Width: .word '+str(img.size[0])+'\n'
output += '.global '+name+'\n'+'\n'
output += ''+name+':\n'

for j in range(img.size[1]):
    list_ = []
    for i in range(img.size[0]):
        if len(matriz[i,j])==3:
            r,g,b = matriz[i,j]
        elif len(matriz[i,j])==4:
            r,g,b,a = matriz[i,j]
        else:
            print "Error"
            break
        newRGB = rbg323(r,g,b) # convert to 16 bits
        list_.append(newRGB)
    output += '    .byte '+', '.join([str(a) for a in list_])+'\n'

# save the file
open(name+'.s','w').write(output)
