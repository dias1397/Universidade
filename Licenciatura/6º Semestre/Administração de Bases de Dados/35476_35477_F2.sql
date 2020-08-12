CREATE BIGFILE TABLESPACE Universidade
    DATAFILE 'universidade.dat'
    SIZE 20M AUTOEXTEND ON;
    
CREATE DATABASE PlacarEscolar
    DEFAULT TEMPORARY TABLESPACE TEMP
    DEFAULT TABLESPACE Universidade;
    
CREATE USER JOAOEDUARDO
    IDENTIFIED BY abd2018
    DEFAULT TABLESPACE Universidade;
    
GRANT dba TO JOAOEDUARDO WITH ADMIN OPTION;

CONNECT JOAOEDUARDO/adb2018

CREATE TABLE "Instituicao" (
	"Codigo da Instituicao" NUMBER(6),
	"Latitude" NUMBER(8,6),
	"Longitude" NUMBER(8,6),
	"Numero de Campus" NUMBER(4),
	"Url da Instituicao" VARCHAR2(100 CHAR),
	"Url do Precario" VARCHAR2(100 CHAR),
	"Codigo da Agencia" VARCHAR2(6 CHAR),
	"Nome da Agencia" VARCHAR2(100 CHAR),
	CONSTRAINT cp_instituicao PRIMARY KEY ("Codigo da Instituicao")
) TABLESPACE Universidade;

CREATE TABLE "Escola" (
	"Codigo da Escola" NUMBER(8),
	"Codigo da Instituicao" NUMBER(6),
	"Nome da Escola" VARCHAR2(100 CHAR),
	"Pseudonimo" VARCHAR2(100 CHAR),
	"Cidade" VARCHAR2(50 CHAR),
	"Modelo de Ensino" VARCHAR2(30 CHAR),
	"Teste de Admissao" CHAR(3),
	"Codigo do Estado" CHAR(3),
	"Escola Principal" CHAR(3),
	"Ensino Domestico" CHAR(3), 
	"Ajuda Financeira" CHAR(3),
	"Em Funcionamento" CHAR(3),
	"Classificacao Basica" NUMBER(2),
	"Classificacao de Estudantes" NUMBER(2),
	"Classificacao de Espacos" NUMBER(2),
	"Valor Propinas Recebidas" NUMBER(7),
	"Propinas de Alunos Internos" NUMBER(6),
	"Propinas de Alunos Externos" NUMBER(6),
	"Despesas da Escola" NUMBER(9),
	"Media Salarial" NUMBER(7),
	"Media de Custo para Estudantes" NUMBER(7),
	"Media de Custo por Curso" NUMBER(7),
	"Media Rendimentos Baixos" NUMBER(5),
	"Media Rendimentos Media" NUMBER(5),
	"Media Rendimentos Alto" NUMBER(7),
	"Candidaturas a Apoio Escolar" NUMBER(6),
	"Estudantes Femininos" NUMBER(4,3),
	"Estudantes Masculinos" NUMBER(4,3),
	"Estudantes Dependentes" NUMBER(4,3),
	"Estudantes Veteranos" NUMBER(4,3),
	"Estudantes Primeira Geracao" NUMBER(4,3),
	CONSTRAINT cp_escola PRIMARY KEY ("Codigo da Escola"),
    CONSTRAINT ce_instituicao FOREIGN KEY("Codigo da Instituicao") REFERENCES "Instituicao"("Codigo da Instituicao")
) TABLESPACE Universidade;

CREATE TABLE "Admissões" (
	"Codigo da Escola" NUMBER(8),
	"Ano" NUMBER(4),
	"Taxa Aceitacao" NUMBER(5,4),
	"Taxa Aceitacao Instituicao" NUMBER(5,4),
	"Media de Entrada" NUMBER(4),
	"Media de Entrada Institucional" NUMBER(4),
	CONSTRAINT cp_admissoes PRIMARY KEY ("Codigo da Escola", "Ano"),
	CONSTRAINT ce_codigo_da_escola1 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola")
) TABLESPACE Universidade;

