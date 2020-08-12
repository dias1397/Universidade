drop schema public cascade;
create schema public;

create table funcionario(
	Nif varchar not null,
 	Nome varchar not null,
 	dataF date,
 	primary key(Nif) 
);

create table funcionario_telefone(
 	Nif varchar not null,
 	Telefone char(9),
 	primary key(Nif, Telefone),
 	foreign key(Nif) references funcionario(Nif) on  delete restrict
);

create table funcionario_responsavel(
 	Nif varchar not null,
 	Responsavel varchar not null,
 	primary key(Nif, Responsavel),
 	foreign key(Nif) references funcionario(Nif) on delete restrict,
 	foreign key(Responsavel) references funcionario(Nif) on delete restrict
);

create table administrativo(
	Nif varchar not null,
	primary key(Nif),
	foreign key(Nif) references funcionario(Nif) on delete restrict
);

create table tratador(
 	Nif varchar not null,
 	primary key(Nif),
 	foreign key(Nif) references funcionario(Nif) on delete restrict
);

create table auxiliar(
 	Nif varchar not null,
 	primary key(Nif),
 	foreign key(Nif) references funcionario(Nif) on delete restrict
);

create table veternario(
 	Nif varchar not null,
 	primary key(Nif),
 	foreign key(Nif) references funcionario(Nif) on delete restrict
);

create table classificacao(
	Especie varchar not null,
	Familia varchar not null,
	Ordem varchar not null,
	Classe varchar not null,
	primary key(Especie)

);

create table habitat(
	Local_habitat varchar not null,
	Atmosfera varchar not null,
	Area varchar not null,
	primary key(Local_habitat)
);

create table animais( 
 	Registo varchar not null,
 	Nome varchar not null,
 	Sexo char(1),
	Nif varchar not null,
	Especie varchar not null,
	Local_habitat varchar not null,
 	primary key(Registo),
	foreign key(Nif) references funcionario(Nif) on delete restrict,
	foreign key(Especie) references classificacao(Especie) on delete restrict,
	foreign key(Local_habitat) references habitat(Local_habitat) on delete restrict
);

create table consulta(
	Nif varchar not null,
	Data_hora timestamp, 
	Local_consulta varchar not null,
 	Registo varchar not null,
	primary key(Data_hora, Local_consulta),
	foreign key(Nif) references funcionario(Nif) on delete restrict,
	foreign key(Registo) references animais(Registo) on delete restrict
);



create table cativeiro(
 	Registo varchar not null,
 	Data_nascimento date,
	Registo_mae varchar not null,
	Registo_pai varchar not null,
 	primary key(Registo),
 	foreign key(Registo) references animais(Registo) on delete restrict,
 	foreign key(Registo_mae) references animais(Registo) on delete restrict,
 	foreign key(Registo_pai) references animais(Registo) on delete restrict
);


create table capturado(
	Registo varchar not null,
	Local_captura varchar not null,
	Data_nascimento date,
	Data_Captura date,
	primary key(Registo),
	foreign key(Registo) references animais(Registo) on delete restrict
);



create table auxiliar_habitat(
	Local_habitat varchar not null,
	Nif varchar not null,
	primary key(Local_habitat, Nif),
	foreign key(Local_habitat) references habitat(Local_habitat) on delete restrict,
	foreign key(Nif) references funcionario(Nif) on delete restrict
);

create table tratamento(
	Nif varchar not null,
	Data_hora timestamp,
	Local_consulta varchar not null,
	Tratamento_O varchar not null,
	primary key(Data_hora,Local_consulta),
	foreign key(Nif) references funcionario(Nif) on delete restrict,
	foreign key(Data_hora,Local_Consulta) references consulta on delete restrict
);

create table diagnostico(
	Nif varchar not null,
	Data_hora timestamp,
	Local_consulta varchar not null,
	Diagnostico_O varchar not null,
	primary key(Data_hora,Local_consulta),
	foreign key(Nif) references funcionario(Nif) on delete restrict,
	foreign key(Data_hora,Local_Consulta) references consulta on delete restrict
);
