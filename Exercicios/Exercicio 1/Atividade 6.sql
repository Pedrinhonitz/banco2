WITH chefes AS (
	SELECT 
		e.emp_id,
		e.dep_id,
		e.supervisor_id,
		e.nome,
		e.salario,
		d.dep_id AS id_departamento,
		d.nome AS nome_departamento
	FROM
		dojo.public.empregados AS e
	INNER JOIN dojo.public.departamentos AS d ON
		e.dep_id = d.dep_id
)

SELECT 
	ch.nome,
	ch.dep_id
FROM
	chefes AS ch
INNER JOIN chefes AS ch_ ON 
	ch.supervisor_id = ch_.emp_id
WHERE 	
	ch.nome_departamento != ch_.nome_departamento;