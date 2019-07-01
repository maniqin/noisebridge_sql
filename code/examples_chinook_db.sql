-- TABLES:
-- 		tracks
-- 		albums
-- 		artists

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