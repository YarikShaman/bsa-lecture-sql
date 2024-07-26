# bsa-lecture-sql

```mermaid
erDiagram
    FILE {
        INT id PK
        NVARCHAR(255) fileName
        NVARCHAR(20) MIMEType
        NVARCHAR(255) Key
        NVARCHAR(255) URL
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }

    USER {
        INT ID PK
        NVARCHAR(100) Username
        NVARCHAR(100) FirstName
        NVARCHAR(100) LastName
        NVARCHAR(100) Email
        NVARCHAR(255) Password
        INT AvatarFileID FK
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }
    USER }o--o| FILE : Avatar

    COUNTRY {
        INT ID PK
        NVARCHAR(100) Name
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }

    PERSON {
        INT ID PK
        NVARCHAR(100) FirstName
        NVARCHAR(100) LastName
        TEXT Biography
        DATE DateOfBirth
        NVARCHAR(20) Gender
        INT CountryID FK
        INT PrimaryPhotoFileID FK
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }
    PERSON }o--o| COUNTRY : Country
    PERSON }o--o| FILE : PrimaryPhoto

    PERSONPHOTO {
        INT PersonID FK
        INT FileID FK
    }
    PERSON ||--o{ PERSONPHOTO : Photos
    FILE ||--o{ PERSONPHOTO : UsedBy

    MOVIE {
        INT ID PK
        NVARCHAR(255) Title
        TEXT Description
        DECIMAL Budget
        DATE ReleaseDate
        INT Duration
        INT DirectorID FK
        INT CountryID FK
        INT PosterFileID FK
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }
    MOVIE }o--o| PERSON : DirectedBy
    MOVIE }o--o| COUNTRY : Country
    MOVIE }o--o| FILE : Poster

    GENRE {
        INT ID PK
        NVARCHAR(100) Name
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }

    MOVIEGENRE {
        INT MovieID FK
        INT GenreID FK
    }
    MOVIE ||--o{ MOVIEGENRE : Genres
    GENRE ||--o{ MOVIEGENRE : UsedIn

    CHARACTER {
        INT ID PK
        NVARCHAR(255) Name
        TEXT Description
        NVARCHAR(20) Role
        INT ActorID FK
        INT MovieID FK
        DATETIME CreatedAt
        DATETIME UpdatedAt
    }
    PERSON |o--o{ CHARACTER : ActedBy
    MOVIE ||--o{ CHARACTER : Characters

    FAVORITEMOVIES {
        INT UserID FK
        INT MovieID FK
    }
    USER ||--o{ FAVORITEMOVIES : FavoriteMovies
    MOVIE ||--o{ FAVORITEMOVIES : IsFavoriteMovie
