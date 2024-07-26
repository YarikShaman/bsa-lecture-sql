CREATE TABLE [File] (
    id INT PRIMARY KEY IDENTITY,
    fileName NVARCHAR(255) NOT NULL,
    MIMEType NVARCHAR(20) NOT NULL,
    [Key] NVARCHAR(255) NOT NULL,
    URL NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE [User] (
    ID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    AvatarFileID INT FOREIGN KEY REFERENCES [File](ID),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Country (
    ID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Person (
    ID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Biography TEXT,
    DateOfBirth DATE,
    Gender NVARCHAR(20),
    CountryID INT FOREIGN KEY REFERENCES Country(ID),
    PrimaryPhotoFileID INT FOREIGN KEY REFERENCES [File](ID),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE PersonPhoto (
    PersonID INT FOREIGN KEY REFERENCES [Person](ID) NOT NULL,
    FileID INT FOREIGN KEY REFERENCES [File](ID) NOT NULL,
    PRIMARY KEY (PersonID, FileID)
)

CREATE TABLE Movie (
    ID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255) NOT NULL,
    Description TEXT,
    Budget DECIMAL(18,2),
    ReleaseDate DATE,
    Duration INT,
    DirectorID INT FOREIGN KEY REFERENCES Person(ID),
    CountryID INT FOREIGN KEY REFERENCES Country(ID),
    PosterFileID INT FOREIGN KEY REFERENCES [File](ID),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Genre (
    ID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE MovieGenre (
    MovieID INT FOREIGN KEY REFERENCES Movie(ID),
    GenreID INT FOREIGN KEY REFERENCES Genre(ID),
    PRIMARY KEY (MovieID, GenreID)
);

CREATE TABLE Character (
    ID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(255),
    Description TEXT,
    Role NVARCHAR(20) CHECK (Role IN ('leading', 'supporting', 'background')),
    ActorID INT FOREIGN KEY REFERENCES Person(ID),
    MovieID INT FOREIGN KEY REFERENCES Movie(ID) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
	CONSTRAINT CHK_Name_ActorID CHECK (
		(Name IS NOT NULL OR ActorID IS NOT NULL)
	)
);

CREATE TABLE FavoriteMovies (
    UserID INT FOREIGN KEY REFERENCES [User](ID) NOT NULL,
    MovieID INT FOREIGN KEY REFERENCES Movie(ID) NOT NULL,
    PRIMARY KEY (UserID, MovieID)
);

--INSERT`S

--INSERT INTO [File] (fileName, MIMEType, [Key], URL)
--VALUES 
--('avatar1.jpg', 'image/jpeg', 'avatars/avatar1.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
--('avatar2.jpg', 'image/jpeg', 'avatars/avatar2.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
--('poster1.jpg', 'image/jpeg', 'posters/poster1.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
--('poster2.jpg', 'image/jpeg', 'posters/poster2.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
--('photo1.jpg', 'image/jpeg', 'photos/photo1.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
--('photo2.jpg', 'image/jpeg', 'photos/photo2.jpg', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');

--INSERT INTO [User] (Username, FirstName, LastName, Email, Password, AvatarFileID)
--VALUES 
--('john_doe', 'John', 'Doe', 'john@gmail.com', 'hashedpass1', 1),
--('jane_smith', 'Jane', 'Smith', 'jane@gmail.com', 'hashedpass2', 2),
--('peter_parker', 'Peter', 'Parker', 'peter@gmail.com', 'hashedpass3', 1);

--INSERT INTO Country (Name)
--VALUES 
--('USA'),
--('UK'),
--('Canada'),
--('France');

--INSERT INTO Person (FirstName, LastName, Biography, DateOfBirth, Gender, CountryID, PrimaryPhotoFileID)
--VALUES 
--('Steven', 'Spielberg', 'A famous director...', '1946-12-18', 'Male', 1, 3),
--('Christopher', 'Nolan', 'Known for directing...', '1970-07-30', 'Male', 2, 5),
--('Leonardo', 'DiCaprio', 'One of the most popular actors...', '1974-11-11', 'Male', 1, 1),
--('Emma', 'Watson', 'British actress...', '1990-04-15', 'Female', 2, 2);

--INSERT INTO Movie (Title, Description, Budget, ReleaseDate, Duration, DirectorID, CountryID, PosterFileID)
--VALUES 
--('Inception', 'A mind-bending thriller...', 160000000, '2021-07-16', 148, 2, 2, 3),
--('Jurassic Park', 'Dinosaurs brought back to life...', 63000000, '1993-06-11', 127, 1, 1, NULL),
--('Interstellar', 'A journey through space...', 165000000, '2020-11-07', 169, 2, 1, 4),
--('Titanic', 'A romance on the ill-fated ship...', 200000000, '1997-12-19', 195, NULL, 1, 4);
--('Movie with criteria', 'New drama...', 200000000, '2023-06-16', 145, 1, 1, 3);

--INSERT INTO Genre (Name)
--VALUES 
--('Action'),
--('Adventure'),
--('Sci-Fi'),
--('Drama'),
--('Romance');

--INSERT INTO MovieGenre (MovieID, GenreID)
--VALUES 
--(1, 1),
--(1, 2),
--(2, 2),
--(2, 3),
--(3, 3),
--(3, 4),
--(4, 4),
--(4, 5),
--(5, 4);

--INSERT INTO Character (Name, Description, Role, ActorID, MovieID)
--VALUES 
--(NULL, 'Use such case if need to add actor without character...', 'background', 3, 1),
--('Dr. Alan Grant', 'A paleontologist...', 'leading', NULL, 2),
--('Cooper', 'NASA scientist...', 'supporting', 3, 3),
--('Rose DeWitt Bukater', 'A wealthy young woman...', 'leading', 4, 4);

--INSERT INTO FavoriteMovies (UserID, MovieID)
--VALUES 
--(1, 1),
--(2, 2),
--(3, 3),
--(3, 4);

--INSERT INTO PersonPhoto (PersonID, FileID)
--VALUES
--(3, 1),
--(3, 2),
--(4, 6);