WITH quantidade_empregados AS (
	SELECT 	
		d.dep_id,
		COUNT(1) AS quantidade_empregados
	FROM 
		dojo.public.empregados AS e
	INNER JOIN dojo.public.departamentos AS d ON 
		e.dep_id = d.dep_id 
	GROUP BY 
		1
)

SELECT 
	d.nome
FROM
	dojo.public.departamentos AS d
INNER JOIN quantidade_empregados AS qe ON 	
	d.dep_id = qe.dep_id 
WHERE 
	qe.quantidade_empregados < 3
ORDER BY 
	1
ASC;