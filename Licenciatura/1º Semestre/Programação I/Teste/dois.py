import math

def fibonacci(n):
    soma=[]
    soma[0]=0
    soma[1]=1
    soma[2]=1
    for i in range(3,n):
        soma[i]=soma[i-1]+soma[i-2]
    print(soma[n])

def hipotenusa(x,y):
    return math.sqrt(x**2+y**2)

def pali(s):
    if s[0]!=s[-1]:
        return False
    return pali(s[1:(int(len(s)-1))])

def fatorial(n):
    if n<=0:
        return 1
    else:
        return n*fatorial(n-1)

def fatorial_i(n):
    soma=1
    if n==0:
        return 1
    for i in range(1,n+1):
        soma*=i
    return soma

def igual(x):
    if fatorial(x)==fatorial_i(x):
        return True
    return False