CREATE TABLE "Graus Academicos Escola" (
	"Codigo da Escola" NUMBER(8),
	"Nivel da Escola" VARCHAR2(20 CHAR),
	"Grau Mais Elevado" VARCHAR2(20 CHAR),
	"Grau Predominante" VARCHAR2(20 CHAR),
	CONSTRAINT cp_graus_academicos_escola PRIMARY KEY ("Codigo da Escola", "Nivel da Escola"),
	CONSTRAINT ce_codigo_da_escola2 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola")
) TABLESPACE Universidade;

CREATE TABLE "Tipos de Cursos" (
	"Tipos Cursos" VARCHAR2(60 CHAR),
	CONSTRAINT cp_tipos_de_cursos PRIMARY KEY ("Tipos Cursos")
) TABLESPACE Universidade;

CREATE TABLE "Cursos na Escola" (
	"Codigo da Escola" NUMBER(8),
	"Curso" VARCHAR2(60 CHAR),
	"Grau do Curso" VARCHAR2(40 CHAR),
	"Graus Concedidos" NUMBER(4,3),
	CONSTRAINT cp_cursos_na_escola PRIMARY KEY ("Codigo da Escola", "Curso"),
	CONSTRAINT ce_codigo_da_escola3 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola"),
	CONSTRAINT ce_curso FOREIGN KEY ("Curso") REFERENCES "Tipos de Cursos"("Tipos Cursos")
) TABLESPACE Universidade;

CREATE TABLE "Estudantes" (
	"Codigo da Escola" NUMBER(8),
	"Numero de Estudantes" NUMBER(6),
	"Estudantes em Part-time" NUMBER(4,3),
	"Estudantes a Tempo Inteiro" NUMBER(4,3),
	"Maiores de 25 Anos" NUMBER(5),
	"Menos de 24 Anos a Entrada" NUMBER(5),
	"Media de Idades" NUMBER(2),
	"Taxa de Pobreza" NUMBER(4,3),
	"Taxa de Veteranos" NUMBER(4,3),
	"Taxa de Primeira Geracao" NUMBER(4,3),
	CONSTRAINT cp_estudantes PRIMARY KEY ("Codigo da Escola", "Numero de Estudantes"),
	CONSTRAINT ce_codigo_da_escola4 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola")
) TABLESPACE Universidade;

CREATE TABLE "Tipo de Minorias" (
	"Tipos Minorias" VARCHAR2(50 CHAR),
	CONSTRAINT cp_tipos_de_minorias PRIMARY KEY ("Tipos Minorias")
) TABLESPACE Universidade;

CREATE TABLE "Minorias nas Escolas" (
	"Codigo da Escola" NUMBER(8),
	"Minoria" VARCHAR2(50 CHAR),
	CONSTRAINT cp_minorias_nas_escolas PRIMARY KEY ("Codigo da Escola", "Minoria"),
	CONSTRAINT ce_codigo_da_escola5 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola"),
	CONSTRAINT ce_minoria FOREIGN KEY ("Minoria") REFERENCES "Tipo de Minorias"("Tipos Minorias")
) TABLESPACE Universidade;

CREATE TABLE "Tipos de Racas" (
	"Tipos Racas" VARCHAR2(40 CHAR),
	CONSTRAINT cp_tipos_de_racas PRIMARY KEY ("Tipos Racas")
) TABLESPACE Universidade;

CREATE TABLE "Racas nas Escolas" (
	"Codigo da Escola" NUMBER(8),
	"Racas" VARCHAR2(40 CHAR),
	CONSTRAINT cp_racas_nas_escolas PRIMARY KEY ("Codigo da Escola", "Racas"),
	CONSTRAINT ce_codigo_da_escola6 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola"),
	CONSTRAINT ce_racas FOREIGN KEY ("Racas") REFERENCES "Tipos de Racas"("Tipos Racas")
) TABLESPACE Universidade;

CREATE TABLE "Receitas de Estudantes" (
	"Codigo da Escola" NUMBER(8),
	"Ano Receitas" NUMBER(4),
	"Vencimentos Antigos Estudantes" NUMBER(12),
	CONSTRAINT cp_receitas_de_estudantes PRIMARY KEY ("Codigo da Escola", "Ano Receitas"),
	CONSTRAINT ce_codigo_da_escola7 FOREIGN KEY ("Codigo da Escola") REFERENCES "Escola"("Codigo da Escola")
) TABLESPACE Universidade;