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


SELECT * 
FROM employees
LIMIT 1;


SELECT * 
FROM table_name;


SELECT  column_name_1,
		column_name_2,
		column_name_3
	FROM table;


SELECT column_1,
		column_2 
	FROM table_name
	LIMIT 100;


SELECT column_1,
				column_2 
			FROM table_name -- this is an inline comment
			/*
			You will need multi-line comment
			At some 
			Believe me
			*/
			LIMIT 100;


SELECT column_name_1 as cl_1,
		column_name_2 as cl_2
		-- notice the alias "as alias_name"
		-- for both columns and table name
	FROM table_name as tb
	LIMIT 10;


SELECT name as file_type
	FROM media_types as md
	LIMIT 10;


SELECT name file_type
	FROM media_types md
	LIMIT 10;


SELECT * FROM employees
	ORDER BY last_name ASC;


SELECT genre_id, name -- These happen to be all the columns present in the table "genres"
	FROM genres
 ORDER BY name ASC -- or DESC, ORDER BY defaults to ASC
 ;


SELECT GenreId, Name
			FROM genres
		 ORDER BY 2 ASC
		 -- 2 here means the second column
		--  (in the order written after the SELECT)
 ;


SELECT Composer, Name, Milliseconds
	FROM tracks
	ORDER BY Composer DESC, Name;


SELECT Composer, Name, Milliseconds
	FROM tracks
	ORDER BY 1 DESC, 2;


SELECT Composer, Name, Milliseconds
		 FROM tracks
		 ORDER BY 3 Desc;


SELECT id, my_str_column 
	FROM table_name
	WHERE my_str_column = 'some_string'
		-- here we're assuming that the field my_str_column is a string (varchar())
;


SELECT id, my_num_column
	FROM table_name
	WHERE my_num_column = 23
		-- here we're assuming that my_num_column is an integer or a float
;

SELECT id, my_num_column
	FROM table_name
	WHERE my_num_column = 23
		-- here we're assuming that my_num_column is an integer or a float
;


SELECT id, my_col
	FROM table_name
	WHERE my_col IS NULL
			-- for the opposite result use:
			--  WHERE my_col IS NOT NULL 
;


SELECT id
	,my_num_column
	,my_str_column
	FROM table_name
	WHERE my_num_column > 2
	AND my_str_column = 'hello'
;

SELECT id
	,my_num_column
	,my_str_column
	FROM table_name
	WHERE my_num_column > 2
	OR my_str_column = 'hello'
;


SELECT id
		,my_num_column
		,my_str_column
	FROM table_name
	WHERE 
		(my_num_column > 2 AND my_num_column < 6) 
		OR my_str_column = 'hello'
;


SELECT id
	,my_num_column
	,my_str_column
	FROM table_name
	WHERE id IN (1,2,3,4)
;


SELECT first_name,
		last_name
	FROM table_name
	WHERE first_name IN ('Richard', 'Ann', 'Chris')
;


SELECT random()
-- no from because it doesnt really come from a table
;

SELECT col_1,
		col_2
	FROM table_name
ORDER BY RANDOM();


SELECT col_1,
		col_2
	FROM table_name
	ORDER BY RANDOM()
	LIMIT 10;


SELECT
	id,
	num_col,
	CASE WHEN num_col > 10
		THEN 'value is greater than 10'
		ELSE 'value is less than 10'
		END AS ten_check,

	FROM table_name;


SELECT
	col_1
	,col_2
	FROM table_name
	WHERE col_1 LIKE 'search%' -- this will match any string that starts with the word 'search' 
;