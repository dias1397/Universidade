def tras(s):
    for i in range((len(s)+1)):
        print(s[0:len(s)-i])

def espelho(s):
    print(s[::-1])

def contar(a,b):
    soma=0
    for i in range(len(a)):
        for j in range(len(b)):
            if a[i]==b[j]:
                soma+=1
    print(soma)
