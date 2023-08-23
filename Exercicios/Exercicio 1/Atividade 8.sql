WITH base AS (
	SELECT 
		e.emp_id,
		e.dep_id,
		e.supervisor_id,
		e.nome,
		e.salario,
		d.dep_id AS id_departamento,
		d.nome AS nome_departamento,
		AVG(e.salario) OVER(PARTITION BY d.dep_id) AS media_departamento
	FROM
		dojo.public.empregados AS e
	INNER JOIN dojo.public.departamentos AS d ON
		e.dep_id = d.dep_id
)

SELECT 	
	nome,
	salario
FROM
	base 
WHERE 
	salario > media_departamento;