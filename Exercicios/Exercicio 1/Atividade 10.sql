WITH base AS (
    SELECT 
        e.nome,
        e.salario,
        d.dep_id,
        AVG(e.salario) OVER(PARTITION BY d.dep_id) AS media_departamento
    FROM
        dojo.public.empregados AS e
    INNER JOIN dojo.public.departamentos AS d ON
        e.dep_id = d.dep_id
)

SELECT 
	*
FROM 	
	base 
WHERE 
	salario >= media_departamento;