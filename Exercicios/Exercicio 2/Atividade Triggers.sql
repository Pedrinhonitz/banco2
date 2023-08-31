-- Questão 1

CREATE TABLE governance_salary (
	uid TEXT,
	usuario TEXT,
	ts_load TIMESTAMPTZ,
	old_salary float,
	new_salary float,
	PRIMARY KEY(uid)
);

CREATE FUNCTION save_governance_salary()
RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO governance_salary (uid, usuario, ts_load, old_salary, new_salary) VALUES (CONCAT(current_user, now())::text, current_user, now(), OLD.salario, NEW.salario);
	
		RETURN NEW;
	END

$$ LANGUAGE plpgsql;

CREATE TRIGGER save_governance_salary_trigger AFTER UPDATE ON empregados
FOR EACH ROW EXECUTE PROCEDURE save_governance_salary();

-- Questão 2
CREATE TABLE governance_dep (
	uid TEXT,
	dep_id INT,
	nome TEXT,
	usuario TEXT,
	ts_load TIMESTAMPTZ,
	PRIMARY KEY(uid)
);

CREATE FUNCTION governance_dep_insert()
RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO governance_dep (uid, dep_id, nome, usuario, ts_load) VALUES (CONCAT(NEW.dep_id, NOW())::TEXT, NEW.dep_id, NEW.nome, current_user, NOW());
		RETURN NEW;
	END
	
$$ LANGUAGE plpgsql

CREATE TRIGGER governance_dep_insert_trigger AFTER UPDATE ON departamentos 
FOR EACH ROW EXECUTE PROCEDURE governance_dep_insert();

-- Questão 3
CREATE FUNCTION not_insert_salary_supervisor()
RETURNS TRIGGER AS $$
	DECLARE
		chefe int;
	BEGIN
		SELECT DISTINCT e_.salario INTO chefe FROM empregados AS e INNER JOIN empregados AS e_ ON e.supervisor_id = e_.emp_id WHERE e_.emp_id = NEW.supervisor_id;
	
		IF NEW.salario > chefe THEN
	        RAISE EXCEPTION 'Nao pode inserir/atualizar um empregado com salario maior que seu supervisor';
	    END IF;
	
		RETURN NEW;
	END
$$ LANGUAGE plpgsql;

CREATE TRIGGER not_insert_salary_supervisor_trigger BEFORE INSERT OR UPDATE  ON empregados
FOR EACH ROW EXECUTE FUNCTION not_insert_salary_supervisor();

-- Questão 4

ALTER TABLE departamentos ADD COLUMN total_cost float;

CREATE or REPLACE FUNCTION atualiza_custo_total()
    RETURNS trigger
AS $$
declare
    soma_departamento float;
BEGIN

    SELECT sum(salario)::float INTO soma_departamento from empregados where dep_id = new.dep_id group by dep_id;
   
    update departamentos set total_cost = soma_departamento where dep_id = new.dep_id;
    return new;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER atualiza_custo_total_trigger
    AFTER INSERT OR UPDATE ON empregados
    FOR EACH ROW
EXECUTE PROCEDURE atualiza_custo_total();






