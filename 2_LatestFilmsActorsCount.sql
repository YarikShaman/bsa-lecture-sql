SELECT 
    M.ID,
    M.Title,
    COUNT(C.ActorID) AS ActorsCount
FROM 
    Movie M
LEFT JOIN 
    [Character] C ON M.ID = C.MovieID
WHERE 
    M.ReleaseDate >= DATEADD(YEAR, -5, GETDATE())
GROUP BY 
    M.ID, M.Title;