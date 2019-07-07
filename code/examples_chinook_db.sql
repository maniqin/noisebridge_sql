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

