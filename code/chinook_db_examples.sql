-- Tables
SELECT * FROM albums LIMIT 10;
SELECT * FROM artists LIMIT 10;
SELECT * FROM customers LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM genres LIMIT 10;
SELECT * FROM invoices LIMIT 10;
SELECT * FROM invoice_items LIMIT 10;
SELECT * FROM media_types LIMIT 10;
SELECT * FROM playlists LIMIT 10;
SELECT * FROM playlist_track LIMIT 10;
SELECT * FROM tracks LIMIT 10;


SELECT * FROM tracks;

SELECT Name, Composer 
FROM tracks;

SELECT DISTINCT Composer 
FROM tracks;

SELECT DISTINCT Composer 
FROM tracks
WHERE Composer IS NOT NULL;

SELECT Composer, *
FROM tracks
WHERE Composer = 'Nirvana';

SELECT * 
FROM albums;

SELECT * 
FROM artists;

SELECT * 
FROM tracks WHERE AlbumId = 163;

SELECT * 
FROM albums
WHERE AlbumId= 163;

SELECT Composer, Name
FROM tracks
WHERE Composer = 'Nirvana';

SELECT Composer, Name
FROM tracks
WHERE lower(Composer) = 'Nirvana';

SELECT Composer, Name
FROM tracks
WHERE lower(Composer) = 'nirvana';

SELECT Composer, Name
FROM tracks
WHERE lower(Composer) in ('nirvana', 'kurt cobain');


SELECT Composer, lower(Composer), Name, *
FROM tracks
WHERE lower(Composer) in ('nirvana', 'kurt cobain')
AND AlbumId = 164;

SELECT Composer, lower(Composer),  Name, *
FROM tracks
--WHERE lower(Composer) in ('nirvana', 'kurt cobain')
WHERE AlbumId = 164;


SELECT * 
FROM tracks
WHERE MediaTypeId = 1;
-- 1 is 'MPEG audio file'


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


------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-- Demonstration of NULL values vs Blank strings:

-- Insert a test row into the tracks table
-- Careful, you wouldn't normally do this on a production database!
INSERT INTO tracks VALUES (3504, '', 2, 1, 1, NULL, 4524856, NULL, 0.99)

-- Get the latest two tracks 
-- (the one we just inserted and the one right before, which was there already)
SELECT * FROM tracks WHERE TrackId >= 3503

-- No rows retrieved!
SELECT * FROM tracks WHERE Name IS NULL;
-- One row retrived! (The one we inserted)
SELECT * FROM tracks WHERE Name = '';

-- Remove the test row from the table...
DELETE FROM tracks WHERE TrackId = 3504;

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- More advanced queries

SELECT t.TrackId
	,t.Name
	,t.Composer
	,m.Name
FROM tracks t
INNER JOIN media_types m
ON t.MediaTypeId = m.MediaTypeId
--WHERE m.MediaTypeId = 1 -- MPEG audio file
WHERE m.name = 'MPEG audio file';


SELECT t.TrackId
	,t.Name
	,t.Composer
	,m.Name
	,a.*
FROM tracks t
LEFT JOIN albums a
ON t.AlbumId = a.AlbumId
LEFT JOIN media_types m
ON t.MediaTypeId = m.MediaTypeId
WHERE m.name = 'MPEG audio file';


SELECT t.TrackId
	,t.Name
	,t.Composer
	,m.Name
	,a.*
FROM tracks t
LEFT JOIN albums a
	ON t.AlbumId = a.AlbumId
LEFT JOIN media_types m
	ON t.MediaTypeId = m.MediaTypeId
WHERE m.name = 'MPEG audio file'
ORDER BY random()
LIMIT 100;



SELECT
	art.Name as artist_name
	,alb.Title as album_title
	,m.Name as media_type
FROM albums alb
LEFT JOIN artists art
	ON alb.ArtistId = art.ArtistId
LEFT JOIN 

		(
		SELECT AlbumId, MediaTypeId
			FROM tracks
			GROUP BY 1,2
		) alb_mtype

	ON alb.AlbumId = alb_mtype.AlbumId
LEFT JOIN media_types m
	ON alb_mtype.MediaTypeId = m.MediaTypeId
-- WHERE artist_name = 'Audioslave'
ORDER BY 1,2,3
LIMIT 100;



