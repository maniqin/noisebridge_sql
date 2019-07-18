SELECT * 
	FROM table_name;

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
SELECT 
	column_1,
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


SELECT 
	column_name_1 as cl_1,
	column_name_2 as cl_2
	-- notice the alias "as alias_name"
	-- for both columns and table name
	FROM table_name as tb
LIMIT 10;


SELECT 
	name as file_type
	FROM media_types as md
LIMIT 10;


SELECT 
	name file_type
	FROM media_types md
LIMIT 10;


SELECT * 
	FROM employees
ORDER BY last_name ASC;


SELECT 
	 genre_id
	,name -- These happen to be all the columns present in the table "genres"
	FROM genres
ORDER BY name ASC -- or DESC, ORDER BY defaults to ASC
;


SELECT 
	genre_id
	,name
FROM genres
ORDER BY 2 ASC
-- 2 here means the second column
--  (in the order written after the SELECT)
;


SELECT composer, name, milliseconds
FROM tracks
ORDER BY Composer DESC, Name;


SELECT composer, name, milliseconds
FROM tracks
ORDER BY 1 DESC, 2;


SELECT composer, name, milliseconds
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

SELECT 
id
,my_num_column
,my_str_column
FROM table_name
WHERE my_num_column > 2
OR my_str_column = 'hello'
;


SELECT 
id
,my_num_column
,my_str_column
FROM table_name
WHERE 
(my_num_column > 2 AND my_num_column < 6) 
OR my_str_column = 'hello'
;


SELECT 
id
,my_num_column
,my_str_column
FROM table_name
WHERE id IN (1,2,3,4)
;


SELECT 
	first_name,
	last_name
	FROM table_name
WHERE first_name IN ('Richard', 'Ann', 'Chris')
;


SELECT random()
-- no from because it doesnt really come from a table
;

SELECT 
	col_1,
	col_2
	FROM table_name
ORDER BY RANDOM();


SELECT 
	col_1,
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


CASE WHEN my_num_col > 2 AND my_varchar_col LIKE '%search%'
THEN 'custom output'
ELSE NULL END AS my_col_name;


CASE 
WHEN num_col > 2
THEN 'output 1'
WHEN other_num_col < 25 OR other_varchar_col = 'exact string'
THEN 'output 2'
WHEN num_col = 10
THEN 'output 3'
ELSE NULL END AS my_col_name




--(looks like more of a switch case, for those of you who are familiar)
CASE field
WHEN condition
THEN 'output_1'
WHEN condition_2 -- on the same field 
THEN 'output_2'
ELSE NULL END AS my_col_name


CASE WHEN field_1 = 'some string'
THEN
CASE WHEN field_2 > 20 
THEN 'output_1'
ELSE NULL END
WHEN field_3 > 100
THEN 'output_2'
ELSE NULL END AS nested_check


CASE WHEN track_id IN (SELECT id FROM tracks WHERE track_duration > 20)
THEN 'output_1'
ELSE NULL END AS in_check



CASE WHEN num_col = (SELECT max(other_num_col) FROM table_name)
THEN 'output_1'
ELSE NULL END AS subquery_check



SELECT 
DISTINCT col_1 
FROM table_name;


SELECT col_1 
FROM table_name 
GROUP BY col_1;


SELECT col_1, col_2
FROM table_name
GROUP BY col_1, col_2					


SELECT average(num_column) 
FROM table_name;
-- this will return the average for the whole column...


--Such as:
SELECT categorical_col, average(num_column)
FROM table_name
GROUP BY categorical_col;


SELECT categorical_col_one
,categorical_col_two
,average(num_column)
FROM table_name
GROUP BY categorical_col_one, categorical_col_two;



SELECT categorical_col_one
,categorical_col_two
,average(num_column)
FROM table_name
WHERE categorical_col_one NOT IN ('value_1', 'value_3')
GROUP BY categorical_col_one, categorical_col_two
ORDER BY categorical_col_two DESC;			



SELECT categorical_col_one
,categorical_col_two
,average(num_column)
FROM table_name
GROUP BY 1,2
ORDER BY 3 ASC;



SELECT id, first_name, last_name
FROM table_name
WHERE id IN 
(SELECT id 
FROM table_name 
WHERE department = 'Noisebridge');


SELECT id, first_name, last_name
FROM table_name
WHERE date_registrered > 
(SELECT min(other_date) 
FROM other_table
WHERE other_col = 'Noisebridge')



SELECT col_1, col_2
FROM (SELECT col_1, col_2 
FROM table_name);
--This example is really not that useful but it will make sense with JOINs


SELECT SUM(col_1_case) as col_1_sum
, SUM(col_2_case) as col_2_sum
FROM (SELECT CASE WHEN col_1 > 0 THEN 1 ELSE 0 END AS col_1_case
,CASE WHEN col_1 > 0 THEN 1 ELSE 0 END AS col_2_case 
FROM table_name);



SELECT SUM(CASE WHEN col_1 > 0 THEN 1 ELSE 0 END) AS col_1_sum
,SUM(CASE WHEN col_1 > 0 THEN 1 ELSE 0 END) AS col_2_sum 
FROM table_name;



SELECT 
t1.*
,t2.*
FROM table_name_1 t1
INNER JOIN table_name_2 t2
ON t1.id = t2.foreign_id;
--	Instead of joining full tables, you can join subqueries
--		Very useful when you have to join in aggreagate values of some kind
