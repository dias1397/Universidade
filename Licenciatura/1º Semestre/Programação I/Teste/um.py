def first(word):
    return word[0]

def last(word):
    return word[-1]

def middle(word):
    return word[1:-1]

def pali(s):
    while len(s) >= 1:
        if first(s)!=last(s):
            pali(middle(s))
            return True
        else:
            return False
    
    
print(pali('aipa'))


