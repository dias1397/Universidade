CREATE TABLE relacoes_amigos (
    ID_PERFIL1 NUMERIC(10) NOT NULL,
    ID_PERFIL2 NUMERIC(10) NOT NULL,
    PRIMARY KEY (ID_PERFIL1, ID_PERFIL2),
    FOREIGN KEY (ID_PERFIL1) REFERENCES membro(ID_PERFIL),
    FOREIGN KEY (ID_PERFIL2) REFERENCES membro(ID_PERFIL)    
);

CREATE OR REPLACE FUNCTION update_3away_friend()
    RETURNS trigger AS $BODY$
    DECLARE
    		cont int;
    BEGIN
        	-- Percorrer todas as relações de amizade de terceiro grau
        	FOR r IN SELECT A.ID_PERFIL1 , C.ID_PERFIL2
        		FROM amigos AS A
        			INNER JOIN amigos AS B ON A.ID_PERFIL2 = B.ID_PERFIL1 AND A.ID_PERFIL1 != B.ID_PERFIL2
        			INNER JOIN amigos AS C ON B.ID_PERFIL2 = C.ID_PERFIL1 AND B.ID_PERFIL1 != C.ID_PERFIL2
        		WHERE A.ID_PERFIL1 != C.ID_PERFIL2;

            LOOP
            	-- verificar se a relação de 3grau é de 1grau tambem
            	SELECT count() INTO count 
            		FROM amigos
            		WHERE r.ID_PERFIL1 = ID_PERFIL1 AND r.ID_PERFIL2 = ID_PERFIL2
            	-- caso não seja insere na tabela de relacoes de 3 grau
            	IF (count = 0) {
            		INSERT INTO relacoes_amigos(ID_PERFIL1, ID_PERFIL2)
                    	VALUES(r.ID_PERFIL1, r.ID_PERFIL2);
            	}
            	END IF;
            END LOOP;

        RETURN NEW;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER upd_3_friend
    AFTER INSERT OR DELETE ON amigos
    FOR EACH ROW EXECUTE PROCEDURE update_3away_friend();