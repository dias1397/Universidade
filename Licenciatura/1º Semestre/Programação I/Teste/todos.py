def compara(x,y):
    if x>y:
        return 1
    elif x==y:
        return 0
    else:
        return -1

compara(1,1)



import math

def hipotenusa(cateto1, cateto2):
    return round(math.sqrt((cateto1**2)+(cateto2**2)),3)

hipotenusa(4,3)



def ack(m,n):
    if m==0:
        return n+1
    elif (m>0 and n==0):
        return ack(m-1,1)
    else:
        return ack(m-1, ack(m, n-1))
             
ack(3,4)



def a(x,y):
    x = x+1
    return x*y

def b(z):
    prod = a(z,z)
    print(z,prod)
    return prod

def c(x,y,z):
    sum = x+y+z
    pw = b(sum)**2
    return pw

x=1
y=x+1

print(c(x, y+3, x+y))




