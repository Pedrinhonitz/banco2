SELECT 	
	d.nome,
	COUNT(1) AS quantidade_empregados
FROM
	dojo.public.empregados AS e
INNER JOIN dojo.public.departamentos AS d ON
	e.dep_id = d.dep_id 
GROUP BY 
	1;