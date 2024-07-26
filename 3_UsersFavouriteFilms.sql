SELECT 
    U.ID,
    U.Username,
    (
        SELECT 
            STRING_AGG(FM.MovieID, ',') 
        FROM 
            FavoriteMovies FM 
        WHERE 
            FM.UserID = U.ID
    ) AS FavoriteMovieIDs
FROM 
    [User] U;