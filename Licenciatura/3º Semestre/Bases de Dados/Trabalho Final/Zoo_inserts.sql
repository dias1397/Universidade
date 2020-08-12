
/*ESPAÇOS*/
/*A3*/
insert into habitat values('A3', 'Quente e húmida', '1200');
/*A4*/
insert into habitat values('A4', 'Quente e húmida', '1100');
/*A5*/
insert into habitat values('A5', 'Quente e húmida', '1100');
/*A1*/
insert into habitat values('A1', 'Quente e húmida', '2000');
/*A2*/
insert into habitat values('A2', 'Fria e seca', '1500');
/*A6*/
insert into habitat values('A6', 'Quente e húmida', '500');
/*A7*/
insert into habitat values('A7', 'Quente e seca', '400');


/*Administrativoss*/
/*Manuel Ferreira*/
insert into funcionario values('123123129', 'Manuel Ferreira', '2004-02-01');
insert into administrativo values('123123129');
insert into funcionario_telefone values('123123129', '919999996');
insert into funcionario_telefone values('123123129', '266787806');
/*Manuela Torres*/
insert into funcionario values('123123130', 'Manuela Torres', '2004-04-01');
insert into administrativo values('123123130');
insert into funcionario_telefone values('123123130', '919999996');
insert into funcionario_telefone values('123123130', '266787806');
insert into funcionario_responsavel values('123123130', '123123129');


/*Manuel Ferreira*/
insert into funcionario_responsavel values('123123129', '123123130');

/*TRATADORES*/
/*Maria Gomes*/
insert into funcionario values('123123125', 'Maria Gomes', '2003-01-01');
insert into tratador values('123123125');
insert into funcionario_telefone values('123123125','919999997');
insert into funcionario_telefone values('123123125','266787807');
insert into funcionario_responsavel values('123123125', '123123130');

/*Joaquim Silva*/
insert into funcionario values('123123123', 'Joaquim Silva', '2003-02-01');
insert into tratador values('123123123');
insert into funcionario_telefone values('123123123','919999999');
insert into funcionario_telefone values('123123123','266787809');
insert into funcionario_responsavel values('123123123', '123123125');

/*Manuel Santos*/
insert into funcionario values('123123124', 'Manuel Santos', '2003-04-01');
insert into tratador values('123123124');
insert into funcionario_telefone values('123123124','919999998');
insert into funcionario_telefone values('123123124','266787808');
insert into funcionario_responsavel values('123123124', '123123125');


/*AUXILIARES*/
/*Mariana Silva*/
insert into funcionario values('123123126', 'Mariana Silva', '2004-02-01');
insert into auxiliar values('123123126');
insert into funcionario_telefone values('123123126','919999996');
insert into funcionario_telefone values('123123126','266787806');
insert into funcionario_responsavel values('123123126', '123123130');

insert into auxiliar_habitat values('A3', '123123126');
insert into auxiliar_habitat values('A4', '123123126');
insert into auxiliar_habitat values('A5', '123123126');
/*Jorge Gomes*/
insert into funcionario values('123123127', 'Jorge Gomes', '2004-03-01');
insert into auxiliar values('123123127');
insert into funcionario_telefone values('123123127','919999995');
insert into funcionario_telefone values('123123127','266787807');
insert into funcionario_responsavel values('123123127', '123123130');

insert into auxiliar_habitat values('A1', '123123127');
/*Francisco Jorge*/
insert into funcionario values('123123128', 'Francisco Jorge', '2004-03-01');
insert into auxiliar values('123123128');
insert into funcionario_telefone values('123123128','919999994');
insert into funcionario_telefone values('123123128','266787806');
insert into funcionario_responsavel values('123123128', '123123130');

insert into auxiliar_habitat values('A2', '123123128');
insert into auxiliar_habitat values('A7', '123123128');

/*Animais*/

/*TIGRES*/
insert into classificacao values('Tigre', 'Felinos', 'Carnivoros', 'Mamiferos');
/*Taji*/
insert into animais values('123456', 'Taji', 'M', '123123123', 'Tigre', 'A3');
insert into capturado values('123456', 'India, Agra', '2002-10-03','2003-12-20');
/*Mali*/
insert into animais values('222456', 'Mali', 'F', '123123123', 'Tigre', 'A3');
insert into capturado values('222456', 'India, Deli', '2003-11-05', '2004-11-30');
/*Aka*/
insert into animais values('322456', 'Aka', 'F', '123123123', 'Tigre', 'A3');
insert into cativeiro values('322456', '2005-12-12', '222456', '123456');
/*Táta*/
insert into animais values('422456', 'Táta', 'F', '123123123', 'Tigre', 'A4');
insert into cativeiro values('422456', '2006-01-20', '222456', '123456');
/*Cáta*/
insert into animais values('432456', 'Cáta', 'M', '123123123', 'Tigre', 'A5');
insert into capturado values('432456', 'India, Calcutá', '2004-10-01', '2005-01-01');
/*Kata*/
insert into animais values('522456', 'Kata', 'F', '123123123', 'Tigre', 'A5');
insert into cativeiro values('522456', '2007-03-02', '422456', '432456');
/*Mata*/
insert into animais values('622456', 'Mata', 'M', '123123123', 'Tigre', 'A4');
insert into cativeiro values('622456', '2008-02-02', '522456', '123456');

