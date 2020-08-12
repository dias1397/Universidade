CREATE ROLE "Agência";

GRANT SELECT, 
		INSERT("Nome da Agencia", "Codigo da Agencia"), 
		UPDATE("Nome da Agencia", "Codigo da Agencia") 
		ON "Instituicao" TO "Agência";
CREATE VIEW "Agencias" AS SELECT "Codigo da Instituicao","Nome da Agencia", "Codigo da Agencia" from "Instituicao";
GRANT SELECT ON "Agencias" TO "Agência";


CREATE ROLE "Secretaria da Instituicao";

GRANT SELECT, UPDATE("Url da Instituicao", "Url do Precario", "Numero de Campus") 
		ON "Instituicao" TO "Secretaria da Instituicao";
CREATE VIEW "Escolas" AS SELECT * FROM "Escola";
GRANT SELECT ON "Escolas" TO "Secretaria da Instituicao";


CREATE ROLE "Departamento de Financas";

GRANT INSERT("Ajuda Financeira", "Valor PRopinas Recebidas", "Propinas de Alunos Internos", "Propinas de Alunos Externos",
		"Despesas da Escola", "Media Salarial", "Media de Custo para Estudante", "Media de Custo por Curso", "Media de Rendimentos Baixos",
		"Media de Rendimentos Medios", "Media de Rendimento Alto", "Candidaturas a Apoio Escolar")
		ON "Escola" TO "Departamento de Financas";
GRANT DELETE("Valor PRopinas Recebidas", "Propinas de Alunos Internos", "Propinas de Alunos Externos",
		"Despesas da Escola", "Media Salarial", "Media de Custo para Estudante", "Media de Custo por Curso", "Media de Rendimentos Baixos",
		"Media de Rendimentos Medios", "Media de Rendimento Alto", "Candidaturas a Apoio Escolar")
		ON "Escola" TO "Departamento de Financas";
GRANT UPDATE("Ajuda Financeira", "Valor PRopinas Recebidas", "Propinas de Alunos Internos", "Propinas de Alunos Externos",
		"Despesas da Escola", "Media Salarial", "Media de Custo para Estudante", "Media de Custo por Curso", "Media de Rendimentos Baixos",
		"Media de Rendimentos Medios", "Media de Rendimento Alto", "Candidaturas a Apoio Escolar")
		ON "Escola" TO "Departamento de Financas";

CREATE VIEW "Ver Escolas" AS SELECT * from "Escola";
GRANT SELECT ON "Ver Escolas" TO "Departamento de Financas";


GRANT INSERT("Taxa de Pobreza")
		ON "Estudantes" TO "Departamento de Financas";
GRANT DELETE("Taxa de Pobreza")
		ON "Estudantes" TO "Departamento de Financas";
GRANT UPDATE("Taxa de Pobreza")
		ON "Estudantes" TO "Departamento de Financas";

