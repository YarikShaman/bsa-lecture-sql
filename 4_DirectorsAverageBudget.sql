SELECT 
    P.ID AS DirectorID,
    P.FirstName + ' ' + P.LastName AS DirectorName,
    AVG(M.Budget) AS AverageBudget
FROM 
    Person P
JOIN 
    Movie M ON P.ID = M.DirectorID
GROUP BY 
    P.ID, P.FirstName, P.LastName;