/*HIPOPOTAMOS*/
insert into classificacao values('Hipopótamo Comum', 'Hipopótamos', 'Artiodáctilos', 'Mamiferos');
/*Hipo*/
insert into animais values('123444', 'Hipo', 'M', '123123124', 'Hipopótamo Comum', 'A1');
insert into capturado values('123444', 'África, Madagascar', '2003-06-03', '2004-06-06');
/*Tapi*/
insert into animais values('223444', 'Tapi', 'F', '123123124', 'Hipopótamo Comum', 'A1');
insert into capturado values('223444', '2004-01-06', '2004-06-06');
/*Hita*/
insert into animais values('323444', 'Hita', 'F', '123123124', 'Hipopótamo Comum', 'A1');
insert into cativeiro values('323444', '2006-09-01', '223444', '123444');

/*VEADOS*/
insert into classificacao values('Veado', 'Cervídeos', 'Artiodáctilos', 'Mamiferos');
/*Kaki*/
insert into animais values('123666', 'Kaki', 'M', '123123124', 'Veado', 'A2');
insert into capturado values('123666', 'Europa, Pirenéus', '2004-06-01', '2004-12-06');
/*Kalu*/
insert into animais values('223666', 'Kalu', 'F', '123123124', 'Veado', 'A2');
insert into capturado values('223666', 'Europa, Ourense', '2004-01-13', '2004-12-07');
/*Kilu*/
insert into animais values('323666', 'Kilu', 'M', '123123124', 'Veado', 'A2');
insert into cativeiro values('323666', '2008-04-03', '223666', '123666');
/*Luka*/
insert into animais values('423666', 'Luka', 'F', '123123124', 'Veado', 'A2');
insert into capturado values('423666', 'Europa, Gerês', '2005-03-11', '2005-07-25');
/*Kuli*/
insert into animais values('524666', 'Kuli', 'M', '123123124', 'Veado', 'A2');
insert into cativeiro values('524666', '2008-03-04', '423666', '123666');


/*ARARAS*/
insert into classificacao values('Arara-azul-pequena', 'Psittacidae', 'Psittaciformes', 'Aves');
/*Ará*/
insert into animais values('123555', 'Ará', 'M', '123123125', 'Arara-azul-pequena', 'A7');
insert into capturado values('123555', 'América do sul, Paramá', '2005-02-25', '2005-08-03');
/*Zará*/
insert into animais values('133555', 'Zará', 'M', '123123125', 'Arara-azul-pequena',  'A7');
insert into capturado values('133555', 'América do sul, Paramá', '2005-04-21', '2005-08-03');
/*Rará*/
insert into animais values('223555', 'Rará', 'F', '123123125', 'Arara-azul-pequena',  'A7');
insert into capturado values('223555', 'América do sul, Uruguai', '2006-09-25', '2006-11-03');
/*Rara*/
insert into animais values('323555', 'Rara', 'M', '123123125', 'Arara-azul-pequena',  'A7');
insert into cativeiro values('323555', '2009-05-07', '223555', '123555');
/*Zula*/
insert into animais values('423555', 'Zula', 'F', '123123125', 'Arara-azul-pequena',  'A7');
insert into cativeiro values('423555', '2009-05-07', '223555', '123555');
/*Zura*/
insert into animais values('523555', 'Zura', 'F', '123123125', 'Arara-azul-pequena',  'A7');
insert into cativeiro values('523555', '2009-05-07', '223555', '123555');


