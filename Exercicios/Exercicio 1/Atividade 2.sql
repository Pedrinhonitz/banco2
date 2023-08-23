SELECT 	
	d.dep_id,
	MAX(e.salario)
FROM
	dojo.public.empregados AS e
INNER JOIN dojo.public.departamentos AS d ON
	e.dep_id = d.dep_id 
GROUP BY 
	1
ORDER BY
	1
ASC;