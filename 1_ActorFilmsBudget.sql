SELECT 
    P.ID,
    P.FirstName,
    P.LastName,
    SUM(M.Budget) AS TotalMoviesBudget
FROM 
    Person P
JOIN 
    [Character] C ON P.ID = C.ActorID
JOIN 
    Movie M ON C.MovieID = M.ID
GROUP BY 
    P.ID, P.FirstName, P.LastName;