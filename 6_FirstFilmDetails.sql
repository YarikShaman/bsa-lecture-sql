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
                P.LastName,
                JSON_QUERY(
                    (
                        SELECT 
                            FP.*
                        FROM 
                            [File] FP
                        WHERE 
                            FP.ID = P.PrimaryPhotoFileID
                        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
                    )
                ) AS Photo
            FROM 
                Person P
            WHERE 
                P.ID = M.DirectorID
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )
    ) AS Director,
    (
        SELECT 
            (
                SELECT 
                    C.ID,
                    A.FirstName,
                    A.LastName,
                    JSON_QUERY(
                        (
                            SELECT 
                                F.*
                            FROM 
                                [File] F
                            WHERE 
                                F.ID = A.PrimaryPhotoFileID
                            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
                        )
                    ) AS Photo
                FROM 
                    [Character] C
                JOIN 
                    Person A ON C.ActorID = A.ID
                WHERE 
                    C.MovieID = M.ID
                FOR JSON PATH
            ) AS Actors
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    ) AS Actors,
    (
        SELECT 
            (
                SELECT 
                    G.ID,
                    G.Name
                FROM 
                    MovieGenre MG
                JOIN 
                    Genre G ON MG.GenreID = G.ID
                WHERE 
                    MG.MovieID = M.ID
                FOR JSON PATH
            ) AS Genres
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
    ) AS Genres
FROM 
    Movie M
WHERE 
    M.ID = 1;