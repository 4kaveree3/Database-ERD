CREATE DATABASE SushiRoll;


-- we are going to use SushiRoll to store our Tables
USE SushiRoll;

-- Create User table
CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    SubscriptionType ENUM('Free', 'Basic', 'Premium') NOT NULL
);

-- Create Anime table
CREATE TABLE Anime (
    AnimeID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    ReleaseDate DATE,
    Genre VARCHAR(100)
);

-- Create Episode table
CREATE TABLE Episode (
    EpisodeID INT PRIMARY KEY AUTO_INCREMENT,
    AnimeID INT,
    EpisodeNumber INT,
    Title VARCHAR(255) NOT NULL,
    Duration TIME,
    ReleaseDate DATE,
    FOREIGN KEY (AnimeID) REFERENCES Anime(AnimeID)
);

-- Create UserAnimeHistory table
CREATE TABLE UserAnimeHistory (
    UserID INT,
    AnimeID INT,
    LastWatchedEpisode INT,
    PRIMARY KEY (UserID, AnimeID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (AnimeID) REFERENCES Anime(AnimeID)
);

-- Create SubscriptionPlan table
CREATE TABLE SubscriptionPlan (
    PlanID INT PRIMARY KEY AUTO_INCREMENT,
    PlanName VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Duration INT NOT NULL -- Duration in months, for example
);

-- Create PaymentTransaction table
CREATE TABLE PaymentTransaction (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    PlanID INT,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (PlanID) REFERENCES SubscriptionPlan(PlanID)
);

-- Truncate UserAnimeHistory table
TRUNCATE TABLE UserAnimeHistory;

-- Truncate SubscriptionPlan table
TRUNCATE TABLE SubscriptionPlan;
							  
-- Truncate PaymentTransaction table
TRUNCATE TABLE PaymentTransaction;

-- Truncate Episode table
TRUNCATE TABLE Episode;

-- Truncate Anime table
TRUNCATE TABLE Anime;

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate your tables here

-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


-- Inserting consistent data into Anime table
INSERT INTO Anime (Title, Description, ReleaseDate, Genre) VALUES 
('Dragon Ball Z', 'Goku and his friends defend Earth against various threats', '1989-04-26', 'Action'),
('Demon Slayer: Kimetsu no Yaiba', 'A boy becomes a demon slayer to avenge his family', '2019-04-06', 'Adventure'),
('My Hero Academia', 'Students training to become heroes in a world where almost everyone has superpowers', '2016-04-03', 'Action'),
('Death Note', 'A high school student gains a notebook with the power to kill anyone whose name he writes in it', '2006-10-04', 'Mystery');

-- Inserting consistent data into Episode table
INSERT INTO Episode (AnimeID, EpisodeNumber, Title, Duration, ReleaseDate) VALUES 
(1, 1, 'The Arrival of Raditz', '00:24:00', '1989-04-26'),
(1, 2, 'The World''s Strongest Team', '00:24:00', '1989-05-03'),
(2, 1, 'Cruelty', '00:24:00', '2019-04-06'),
(2, 2, 'Trainer Sakonji Urokodaki', '00:24:00', '2019-04-13'),
(3, 1, 'Izuku Midoriya: Origin', '00:24:00', '2016-04-03'),
(3, 2, 'What It Takes to Be a Hero', '00:24:00', '2016-04-10'),
(4, 1, 'Rebirth', '00:24:00', '2006-10-04'),
(4, 2, 'Confrontation', '00:24:00', '2006-10-11');

-- Inserting consistent data into UserAnimeHistory table
INSERT INTO UserAnimeHistory (UserID, AnimeID, LastWatchedEpisode) VALUES 
(1, 1, 2),  -- User 1 last watched Episode 2 of Dragon Ball Z
(2, 2, 1),  -- User 2 last watched Episode 1 of Demon Slayer: Kimetsu no Yaiba
(3, 3, 1),  -- User 3 last watched Episode 1 of My Hero Academia
(4, 4, 1),  -- User 4 last watched Episode 1 of Death Note
(5, 2, 2),  -- User 5 last watched Episode 2 of Demon Slayer: Kimetsu no Yaiba
(6, 3, 2),  -- User 6 last watched Episode 2 of My Hero Academia
(7, 4, 2),  -- User 7 last watched Episode 2 of Death Note
(8, 1, 1),  -- User 8 last watched Episode 1 of Dragon Ball Z
(9, 2, 1),  -- User 9 last watched Episode 1 of Demon Slayer: Kimetsu no Yaiba
(10, 3, 1); -- User 10 last watched Episode 1 of My Hero Academia

-- Inserting consistent data into SubscriptionPlan table
INSERT INTO SubscriptionPlan (PlanName, Price, Duration) VALUES 
('Premium Plus', 19.99, 3),
('Standard', 12.99, 1),
('Basic Lite', 6.99, 1),
('Starter', 0.00, 0);

-- Inserting consistent data into PaymentTransaction table
INSERT INTO PaymentTransaction (UserID, PlanID, PaymentStatus) VALUES 
(1, 1, 'Completed'),
(2, 2, 'Completed'),
(3, 3, 'Pending'),
(4, 4, 'Completed'),
(5, 1, 'Completed'),
(6, 2, 'Pending'),
(7, 3, 'Completed'),
(8, 4, 'Completed'),
(9, 1, 'Pending'),
(10, 2, 'Completed');

-- Creating a View to pivot the UserAnimeHistory 
CREATE VIEW UserAnimeHistoryView AS
SELECT
    U.UserID,
    U.Username,
    A.Title AS AnimeTitle,
    UA.LastWatchedEpisode
FROM
    User U
JOIN
    UserAnimeHistory UA ON U.UserID = UA.UserID
JOIN
    Anime A ON UA.AnimeID = A.AnimeID;
    
    
    
-- Create view for Anime Episode Pivot Table     
CREATE VIEW AnimeEpisodeView AS
    SELECT
    A.Title AS AnimeTitle,
    E.EpisodeNumber,
    E.Title AS EpisodeTitle,
    E.ReleaseDate
FROM
    Anime A
JOIN
    Episode E ON A.AnimeID = E.AnimeID;
SELECT
    A.Title AS AnimeTitle,
    E.EpisodeNumber,
    E.Title AS EpisodeTitle,
    E.ReleaseDate
FROM
    Anime A
JOIN
    Episode E ON A.AnimeID = E.AnimeID;


