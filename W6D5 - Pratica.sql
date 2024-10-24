-- W6D5 - Pratica
USE adv;
-- * 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
SELECT a.ProductAlternateKey AS 'Codice Prodotto'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,b.EnglishProductSubcategoryName AS 'Sotto Categoria'
  FROM DimProduct AS a
  JOIN DimProductSubcategory AS b ON a.ProductSubcategoryKey = b.ProductSubcategoryKey;

-- 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).

/*Seleziono tutti i prodotti che hanno la ProductSubcategoryKey (FK) valoriazzata,così da poter creare un legame tra prodotti e categorie utilizzando la FK.
Creo la stessa realzione fra sotto categorie e categorie, utilizzando sempre l'id della categoria presente in sottocategorie come FK. */
SELECT a.ProductAlternateKey AS 'Codice Prodotto'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,b.EnglishProductSubcategoryName AS 'Sotto Categoria'
       ,c.EnglishProductCategoryName AS Categoria
  FROM DimProduct AS a
  JOIN DimProductSubcategory AS b ON a.ProductSubcategoryKey = b.ProductSubcategoryKey
  JOIN DimProductcategory AS c ON b.ProductCategoryKey = c.ProductCategoryKey;
  
-- 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales).
-- 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)
SELECT a.ProductAlternateKey AS 'Codice Prodotto'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,b.SalesOrderNumber AS 'Codice Ordine'
       ,b.OrderDate AS 'Data Ordine'
  FROM DimProduct AS a 
  JOIN FactResellerSales AS b ON a.ProductKey = b.ProductKey;
  
  -- 4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).
  -- Con la LEFT JOIN, vengono mantenuti tutti i prodotti, anche se non hanno una corrispondenza nella tabella delle vendite, che quindi non sono stati venduti.
  SELECT a.ProductAlternateKey AS 'Codice Prodotto'
       ,a.EnglishProductName AS 'Nome Prodotto'
  FROM DimProduct AS a 
  LEFT JOIN FactResellerSales AS b ON a.ProductKey = b.ProductKey
 WHERE a.FinishedGoodsFlag  = 1 
   AND b.SalesOrderNumber IS NULL;
  
-- 6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
SELECT a.ProductAlternateKey AS 'Codice Prodotto'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,b.SalesOrderNumber AS 'Codice Ordine'
       ,b.OrderDate AS 'Data Ordine'
       ,d.EnglishProductCategoryName AS Categoria
  FROM DimProduct AS a 
  JOIN FactResellerSales AS b ON a.ProductKey = b.ProductKey
  JOIN DimProductSubcategory AS c ON a.ProductSubcategoryKey = c.ProductSubcategoryKey
  JOIN DimProductcategory AS d ON c.ProductCategoryKey = d.ProductCategoryKey;

-- 7.Esplora la tabella DimReseller.
SELECT *
  FROM DimReseller;

-- 8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.
SELECT a.ResellerName AS 'Nome Reseller'
       ,b.City AS 'Città Reseller'
       ,b.StateProvinceName AS 'Località Reseller'
  FROM DimReseller AS a
  JOIN DimGeography AS b ON a.GeographyKey = b.GeographyKey;
  
/* 9-Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica. */

SELECT b.SalesOrderNumber AS 'Codice Prodotto'
       ,b.SalesOrderLineNumber 'Numero Articolo'
       ,b.OrderDate AS 'Data Ordine'
       ,b.UnitPrice AS 'Prezzo'
       ,b.OrderQuantity AS Quantità 
       ,b.TotalProductCost AS 'Prezzo totale'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,d.EnglishProductCategoryName AS Categoria
       ,e.ResellerName AS 'Nome Reseller'
       ,f.City AS 'Città Reseller'
       ,f.StateProvinceName AS 'Località Reseller'
  FROM DimProduct AS a 
  JOIN FactResellerSales AS b ON a.ProductKey = b.ProductKey
  JOIN DimProductSubcategory AS c ON a.ProductSubcategoryKey = c.ProductSubcategoryKey
  JOIN DimProductcategory AS d ON c.ProductCategoryKey = d.ProductCategoryKey
  JOIN DimReseller AS e ON b.ResellerKey = e.ResellerKey
  JOIN DimGeography AS f ON e.GeographyKey = f.GeographyKey;

-- TIP: Dove possibile, risolvi la query utilizzando sia le JOIN che le SUBQUER

/* Modifico la query richiesta dal punto numero 6, inserendo una subquery.
   In questo caso la subquery contiene sotto categorie e categori. */
SELECT b.SalesOrderNumber AS 'Codice Prodotto'
       ,b.SalesOrderLineNumber 'Numero Articolo'
       ,b.OrderDate AS 'Data Ordine'
       ,b.UnitPrice AS 'Prezzo'
       ,b.OrderQuantity AS Quantità 
       ,b.TotalProductCost AS 'Prezzo totale'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,CategoryDetails.Categoria AS Categoria
  FROM DimProduct AS a 
  JOIN FactResellerSales AS b ON a.ProductKey = b.ProductKey
  JOIN (SELECT b.EnglishProductCategoryName AS Categoria
               ,a.ProductSubcategoryKey AS IdSottoCategoria
          FROM DimProductSubcategory AS a
          JOIN DimProductcategory AS b ON a.ProductCategoryKey = b.ProductCategoryKey
		) AS CategoryDetails ON a.ProductSubcategoryKey = CategoryDetails.IdSottoCategoria;
		
/* Modifico la query richiesta dal punto numero 9, inserendo due subquery.
   In questo caso la prima subquery contiene smpre le sotto categorie e categori, invece la seconda i reseller e la località dei reseller.*/
SELECT b.SalesOrderNumber AS 'Codice Prodotto'
       ,b.SalesOrderLineNumber 'Numero Articolo'
       ,b.OrderDate AS 'Data Ordine'
       ,b.UnitPrice AS 'Prezzo'
       ,b.OrderQuantity AS Quantità 
       ,b.TotalProductCost AS 'Prezzo totale'
       ,a.EnglishProductName AS 'Nome Prodotto'
       ,CategoryDetails.Categoria AS Categoria
       ,ResellerLocalities.NomeReseller AS 'Nome Reseller'
       ,ResellerLocalities.CittàReseller AS 'Città Reseller'
       ,ResellerLocalities.LocalitàReseller AS 'Località Reseller'
  FROM DimProduct AS a 
  JOIN FactResellerSales AS b ON a.ProductKey = b.ProductKey
  JOIN (SELECT b.EnglishProductCategoryName AS Categoria
               ,a.ProductSubcategoryKey AS IdSottoCategoria
          FROM DimProductSubcategory AS a
          JOIN DimProductcategory AS b ON a.ProductCategoryKey = b.ProductCategoryKey
		) AS CategoryDetails ON a.ProductSubcategoryKey = CategoryDetails.IdSottoCategoria
  JOIN (SELECT a.ResellerName AS NomeReseller
               ,a.ResellerKey
			   ,b.City AS CittàReseller
               ,b.StateProvinceName AS LocalitàReseller
          FROM DimReseller AS a
          JOIN DimGeography AS b ON a.GeographyKey = b.GeographyKey
		) AS ResellerLocalities ON b.ResellerKey = ResellerLocalities.ResellerKey;
