def triangulo(a, b, c):
    if a+b>c or a+c>b or b+c>a:
        if a==b==c:
            print('Triangulo Equilatero')
        elif a!=b!=c:
            print('Triangulo Escaleno')
        else:
            print('Triangulo Isosceles')
    else:
        print('Nao é triangulo')

triangulo(1,2,3)
