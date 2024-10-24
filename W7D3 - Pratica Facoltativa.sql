-- W7D2 - Pratica Facoltativa
USE chinook;
-- Esercizio 1 Effettuate tutte le query esplorative che vi servono per prendere confidenza con i dati. 

SELECT * FROM Album LIMIT 10; -- Visualizzate le prime 10 righe della tabella Album.
SELECT * FROM Track; -- Trovate il numero totale di canzoni della tabella Tracks.
SELECT * FROM Genre; -- Trovate i diversi generi presenti nella tabella Genre.

-- Esercizio 2 Recuperate il nome di tutte le tracce e del genere associato.
SELECT a.Name AS 'Nome Genere'
       ,b.Name AS 'Nome Taraccia'
  FROM Genre AS a
  JOIN Track AS b ON a.GenreId = b.GenreId;

-- Esercizio 3 Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?
SELECT DISTINCT b.Name AS 'Nome Artista'
  FROM Album AS a 
  JOIN Artist AS b ON a.ArtistId = b.ArtistId; -- LA QUERY INDICA TUTTI GLI ARTISTI CHE HANNO ALMENO UN ALBUM.

SELECT DISTINCT a.Name AS 'Nome Artista'
  FROM Artist AS a 
  LEFT JOIN Album AS b ON a.ArtistId = b.ArtistId 
 WHERE b.AlbumId IS NULL; -- SI CI SONO ARTISTI CHE NON HANNO ALBUM NEL DB, LA QUERY INDICA TUTTI GLI ARTISTI CHE NON HANNO ALBUM.
 
 -- Esercizio 4 Esercizio Join Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. Esiste un modo per recuperare il nome della tipologia di media?
  SELECT a.Name AS 'Nome Traccia'
         ,b.Name AS 'Nome Genere'
         ,c.Name AS 'Nome Tipo di media'
    FROM Track AS a
    JOIN Genre AS b ON a.GenreId = b.GenreId
    JOIN MediaType AS c ON c.MediaTypeId = a.MediaTypeId; 

-- Esercizio 5 Elencate i nomi di tutti gli artisti e dei loro album.
SELECT b.Name AS 'Nome Artista'
       ,a.Title AS 'Titolo Album'
  FROM Album AS a 
  JOIN Artist AS b ON a.ArtistId = b.ArtistId;