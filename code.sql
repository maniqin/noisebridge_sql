SELECT * FROM table_name;

SELECT  
		 column_name_1
		,column_name_2
		,column_name_3
	FROM table_name;

SELECT 
		 column_1
		,column_2 
	FROM table_name
	LIMIT 100;

-- 	Comments in SQL
-- This query does so and so
	SELECT column_1,
			column_2 
		FROM table_name -- this is an inline comment
		/*
		You will need multi-line comment
		At some 
		Believe me
		*/
		LIMIT 100;



SELECT * FROM employees
LIMIT 1;
