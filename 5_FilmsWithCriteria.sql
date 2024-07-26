SELECT 
    M.ID,
    M.Title,
    M.ReleaseDate,
    M.Duration,
    M.Description,
    JSON_QUERY(
        (
            SELECT 
                F.*
            FROM 
                [File] F
            WHERE 
                F.ID = M.PosterFileID
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS Poster,
    JSON_QUERY(
        (
            SELECT 
                P.ID,
                P.FirstName,
                P.LastName
            FROM 
                Person P
            WHERE 
                P.ID = M.DirectorID
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS Director
FROM 
    Movie M
JOIN 
    MovieGenre MG ON M.ID = MG.MovieID
JOIN 
    Genre G ON MG.GenreID = G.ID
WHERE 
    M.CountryID = 1 
    AND M.ReleaseDate >= '2022-01-01'
    AND M.Duration > 135
    AND G.Name IN ('Action', 'Drama');