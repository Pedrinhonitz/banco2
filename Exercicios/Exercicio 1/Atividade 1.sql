SELECT 
	e.nome
FROM
	dojo.public.empregados AS e
INNER JOIN dojo.public.empregados AS e_ ON
	e.supervisor_id = e_.emp_id 
WHERE 
	e.salario > e_.salario;