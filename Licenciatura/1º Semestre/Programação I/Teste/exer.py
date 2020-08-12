def multiplica(x,y):
    print('Resultado de multiplicar ',x,' com ',y,' : ',(x*y))

def right_justify(s):
    print(' '*(70-int(len(s))),s)

def unidades(n):
    print('O numero',n,'possui',(n%10),'como algarismo das unidades')

def ordem(n):
    for i in range(n):
        print(i)

def soma(n):
    soma=0
    for i in range(n):
        soma+=(i+1)
    print(soma)

def par(n):
    if n%2==0:
        print('True')
    else:
        print('False')

def triangulo(a,b,c):
    if a<b+c and b<b+c and c<a+b:
        if a==b==c:
            print('Triangulo Equilatero')
        elif a!=b!=c:
            print('Triangulo Escaleno')
        else:
            print('Triangulo Isósceles')
    else:
        print('Não é triangulo')
