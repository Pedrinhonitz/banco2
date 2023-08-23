WITH maior_salario AS (
    SELECT
        d.dep_id,
        MAX(e.salario) AS maior_salario
    FROM
        dojo.public.empregados AS e
    INNER JOIN dojo.public.departamentos AS d ON
        e.dep_id = d.dep_id 
    GROUP BY
        1
    ORDER BY   
        1
    DESC
)

SELECT
    ms.dep_id,
    e.nome, 
    ms.maior_salario
FROM
    dojo.public.empregados AS e
INNER JOIN maior_salario AS ms ON   
    e.dep_id = ms.dep_id
    AND e.salario = ms.maior_salario;