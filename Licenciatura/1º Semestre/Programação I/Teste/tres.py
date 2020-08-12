def fibonacci(n):
    soma = [0,1]
    for i in range(n):
        soma.append(soma[i]+soma[i+1])
    print(int(soma[n]))
    
def print_n(s,n):
    if n <= 0:
        return
    print(s)
    print_n(s,n-1)

def print_i(s,n):
    for i in range(n):
        print(s)

def first_last6(nums):
    if nums[0]==nums[-1]:
        return True
    else:
        return False

def impares(a):
    soma=0
    for i in range(len(a)):
        if (int(a[i])%2) != 0:
            soma+=1
    print(soma)
