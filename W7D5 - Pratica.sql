-- W7D5 - Pratica
USE chinook;

-- Esercizio 1 Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.
SELECT b.Name AS 'Nome Genere'
       ,COUNT(*) AS 'Numero Tracce'
  FROM Track AS a
  JOIN Genre AS b ON a.GenreId = b.GenreId
 GROUP BY b.Name
 HAVING COUNT(*) >= 10
 ORDER BY COUNT(*) DESC;
 
-- Esercizio 2 Trovate le tre canzoni più costose.
SELECT Name AS 'Nome Traccia'
       ,UnitPrice AS 'Prezzo Traccia'
 FROM Track
ORDER BY UnitPrice DESC
LIMIT 3;
-- Esercizio 3 Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.
SELECT b.Title AS 'Titolo Album'
       ,c.Name AS 'Nome Artista'
       ,a.Milliseconds AS 'Durata traccia in millesecondi'
  FROM Track AS a 
  JOIN Album AS b ON b.AlbumId = a.AlbumId
  JOIN Artist AS c ON c.ArtistId = b.ArtistId
 WHERE a.Milliseconds  > 360000;
 
-- Esercizio 4 Individuate la durata media delle tracce per ogni genere.
SELECT b.Name AS 'Nome Genere'
       ,AVG(a.Milliseconds) AS 'Durata media traccia in millesecondi'
  FROM Track AS a 
  JOIN Genre AS b ON a.GenreId = b.GenreId
  GROUP BY b.Name;
  
-- Esercizio 5 Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.
SELECT b.Name AS 'Nome Genere'
       ,a.Name AS 'Nome Taraccia'
  FROM Track AS a 
  JOIN Genre AS b ON a.GenreId = b.GenreId
 WHERE a.Name LIKE '%LOVE%'
 ORDER BY b.Name,a.Name;
 
-- Esercizio 6 Trovate il costo medio per ogni tipologia di media.alter
SELECT MediaTypeId, 
       AVG(UnitPrice) AS 'Costo Medio'
  FROM Track
 GROUP BY MediaTypeId;
 
-- Esercizio 7 Individuate il genere con più tracce.
SELECT b.Name AS 'Nome Genere'
       ,COUNT(*) AS 'Numero Tracce'
  FROM Track AS a
  JOIN Genre AS b ON a.GenreId = b.GenreId
 GROUP BY b.Name
 ORDER BY COUNT(*) DESC
 LIMIT 1;
 
-- Esercizio 8 Esercizio Query Avanzate Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.
SELECT b.Name AS 'Nome Artista'
       ,COUNT(*) AS 'Numero Album'
  FROM Album AS a
  JOIN Artist AS b ON b.ArtistId = a.ArtistId
  GROUP BY b.Name
 HAVING COUNT(*) = (SELECT COUNT(*)
                      FROM Album AS a
                      JOIN Artist AS b ON a.ArtistId = b.ArtistId
				     WHERE b.Name = 'The Rolling Stones');

-- Esercizio 9 Trovate l’artista con l’album più costoso.
SELECT c.Name AS 'Nome Artista', 
       b.Title AS 'Titolo Album', 
       SUM(a.UnitPrice) AS 'Costo Totale Album'
  FROM Track AS a
  JOIN Album AS b ON b.AlbumId = a.AlbumId
  JOIN Artist AS c ON c.ArtistId = b.ArtistId
  GROUP BY b.AlbumId, b.Title, c.Name
  ORDER BY SUM(a.UnitPrice) DESC
  LIMIT 1;
