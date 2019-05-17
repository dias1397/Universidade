CREATE TRIGGER check_ISBN
	BEFORE INSERT ON livros
	FOR EACH ROW
	EXECUTE PROCEDURE check_livros_ISBN();

CREATE OR REPLACE FUNCTION check_livros_ISBN() 
	RETURNS trigger AS $livro_ISBN$
	BEGIN
		

		RETURN NEW;
	END;
$livro_ISBN$ LANGUAGE plpgsql;

CREATE TRIGGER book_integrity
	BEFORE INSERT OR UPDATE ON livros
	FOR EACH ROW
	EXECUTE PROCEDURE check_book_integrity();

CREATE OR REPLACE FUNCTION check_book_integrity() 
	RETURNS trigger AS $livro_ISBN$
	BEGIN
		IF NEW.ISBN > 10000000000000 THEN
			RAISE EXCEPTION 'ISBN (%) contem mais de 13 digitos.', NEW.titulo;
		END IF;
		IF NEW.ISBN < 999999999999 THEN
			RAISE EXCEPTION 'ISBN (%) contem menos de 13 digitos.', NEW.titulo;
		END IF;
		IF NEW.ISBN < 8999999999999 THEN
			RAISE EXCEPTION 'ISBN (%) não começa pelo digito 9.', NEW.titulo;
		END IF;

		IF NEW.idioma != 'portugues' AND 
			NEW.idioma != 'português' AND 
			NEW.idioma != 'ingles' AND 
			NEW.idioma != 'inglês' THEN
			RAISE EXCEPTION '% é uma linguaguem inválida.', NEW.idioma;
		END IF;

		IF NEW.data_compra < NEW.data_lancamento THEN
			RAISE EXCEPTION 'Data de compra não pode ser mais recente que a de lançamento.';
		END IF;

		RETURN NEW;
	END;
$livro_ISBN$ LANGUAGE plpgsql;

CREATE TRIGGER author_integrity
	BEFORE INSERT OR UPDATE ON autores
	FOR EACH ROW
	EXECUTE PROCEDURE check_author_integrity();

CREATE OR REPLACE FUNCTION check_author_integrity() 
	RETURNS trigger AS $BODY$
	BEGIN
		IF NEW.nome = NEW.apelido THEN
			RAISE EXCEPTION 'Primeiro nome e apelido não podem ser iguais.';
		END IF;
		IF NEW.data_nascimento > now() THEN
			RAISE EXCEPTION 'Data de nascimento % não pode ser no futuro.', NEW.data_nascimento;
		END IF;
		IF NEW.sexo != 'M' AND NEW.sexo != 'm' AND
			NEW.sexo != 'F' AND NEW.sexo != 'f' THEN
			RAISE EXCEPTION '% não é um sexo válido.', NEW.sexo;
		END IF;

		RETURN NEW;
	END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addTag(
	IN identifier VARCHAR(50)) 
RETURNS INTEGER  
AS $$
DECLARE
	count INTEGER DEFAULT 0;
BEGIN
    UPDATE identificadore
    SET etiqueta = identidier;

    GET DIAGNOSTICS count = ROW_COUNT;
    RETURN count;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addBook(
	IN isbn NUMERIC,
	IN titulo VARCHAR(50),
	IN edicao INTEGER,
	IN idioma VARCHAR(30),
	IN lancamento DATE,
	IN aquisicao DATE)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO livros VALUES(isbn, titulo, edicao, idioma, lancamento, aquisicao);
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION addAuthor(
	IN nome VARCHAR(50),
	IN apelido VARCHAR(50),
	IN sexo VARCHAR(1),
	IN nascimento DATE)
RETURNS VOID
AS $$
BEGIN
	INSERT INTO autores VALUES(nome, apelido, sexo, nascimento);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addAuthorOfBook(
	IN isbn NUMERIC,
	IN nome VARCHAR(50),
	IN apelido VARCHAR(50))
RETURNS VOID
AS $$
BEGIN
	INSERT INTO livros_autores VALUES(isbn, nome, apelido);
END;
$$
LANGUAGE plpgsql;