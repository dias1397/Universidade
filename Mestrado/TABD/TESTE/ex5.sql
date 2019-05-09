CREATE OR REPLACE FUNCTION addActivity(
    _id_user integer, _atividade string, _data_inicio date, _data_fim date, _empresa string, _pais string)
    RETURNS void AS
    $BODY$
    	DECLARE
    		-- variavel que ve se existe já uma atividade criada na tabela das atividades
    		nr_ativ int;
        BEGIN
        	SELECT count() into nr_ativ
        		FROM atv_profissional
        		WHERE DATA_INI = _data_inicio AND
        			DATA_FIM = _data_fim AND
        			ATIVIDADE = _atividade AND
        			EMPRESA = _empresa AND
        			PAIS = _pais;

        	IF (nr_ativ = 0) THEN
        		INSERT INTO atv_profissional(DATA_INI, DATA_FIM, ATIVIDADE, EMPRESAS, PAIS)
        			VALUES(_data_inicio, _data_fim, _atividade, _empresa, _pais);
        	END IF;

        	-- ao inserir um tuplo nesta tabela o trigger criado no exercicio 3 vai ser despoletado
        	-- este trigger irá atualizar a tabela ex-colegas e garante a integridade da mesma
            INSERT INTO membro_ativi(ID_PERFIL, ATIVIDADE, DATA_INI, DATA_FIM)
            	VALUES(_id_user, _atividade, _data_inicio, _data_fim);
            --
        END;
    $BODY$
    LANGUAGE plpgsql;