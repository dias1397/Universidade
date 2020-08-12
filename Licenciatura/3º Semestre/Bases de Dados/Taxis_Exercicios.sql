/*EXERCICIOS*/
/*a*/
select Matricula 
	from modelo natural inner join taxi
	where Marca='Mercedes';

/*b*/
select motorista.Nome 
	from modelo natural inner join taxi natural inner join turno natural inner join motorista
	where Marca='Mercedes';

/*c*/
select Telefone
	from pedido, turno natural inner join motorista natural inner join telefone
	where Nif='600700800900' and pedido.Matricula = turno.Matricula and
		pedido.DataInicio>=turno.DataInicio and 
		pedido.DataInicio<=turno.DataFim;

/*d*/
select Marca,Modelo
	from motorista natural inner join turno natural inner join taxi natural inner join modelo
	where Nome='Anibal Silva';

/*e*/
(select Nome from motorista)
except
(select motorista.Nome 
	from cliente natural inner join pedido,turno natural inner join motorista
	where cliente.Nome = 'José Silva'and pedido.Matricula = turno.Matricula and
		pedido.DataInicio>=turno.DataInicio and 
		pedido.DataInicio<=turno.DataFim);

/*f*/
(select Nome from motorista)
except
(select motorista.Nome 
	from modelo natural inner join taxi natural inner join turno natural inner join motorista
	where Marca='Mercedes');

/*g*/
select Nome
	from motorista natural inner join turno natural inner join taxi
	where Matricula = all (select Matricula 
		from taxi);

/*h*/
select motorista.Nome, count(*)
	from motorista natural inner join turno, servico
	where turno.DataInicio<=servico.DataInicio and
		turno.DataFim>=servico.DataInicio and
		turno.Matricula = servico.Matricula
	group by motorista.Nome;

/*i*/
select motorista.Nome, sum(valor)
	from motorista natural inner join turno, servico
	where turno.DataInicio<=servico.DataInicio and
		turno.DataFim>=servico.DataInicio and
		turno.Matricula = servico.Matricula
	group by motorista.Nome;

/*j*/
select Nome 
	from (select motorista.Nome, sum(valor) as Soma
		from motorista natural inner join turno, 
		servico
		where turno.DataInicio<=servico.DataInicio and
		turno.DataFim>=servico.DataInicio and
		turno.Matricula = servico.Matricula
		group by motorista.Nome) as tabela1,

	      (select max(tabela2.Soma) as Soma2
		from (select motorista.Nome, sum(valor) as Soma
			from motorista natural inner join turno, 
				servico
			where turno.DataInicio<=servico.DataInicio and
				turno.DataFim>=servico.DataInicio and
				turno.Matricula = servico.Matricula
			group by motorista.Nome) as tabela2) as tabela3
	where tabela1.Soma=tabela3.Soma2;

/*k*/
select taxi.Matricula, Marca, taxi.Modelo
	from (select Matricula, KmsFim-KmsInicio as Dif
		from turno) as tabela1, 
	     (select max(tabela2.Dif) as Max
		from (select Matricula, KmsFim-KmsInicio as Dif
			from turno) as tabela2) as tabela3, 
	     modelo, taxi 
	where taxi.Matricula=tabela1.Matricula and 
		taxi.modelo=modelo.Modelo and tabela1.Dif = tabela3.Max;

/*l*/
select avg(cast(DataInicio as time)-cast(DataPedido as time))
	from pedido;
	
/*m*/
select nome
	from (select nome, count(nif) as N
		from cliente natural inner join pedido
		group by nome) as tabela1,

		(select max(tabela2.N) as H
		from (select nome, count(nif) as N
			from cliente natural inner join pedido
			group by nome) as tabela2) as tabela3
	where tabela1.N = tabela3.H;

/*n*/
select BigPart.Matricula, Marca, Modelo
from	
	(select matricula, (tabela2.dinheiro / sum(kmsfim-kmsinicio)) as NUM
	from turno natural inner join (select 	Matricula, (sum(Valor)-tabela1.combustivel) as dinheiro	
					from  	servico natural inner join (	select taxi.Matricula, ((sum(kmsfim - kmsinicio)*consumo/100)*1.22) as combustivel
									from turno natural inner join modelo natural inner join taxi
									group by taxi.Matricula,consumo) as tabela1
					group by Matricula, tabela1.combustivel) as tabela2
	group by matricula, tabela2.dinheiro) as BigPart,

	(select max(BigPart2.NUM) as MAX from (select matricula, (tabela2.dinheiro / sum(kmsfim-kmsinicio))as NUM
	from turno natural inner join (select 	Matricula, (sum(Valor)-tabela1.combustivel) as dinheiro	
					from  	servico natural inner join (select taxi.Matricula, ((sum(kmsfim - kmsinicio)*consumo/100)*1.22) as combustivel
										from turno natural inner join modelo natural inner join taxi
										group by taxi.Matricula,consumo) as tabela1
					group by Matricula, tabela1.combustivel) as tabela2
	group by matricula, tabela2.dinheiro) as BigPart2) as BigPart3, taxi natural inner join modelo
where	BigPart.NUM = BigPart3.MAX and taxi.Matricula = BigPart.Matricula;

/*o*/
select nome, KmsFim-KmsInicio-sum(Kms)
	from servico, turno natural inner join motorista
	where servico.datainicio>turno.datainicio and servico.datafim<turno.datafim and servico.matricula=turno.matricula
	group by nome, KmsFim, KmsInicio;

/*p*/
select nome
	from 
		(select nome, ((cast(servico.DataFim as time)-cast(servico.DataInicio as time))/Kms) as KM
			from servico, turno natural inner join motorista
			where servico.datainicio>turno.datainicio and servico.datafim<turno.datafim and servico.matricula=turno.matricula
		group by nome, Kms, servico.DataFim, servico.DataInicio) as tabela1,

		(select min(tabela2.KM) as MIN 
			from (select nome, ((cast(servico.DataFim as time)-cast(servico.DataInicio as time))/Kms) as KM
				from servico, turno natural inner join motorista
				where servico.datainicio>turno.datainicio and servico.datafim<turno.datafim and servico.matricula=turno.matricula
				group by nome, Kms, servico.DataFim, servico.DataInicio) as tabela2) as tabela3

	where tabela1.KM=tabela3.MIN;
			
