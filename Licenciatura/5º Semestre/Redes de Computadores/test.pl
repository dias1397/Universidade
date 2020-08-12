a(l,m).
a(l,e).
a(e,b).
a(m,b).
a(m,p).
a(n,b).
a(p,f).
a(n,f).
a(f,r).
a(n,p).

e(X,Y) :- a(X,Y).
e(X,Y) :- a(Y,X).

cam(A,B) :- a(A,B).
cam(A,B) :- a(A,C), cam(C,B).