/*VETERNARIOS*/
/*Pedro Vale*/
insert into funcionario values('123123131', 'Pedro Vale', '2004-05-01');
insert into veternario values('123123131');
insert into funcionario_telefone values('123123131','919999986');
insert into funcionario_telefone values('123123131','266787816');
insert into funcionario_responsavel values('123123131', '123123129');
/*Mali 12/8/2005*/
insert into consulta values('123123131','2005-08-12 10:00:00', 'Gab1', '222456');
insert into diagnostico values('123123131','2005-08-12 10:00:00', 'Gab1', 'Grávida');
/*Mali 12/9/2005*/
insert into consulta values('123123131', '2005-09-12 10:00:00', 'Gab1', '222456');
insert into tratamento values('123123131','2005-09-12 10:00:00', 'Gab1', 'Cálcio injectado');
/*Mali 12/12/2005*/
insert into consulta values('123123131', '2005-12-12 10:00:00', 'Gab1', '222456');
insert into tratamento values('123123131','2005-12-12 10:00:00', 'Gab1', 'Parto');
/*Mali 12/7/2006*/
insert into consulta values('123123131', '2006-07-12 10:00:00', 'Gab1', '222456');
insert into diagnostico values('123123131','2006-07-12 10:00:00', 'Gab1', 'Infecção');
/*Mali 12/7/2006*/
insert into consulta values('123123131', '2006-07-12 10:05:00', 'Gab1', '222456');
insert into tratamento values('123123131','2006-07-12 10:05:00', 'Gab1', 'Antibiótico injectado');
/*Kaki 12/5/2009*/
insert into consulta values('123123131', '2009-05-12 10:00:00', 'Gab1', '123666');
insert into diagnostico values('123123131','2009-05-12 10:00:00', 'Gab1', 'Infecção');
/*Kaki 12/5/2009*/
insert into consulta values('123123131', '2009-05-12 10:05:00', 'Gab1', '123666');
insert into tratamento values('123123131','2009-05-12 10:05:00', 'Gab1', 'Antibiótico injectado');
/*Ará 12/5/2009*/
insert into consulta values('123123131', '2009-05-12 10:10:00', 'Gab1', '123555');
insert into diagnostico values('123123131','2009-05-12 10:10:00', 'Gab1', 'Infecção');
/*Ará 12/5/2009*/
insert into consulta values('123123131', '2009-05-12 10:15:00', 'Gab1', '123555');
insert into tratamento values('123123131','2009-05-12 10:15:00', 'Gab1', 'Antibiótico injectado');
/*Zula 12/5/2009*/
insert into consulta values('123123131', '2009-05-12 10:20:00', 'Gab1', '423555');
insert into diagnostico values('123123131','2009-05-12 10:20:00', 'Gab1', 'Infecção');
/*Zula 12/5/2009*/
insert into consulta values('123123131', '2009-05-12 10:25:00', 'Gab1', '423555');
insert into tratamento values('123123131','2009-05-12 10:25:00', 'Gab1', 'Antibiótico injectado');
/*Tapi 12/8/2007*/
insert into consulta values('123123131', '2007-08-12 10:00:00', 'Gab1', '223444');
insert into diagnostico values('123123131','2007-08-12 10:00:00', 'Gab1', 'Infecção');
/*Tapi 12/8/2007*/
insert into consulta values('123123131', '2007-08-12 10:05:00', 'Gab1', '223444');
insert into tratamento values('123123131','2007-08-12 10:05:00', 'Gab1', 'Antibiótico injectado');


/*Isabel Soares*/
insert into funcionario values('123123132', 'Isabel Soares', '2004-06-01');
insert into veternario values('123123132');
insert into funcionario_telefone values('123123132','919999976');
insert into funcionario_telefone values('123123132','266787826');
insert into funcionario_responsavel values('123123132', '123123131');
/*Tapi 12/7/2006*/
insert into consulta values('123123132', '2006-07-12 10:00:00', 'Gab2', '223444');
insert into diagnostico values('123123132','2006-07-12 10:00:00', 'Gab2', 'Grávida');
/*Tapi 12/7/2006*/
insert into consulta values('123123132', '2006-07-12 10:05:00', 'Gab2', '223444');
insert into tratamento values('123123132','2006-07-12 10:05:00', 'Gab2', 'Cálcio injectado');
/*Tapi 12/9/2006*/
insert into consulta values('123123132', '2006-09-12 10:00:00', 'Gab2', '223444');
insert into tratamento values('123123132','2006-09-12 10:00:00', 'Gab2', 'Parto');
/*Tapi 12/7/2007*/
insert into consulta values('123123132', '2007-07-12 10:00:00', 'Gab2', '223444');
insert into diagnostico values('123123132','2007-07-12 10:00:00', 'Gab2', 'Infecção');
/*Tapi 12/7/2007*/
insert into consulta values('123123132', '2007-07-12 10:05:00', 'Gab2', '223444');
insert into tratamento values('123123132','2007-07-12 10:05:00', 'Gab2', 'Antibiótico injectado');
/*Tapi 12/7/2007*/
insert into consulta values('123123132', '2007-07-12 10:10:00', 'Gab2', '223444');
insert into diagnostico values('123123132','2007-07-12 10:10:00', 'Gab2', 'Grávida');
/*Tapi 12/7/2007*/
insert into consulta values('123123132', '2007-07-12 10:15:00', 'Gab2', '223444');
insert into tratamento values('123123132','2007-07-12 10:15:00', 'Gab2', 'Cálcio injectado');
/*Tapi 12/9/2007*/
insert into consulta values('123123132', '2007-09-12 10:00:00', 'Gab2', '223444');
insert into tratamento values('123123132','2007-09-12 10:00:00', 'Gab2', 'Parto');
/*Zula 12/6/2009*/
insert into consulta values('123123132', '2009-06-12 10:00:00', 'Gab2', '223444');
insert into diagnostico values('123123132','2009-06-12 10:00:00', 'Gab2', 'Infecção');
/*Zula 12/6/2009*/
insert into consulta values('123123132', '2009-06-12 10:05:00', 'Gab2', '223444');
insert into tratamento values('123123132','2009-06-12 10:05:00', 'Gab2', 'Antibiótico injectado');
