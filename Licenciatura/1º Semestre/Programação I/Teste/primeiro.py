def divisao(dividendo,divisor):
    contador=1
    res=divisor-dividendo
    if res<dividendo or res==0:
        return contador
    else:
        return 1+(divisao(dividendo,divisor-dividendo))

def divisao_2(dividendo,divisor):
    contador=1
    resultado=divisor-dividendo
    while resultado>=dividendo:
        resultado -= dividendo
        contador += 1
    print(contador)

def prefixo(string, pre):



    return(prefixo(string[



