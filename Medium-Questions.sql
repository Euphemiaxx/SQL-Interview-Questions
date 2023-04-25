/* FORBES - Find the top 3 most profitable Companies */ 

SELECT TOP 3 company,profits profit 
FROM forbes_global_2010_2014 
ORDER BY profits desc;


