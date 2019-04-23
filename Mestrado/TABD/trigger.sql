CREATE TRIGGER check_ISBN
	BEFORE INSERT ON livros
	FOR EACH ROW
	EXECUTE PROCEDURE check_livros_ISBN();

CREATE FUNCTION check_livros_ISBN() RETURNS trigger AS $livro_ISBN$
	BEGIN
		IF NEW.ISBN = '[1-8]{1}[1-9]{12}' THEN
			RAISE EXCEPTION '% ISBN does not start with the number 9', NEW.titulo;
		END IF;
	END;
$livro_ISBN$ LANGUAGE plpgsql;

CREATE TRIGGER check_name
	BEFORE INSERT ON autores
	FOR EACH ROW
	EXECUTE PROCEDURE check_author_name();

CREATE OR REPLACE FUNCTION check_author_name() 
	RETURNS trigger AS $BODY$
	BEGIN
		IF NEW.nome = NEW.apelido THEN
			RAISE EXCEPTION 'First name (%) and last name (%) cannot be the same', NEW.nome, NEW.apelido;
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
