/*a)

select distinct(Local_habitat)
from classificacao natural inner join animais
where Classe='Aves';
*/

/*b)
(select Local_habitat
from habitat)
except
(select distinct(Local_habitat)
from classificacao natural inner join animais
where Ordem='Carnivoros');
*/

/*c)
(select distinct(Registo)
from (	select Registo_mae, Registo_pai
	from cativeiro natural inner join animais
	where Nome='Kilu') as tab1, cativeiro
where cativeiro.Registo_mae=tab1.Registo_mae or cativeiro.Registo_pai=tab1.Registo_pai)
except
(select Registo
from animais
where Nome='Kilu');
*/


/*d)
select Telefone
from animais natural inner join tratador,
	funcionario natural inner join funcionario_telefone
where tratador.Nif=funcionario.Nif and animais.Nome='Kata';
*/

/*e)
select telefone
from funcionario_telefone
where funcionario_telefone.nif = (select responsavel
		from animais natural inner join habitat natural inner join funcionario_responsavel
		where animais.nome='Kata' and animais.nif = funcionario_responsavel.nif);
*/


/*f)
select tratamento.data_hora, tratamento_O
from animais ,consulta natural inner join tratamento
where animais.Registo = consulta.Registo and animais.Nome='Mali';
*/

/*g)
select funcionario.Nome
from classificacao natural inner join animais, consulta natural inner join diagnostico natural inner join veternario, funcionario
where animais.Registo = consulta.Registo and Diagnostico_O='Grávida' and ordem='Carnivoros' and veternario.Nif=funcionario.Nif;;*/

/*h)
select familia, count(Registo)
from classificacao natural inner join animais
where ordem='Artiodáctilos'
group by familia;
*/

/*i)
(select A.Nome, B.Nome
from animais as A, animais as B natural inner join cativeiro as C
where	A.Registo!=B.Registo and A.Especie=B.Especie and A.Registo!=C.Registo_mae and
	A.Registo!=C.Registo_pai and A.Sexo!=B.Sexo)
union
(select A.Nome, B.Nome
from animais as A, animais as B
where	A.Registo!=B.Registo and A.Especie=B.Especie and A.Sexo!=B.Sexo) ;*/

/*j)
select Ordem
from (select Ordem, count(Registo) as N
	from classificacao natural inner join animais
	group by Ordem) as tab1,
	
     (select max(tab2.N) as M
	from (select Ordem, count(Registo) as N
		from classificacao natural inner join animais
		group by Ordem) as tab2)as tab3
where tab1.N = tab3.M;*/

/*k)
select Ordem
from (select Ordem, count(Data_hora) as N
	from classificacao natural inner join animais, consulta
	where animais.Registo = consulta.Registo
	group by Ordem) as tab
where tab.N>5;
*/

/*l)
select count(Data_nascimento)
from cativeiro;
*/

/*m)
select Nome, Especie
from((select Registo, extract(year from Data_nascimento)
	from cativeiro)
		union
	(select Registo, extract(year from Data_nascimento)
	from capturado)) as tab,
	(select min(B.date_part) as Q
		from ((select Registo, extract(year from Data_nascimento)
			from cativeiro)
			union
			(select Registo, extract(year from Data_nascimento)
			from capturado)) as B) as tab2, animais 
			natural inner join classificacao
where tab.date_part=tab2.Q and animais.Registo=tab.Registo;
*/


/*n)
select Local_habitat
from(select Local_habitat, count(Registo) as C
	from habitat natural inner join animais natural inner join classificacao
	where Atmosfera='Quente e húmida' and classificacao.classe = 'Mamiferos'
	group by Local_habitat) as tab,
	
	(select max(tab2.C) as M
	from(select Local_habitat, count(Registo) as C
		from habitat natural inner join animais natural inner join classificacao
		where Atmosfera='Quente e húmida' and classificacao.classe = 'Mamiferos'
		group by Local_habitat) as tab2)as tab3
where tab.C=tab3.M;
*/

/*o)
select funcionario.Nome, count(Registo)
from classificacao natural inner join animais natural inner join tratador, funcionario
where Classe='Mamiferos' and tratador.Nif=funcionario.Nif
group by funcionario.Nome;
*/

/*p)
select Nome
from (select count(Nif) as C 
	from veternario) as tab,
	(select consulta.Registo, count(distinct(consulta.Nif)) as N
	from animais, consulta
	where animais.Registo = consulta.Registo
	group by consulta.Registo) as tab2, animais
where tab.C=tab2.N and animais.Registo=tab2.Registo;
*/