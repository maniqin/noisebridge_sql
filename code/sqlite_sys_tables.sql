-- System tables
SELECT * FROM sqlite_stat1 LIMIT 10;
SELECT * FROM sqlite_sequence LIMIT 10;
SELECT * FROM sqlite_master LIMIT 10;
SELECT * FROM sqlite_master WHERE type = 'table' LIMIT 10;

-- Look up a column or table name in sqlite!
SELECT tbl_name, sql from sqlite_master 
WHERE type = 'table'
AND LOWER(sql) LIKE '%col_name_search%';
-- this will search through the CREATE TABLE statement
-- so it can also search for a table name

-- Other system tables
SELECT * FROM sqlite_stat1 LIMIT 10;
SELECT * FROM sqlite_sequence LIMIT 10;