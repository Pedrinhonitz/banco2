SELECT 
	DISTINCT
	SUM(e.salario) OVER(PARTITION BY d.nome) AS soma,
	d.nome AS nome_departamento
FROM 	
	dojo.public.empregados AS e
INNER JOIN dojo.public.departamentos AS d ON
	e.dep_id = d.dep_id 
ORDER BY 
	1
ASC;