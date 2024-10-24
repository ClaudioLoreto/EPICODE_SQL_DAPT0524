-- W7D3 - Pratica Facoltativa2
USE chinook;

-- Esercizio 1 Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.
SELECT a.Name AS 'Nome Genere'
       ,b.Name AS 'Nome Taraccia'
  FROM Genre AS a
  JOIN Track AS b ON a.GenreId = b.GenreId
 WHERE a.Name IN ('Rock', 'Pop');
 
-- Esercizio 2 Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”.
SELECT b.Name AS 'Nome Artista'
       ,a.Title AS 'Titolo Album'
  FROM Album AS a 
  JOIN Artist AS b ON a.ArtistId = b.ArtistId
 WHERE b.Name LIKE 'A%'
   AND a.Title LIKE 'A%';
   
-- Esercizio 3 Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.
SELECT a.Name AS 'Nome Genere'
       ,b.Name AS 'Nome Taraccia'
  FROM Genre AS a
  JOIN Track AS b ON a.GenreId = b.GenreId
 WHERE a.Name = 'Jazz'
   AND b.Milliseconds < 180000;
 
 -- Esercizio 4 Recuperate tutte le tracce più lunghe della durata media.
SELECT Name AS 'Nome taraccia'
       ,Milliseconds AS 'Durata traccia in millesecondi'
  FROM Track
 WHERE Milliseconds > (SELECT AVG(Milliseconds)
                         FROM Track);

-- Esercizio 5 Esercizio Query Avanzate Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.
SELECT a.Name AS 'Nome Genere'
       ,AVG(b.Milliseconds) AS 'Durata media traccia in millesecondi'
  FROM Genre AS a
  JOIN Track AS b ON a.GenreId = b.GenreId
 GROUP BY a.Name
HAVING AVG(b.Milliseconds) > 240000;

-- Esercizio 6 Individuate gli artisti che hanno rilasciato più di un album.
SELECT b.Name AS 'Nome Artista'
       ,COUNT(*) AS 'Numero Album'
  FROM Album AS a 
  JOIN Artist AS b ON a.ArtistId = b.ArtistId
 GROUP BY b.Name
HAVING COUNT(*) > 1;

-- Esercizio 7 Trovate la traccia più lunga in ogni album.
SELECT b.Title AS 'Titolo Album'
       ,MAX(a.Milliseconds) AS 'Durata Tarccia millesecondi'
  FROM Track AS a 
  JOIN Album AS b ON b.AlbumId = a.AlbumId
  GROUP BY b.Title;
  
-- Esercizio 8 Individuate la durata media delle tracce per ogni album.
SELECT b.Title AS 'Titolo Album'
       ,AVG(a.Milliseconds) AS 'Durata media traccia in millesecondi'
  FROM Track AS a 
  JOIN Album AS b ON b.AlbumId = a.AlbumId
  GROUP BY b.Title;
  
-- Esercizio 9 Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.
SELECT b.Title AS 'Titolo Album'
       ,COUNT(*) AS 'Numero Tracce'
  FROM Track AS a 
  JOIN Album AS b ON b.AlbumId = a.AlbumId
  GROUP BY b.Title
 HAVING COUNT(*) > 20;