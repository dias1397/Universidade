drop schema public cascade;
create schema public;

create table motorista(
	Nome varchar(50),
	NCartaCond varchar(50),
	DataNasc date,
	Nbi integer check(Nbi > 0),
	primary key(Nbi)
);

create table telefone(
	Nbi integer check(Nbi > 0),
	Telefone integer,
	primary key(Telefone),
	foreign key (Nbi) references motorista on  delete restrict
);

create table modelo(
	Marca varchar(50),
	Modelo varchar(50),
	Nlugares integer check(Nlugares > 0),
	Consumo decimal check(Consumo > 0),
	primary key(Modelo)
);

create table taxi(
	Modelo varchar(50),
	Ano integer check(ano > 1900),
	Kms integer check(Kms > 0),
	Matricula char(8),
	primary key(Matricula),
	foreign key (Modelo) references modelo on  delete restrict	
);

create table servico(
	DataInicio timestamp,
	DataFim timestamp,
	Kms integer check(Kms > 0),
	Valor decimal check(Valor > 0),
	Matricula char(8),
	CoordGPSInic decimal,
	CoordGFPFim decimal,
	foreign key (Matricula) references taxi on  delete restrict
);

create table turno(
	DataInicio timestamp,
	DataFim timestamp,
	KmsInicio integer check(KmsInicio > 0),
	KmsFim integer check(KmsFim > KmsInicio),
	Matricula char(8),
	Nbi integer check(Nbi > 0),
	foreign key (Matricula) references taxi on  delete restrict,
	foreign key (Nbi) references motorista on  delete restrict
);	

create table cliente(
	Nome varchar(50),
	Morada varchar(50),
	CodigoPostal varchar(50),
	Nif varchar(50),
	primary key(Nif)
);

create table pedido(
	Nif varchar(50),
	MoradaInicio varchar(50),
	CodigoPostalInicio varchar(50),
	DataPedido timestamp,
	Matricula char(8),
	DataInicio timestamp,
	foreign key (Matricula) references taxi on  delete restrict,
	foreign key (Nif) references cliente on  delete restrict
);

/*frota de taxis*/
insert into modelo values ('Renault','Escape','7','7');
insert into taxi values('Escape','2015','123098','22-AA-22');

insert into modelo values ('Mercedes','CLK','7','9');
insert into taxi values('CLK','2014','234554','21-AA-22');

insert into modelo values ('Honda','Civic','5','5');
insert into taxi values('Civic','2012','89764','20-AA-22');

insert into modelo values ('Mercedes','Mercedes-Benz Classe S','5','6.5');
insert into taxi values('Mercedes-Benz Classe S','2015','79744','19-AA-22');

insert into modelo values('Audi','TT','5','6');
insert into taxi values('TT','2015','50000','25-XX-15');

insert into modelo values('Renault','Clio Break','5','7');
insert into taxi values('Clio Break','2015', '98756','13-QE-89');

/*taxistas*/
insert into motorista values('Manuel Duarte','L-123','1976-01-14','1234');
insert into telefone values('1234','266262626');
insert into telefone values('1234','939393939');

insert into motorista values('Fernando Nobre','L-124','1977-01-14','1235');
insert into telefone values('1235','266262627');
insert into telefone values('1235','939393940');

insert into motorista values('Anibal Silva','L-125','1978-01-14','1236');
insert into telefone values('1236','266262628');
insert into telefone values('1236','939393941');

insert into motorista values('Francisco Lopes','L-126','1979-01-14','1237');
insert into telefone values('1237','266262629');

insert into motorista values('Samuel Melo','L-520','1997-11-14','2220');
insert into telefone values('2220','962020202');

insert into motorista values('João Dias','L-535','1997-04-14','2550');
insert into telefone values('2550','982200364');


/*clientes*/
insert into cliente values('José Silva','Rua António Silva 23','7100-434 Évora',
'600700800900');

insert into cliente values('Francisco Passos','Rua Manuel Passos 12','7000-131 Évora',
'600700800901');

insert into cliente values('Pedro Sousa','Rua Joaquim Sousa 21','7500-313 Évora',
'600700800902');

insert into cliente values('Eduardo Romão','Rua Maria Leal 12','7000-120 Évora',
'600700800903');

/*pedidos*/
insert into pedido values('600700800900','Rua Silva Pais 33','7120-212 Évora','2016-01-02 
09:00:00','19-AA-22','2016-01-02 09:43:00');

insert into pedido values('600700800900','Rua Silva Pais 33','7120-212 Évora','2016-01-02 
15:00:00','13-QE-89','2016-01-02 15:43:00');

insert into pedido values('600700800903','Rua Paraiso 25','1222-232 Évora','2016-01-03 
09:00:00','13-QE-89','2016-01-02 09:43:00');

/*turnos*/
insert into turno values('2016-01-02 08:00:00','2016-01-02 17:00:00','79744','79944',
'19-AA-22','1234');

insert into turno values('2016-01-02 08:00:00','2016-01-02 17:00:00','89764','89964',
'20-AA-22','1235');

insert into turno values('2016-01-03 08:00:00','2016-01-03 17:00:00','234554','234954',
'21-AA-22','1236');

insert into turno values('2016-01-03 08:00:00','2016-01-03 17:00:00','123098','123498',
'19-AA-22','1237');

insert into turno values('2016-01-02 07:00:00','2016-01-02 17:00:00','98756','99280',
'13-QE-89','2220');

insert into turno values('2016-01-02 09:00:00','2016-01-02 18:00:00','50000','50256',
'25-XX-15','2550');

/*serviços*/
insert into servico values('2016-01-02 08:12:00','2016-01-02 08:32:00','12','5.25',
'19-AA-22','0.75','0.76');

insert into servico values('2016-01-02 08:43:00','2016-01-02 08:52:00','7','3.25',
'19-AA-22','0.76','0.77');

insert into servico values('2016-01-02 08:53:00','2016-01-02 09:59:00','98','53.25',
'19-AA-22','0.78','1.56');

insert into servico values('2016-01-02 10:13:00','2016-01-02 10:29:00','18','19.25',
'19-AA-22','2.30','2.36');

insert into servico values('2016-01-02 11:10:00','2016-01-02 11:39:00','23','22.25',
'19-AA-22','3.00','3.43');

insert into servico values('2016-01-02 12:00:00','2016-01-02 13:39:00','21','42.25',
'19-AA-22','3.45','2.65');

insert into servico values('2016-01-02 15:20:00','2016-01-02 15:39:00','9','12.25',
'19-AA-22','2.06','1.96');

insert into servico values('2016-01-02 09:43:00','2016-01-02 10:39:00','12','16.25',
'13-QE-89','6.06','5.96');

insert into servico values('2016-01-02 11:03:00','2016-01-02 11:59:00','10','14.25',
'13-QE-89','5.56','5.16');

insert into servico values('2016-01-02 15:43:00','2016-01-02 16:59:00','20','34.25',
'13-QE-89','5.56','5.16');

insert into servico values('2016-01-02 09:43:00','2016-01-02 10:39:00','18','23.25',
'25-XX-15','7.06','5.42');

insert into servico values('2016-01-02 15:43:00','2016-01-02 16:02:00','10','13.25',
'25-XX-15','6.06','5.42');