-- Check that albums are only of one media type (they're not)
SELECT TrackId, Name, AlbumId, MediaTypeId 
FROM tracks
ORDER BY AlbumId, MediaTypeId;


-- You could manually eyeball this and look for dupes (duplicates) in the first columns...
SELECT AlbumId
	, MediaTypeId
FROM tracks
GROUP BY 1,2
ORDER BY 1,2;

-- But this is easier (check count of all albums vs count distinct)
-- One album has two media types!
SELECT
	COUNT(sub.AlbumId) as albums_all
	,COUNT(DISTINCT sub.AlbumId) as albums_distinct
	FROM (
		SELECT AlbumId, MediaTypeId
		FROM tracks
		GROUP BY 1,2
		) sub ;
	

-- FIND IT:
SELECT
	sub.AlbumId
	,COUNT(sub.AlbumId) as albums_all
	,COUNT(DISTINCT sub.AlbumId) as albums_distinct
		FROM (
				SELECT AlbumId, MediaTypeId
				FROM tracks
				GROUP BY 1,2
			) sub 
	GROUP BY 1
	ORDER BY 2 DESC;

		
-- or better 

SELECT
	sub.AlbumId
	,COUNT(sub.AlbumId) as albums_all
	,COUNT(DISTINCT sub.AlbumId) as albums_distinct
		FROM (
				SELECT AlbumId, MediaTypeId
				FROM tracks
				GROUP BY 1,2
			) sub 
	GROUP BY 1
	HAVING albums_all > 1;


-- What is this album and who is it by?
SELECT 
	art.Name as artist_name,
	alb.Title as album_title
FROM albums alb
INNER JOIN artists art
	ON alb.ArtistId = art.ArtistId
WHERE alb.AlbumId = 271;


-- Ongoing query that will find new albums with multiple media types 
-- (if added in the future to the table)
SELECT
	alb.AlbumId as album_id
	,alb.Title as album_name
	,art.Name as artist_name
	
FROM albums alb
INNER JOIN artists art
	ON alb.ArtistId = art.ArtistId
INNER JOIN 
		(
		SELECT
				sub.AlbumId
				,COUNT(sub.AlbumId) as albums_all
				,COUNT(DISTINCT sub.AlbumId) as albums_distinct
		FROM (
				SELECT AlbumId, MediaTypeId
				FROM tracks
				GROUP BY 1,2
				) sub 
				GROUP BY 1
				HAVING albums_all > 1
		) dupe_albs
	
	ON alb.AlbumId = dupe_albs.AlbumId;






-- Most expensive albums

select 
	al.Title as album_name
	,sum(UnitPrice) as album_cost
	,count(tr.TrackId) as count_track_id
	,count(distinct tr.TrackId) as count_dist_track_id
from tracks tr
inner join albums al
on tr.AlbumId = al.AlbumId
group by 1
order by 2 desc

-- Most expensive albums with artist name
SELECT 
	ar.Name as artist_name
	,al.Title as album_name
	,sum(UnitPrice) as album_cost
	,count(tr.TrackId) as count_track_id
	,count(distinct tr.TrackId) as count_dist_track_id
FROM tracks tr
INNER JOIN albums al
ON tr.AlbumId = al.AlbumId
INNER JOIN artists ar
ON ar.ArtistId = al.ArtistId
GROUP BY 1,2
ORDER BY 3 DESC



-- artist name of the song 'x'
SELECT DISTINCT 
	ar.Name as artist_name
FROM tracks tr
INNER JOIN albums al
	ON tr.AlbumId = al.AlbumId
INNER JOIN artists ar
	ON al.ArtistId = ar.ArtistId
WHERE tr.Name = 'Crazy Train'


-- the playlists track 61 appears in

SELECT
	ps.PlaylistId as playlist_id
	,ps.Name as playlist_name
	,tr.Name as track_name
FROM playlists ps
-- need to go through playlist track as join table to get to tracks
INNER JOIN playlist_track ptr
	ON ptr.PlaylistId = ps.PlaylistId
INNER JOIN tracks tr
	ON ptr.TrackId = tr.TrackId
WHERE tr.TrackId = 61


-- the customer names who rented track 20 (id)
SELECT 
	c.FirstName
	,c.LastName
	--, *
FROM invoice_items it
INNER JOIN invoices inv
	ON it.InvoiceId = inv.InvoiceId
INNER JOIN customers c
	ON inv.CustomerId = c.CustomerId
WHERE it.TrackId = 20


-- the most rented (bought) artists 

SELECT ar.Name
	, count(*)
	, sum(tr.UnitPrice)
FROM invoice_items it
INNER JOIN tracks tr
ON it.TrackId = tr.TrackId
INNER JOIN Albums al
ON tr.AlbumId = al.AlbumId
INNER JOIN Artists ar
ON ar.ArtistId = al.ArtistId
GROUP BY 1 ORDER BY 3 DESC

-- the invoices for all tracks costing more than 0.99 (>) dollars


-- First name, last name and address of emplyee who sold most acdc songs




-- Countries with most songs sold (via invoices, BillingCountry)









