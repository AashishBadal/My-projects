create database Library
use Library


CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNo VARCHAR(15),
    Address TEXT,
    MemberStatus VARCHAR(20)
);
INSERT INTO Member (MemberID, Name, PhoneNo, Email, Address, MemberStatus)
VALUES

(1, 'Sujan Shrestha', '9812345678', 'sujan.shrestha@gmail.com', 'Lazimpat, Kathmandu', 'Active'),
(2, 'Aarati Sharma', '9823456789', 'aarati.sharma@gmail.com', 'Baluwatar, Kathmandu', 'Active'),
(3, 'Pooja Tamang', '9834567890', 'pooja.tamang@yahoo.com', 'Bhaktapur Durbar Square, Bhaktapur', 'Active'),
(4, 'Anil Rai', '9845678901', 'anil.rai@hotmail.com', 'Thamel, Kathmandu', 'Inactive'),
(5, 'Deepa Koirala', '9856789012', 'deepa.koirala@gmail.com', 'Durbarmarg, Kathmandu', 'Active'),
(6, 'Hari Bahadur Gurung', '9867890123', 'hari.gurung@hotmail.com', 'Patan, Lalitpur', 'Active'),
(7, 'Nisha Rathi', '9878901234', 'nisha.rathi@gmail.com', 'Naxal, Kathmandu', 'Active'),
(8, 'Bikash Thapa', '9889012345', 'bikash.thapa@gmail.com', 'Kalimati, Kathmandu', 'Inactive'),
(9, 'Sunita Adhikari', '9890123456', 'sunita.adhikari@gmail.com', 'Bagbazar, Kathmandu', 'Active'),
(10, 'Ravi Pradhan', '9801234567', 'ravi.pradhan@yahoo.com', 'Maitidevi, Kathmandu', 'Active');


CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Description TEXT,
    Genre VARCHAR(50),
    Loanable TINYINT DEFAULT 1, 
    Category VARCHAR(50),
    ColorTag VARCHAR(50),
    IssuedDate DATE,
    PublisherID INT,
    AuthorID INT,
	Price DECIMAL(10, 2),
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);



INSERT INTO Books (BookID, ISBN, Title, Description, Genre, Loanable, Category, ColorTag, IssuedDate, PublisherID, AuthorID, Price)
VALUES
(1, '978-9937-5695-1', 'The Kathmandu Chronicles', 'A story of Kathmandus rich history and culture.', 'History', 1, 'Non-fiction', 'Yellow', '2023-01-15', 1, 1, 599.99),
(2, '978-9937-5695-2', 'Mysteries of the Himalayas', 'Exploring the mysteries of the great Himalayan range.', 'Adventure', 1, 'Adventure', 'Red', '2023-02-22', 2, 2, 749.50),
(3, '978-9937-5695-3', 'Nepali Folklore', 'A collection of traditional Nepali folk stories.', 'Fiction', 1, 'Culture', 'Green', '2023-03-10', 3, 3, 299.00),
(4, '978-9937-5695-4', 'Himalayan Secrets', 'Deep insights into the unknown secrets of the Himalayas.', 'Adventure', 1, 'Travel', 'Yellow', '2023-04-05', 4, 4, 499.75),
(5, '978-9937-5695-5', 'Life in the Valley', 'A detailed account of life in Kathmandu Valley.', 'Non-fiction', 1, 'Biography', 'Red', '2023-05-12', 5, 5, 850.00),
(6, '978-9937-5695-6', 'The Temples of Nepal', 'Exploring the sacred temples across Nepal.', 'Religion', 1, 'History', 'Green', '2023-06-19', 6, 6, 425.50),
(7, '978-9937-5695-7', 'Nepal: A Journey Through Time', 'A historical perspective on Nepals journey through time.', 'History', 1, 'Non-fiction', 'Yellow', '2023-07-01', 7, 7, 999.00),
(8, '978-9937-5695-8', 'Mountains and Monasteries', 'A journey through Nepals high mountains and ancient monasteries.', 'Travel', 1, 'Culture', 'Red', '2023-08-17', 8, 8, 789.90),
(9, '978-9937-5695-9', 'The Streets of Kathmandu', 'An account of the bustling streets of Kathmandu city.', 'Fiction', 1, 'Urban', 'Green', '2023-09-23', 9, 9, 350.00),
(10, '978-9937-5695-10', 'Nepal: Land of Gods', 'Exploring the spiritual significance of Nepals temples and rituals.', 'Religion', 1, 'History', 'Yellow', '2023-10-14', 10, 10, 549.00),
(11, '978-9937-5695-11', 'Beyond the Horizon', 'An adventure novel about climbing the highest peaks.', 'Adventure', 1, 'Travel', 'Red', '2023-11-01', 1, 2, 655.25),
(12, '978-9937-5695-12', 'The Lost City of Nepal', 'A thrilling mystery set in the ancient city of Nepal.', 'Mystery', 1, 'Fiction', 'Green', '2023-12-20', 2, 3, 725.10),
(13, '978-9937-5695-13', 'Stories from the Himalayas', 'Stories from the heart of the Himalayas.', 'Fiction', 1, 'Adventure', 'Yellow', '2024-01-10', 3, 4, 360.45),
(14, '978-9937-5695-14', 'The Golden Temple', 'A historical novel based on the famous Golden Temple of Nepal.', 'History', 1, 'Culture', 'Red', '2024-02-15', 4, 5, 410.00),
(15, '978-9937-5695-15', 'Lands of the Gods', 'An in-depth exploration of Nepals religious traditions.', 'Religion', 1, 'Culture', 'Green', '2024-03-08', 5, 6, 480.25),
(16, '978-9937-5695-16', 'Echoes of the Past', 'A reflection on Nepals historical landmarks and monuments.', 'History', 1, 'Non-fiction', 'Yellow', '2024-04-02', 6, 7, 600.00),
(17, '978-9937-5695-17', 'Walking Through Nepal', 'A travelogue documenting the beauty of Nepal.', 'Travel', 1, 'Culture', 'Red', '2024-05-23', 7, 8, 700.00),
(18, '978-9937-5695-18', 'Nepali Traditions', 'A collection of Nepali traditions and ceremonies.', 'Non-fiction', 1, 'Culture', 'Green', '2024-06-11', 8, 9, 299.75),
(19, '978-9937-5695-19', 'Legends of the Himalayas', 'Legends and myths surrounding the Himalayas and its people.', 'Fiction', 1, 'Adventure', 'Yellow', '2024-07-19', 9, 10, 525.30),
(20, '978-9937-5695-20', 'The Temple of Peace', 'A spiritual journey to one of Nepals most sacred temples.', 'Religion', 1, 'History', 'Red', '2024-08-10', 10, 1, 849.50);
INSERT INTO Books (BookID, ISBN, Title, Description, Genre, Loanable, Category, ColorTag, IssuedDate, PublisherID, AuthorID, Price)
VALUES(21, '978-9937-5695-45', 'The Temple of Peace', 'A spiritual journey to one of Nepals most sacred temples.', 'fantasy', 1, 'History', 'Red', '2024-08-10', 10, 1, 849.50);
INSERT INTO Books (BookID, ISBN, Title, Description, Genre, Loanable, Category, ColorTag, IssuedDate, PublisherID, AuthorID, Price)
VALUES(31, '978-9937-5695-75', 'The Kathmandu Chronicles', 'A story of Kathmandus rich history and culture.', 'History', 1, 'Non-fiction', 'Yellow', '2023-01-15', 1, 1, 599.99),
(28, '978-9937-5695-76', 'The Kathmandu Chronicles', 'A story of Kathmandus rich history and culture.', 'History', 1, 'Non-fiction', 'Yellow', '2023-01-15', 1, 1, 599.99),
(29, '978-9937-5695-77', 'The Kathmandu Chronicles', 'A story of Kathmandus rich history and culture.', 'History', 1, 'Non-fiction', 'Yellow', '2023-01-15', 1, 1, 599.99),
(30, '978-9937-5695-78', 'The Kathmandu Chronicles', 'A story of Kathmandus rich history and culture.', 'History', 1, 'Non-fiction', 'Yellow', '2023-01-15', 1, 1, 599.99);

CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT
);

INSERT INTO Publisher (PublisherID, PublisherName, PhoneNumber, Email, Address)
VALUES
(1, 'Kathmandu Books Pvt. Ltd.', '9801234567', 'info@kathmandubooks.com', 'Lalitpur, Kathmandu'),
(2, 'Himalaya Publishers', '9812345678', 'contact@himalayapublishers.com', 'Thamel, Kathmandu'),
(3, 'Nepal Publication House', '9823456789', 'nepalpub@gmail.com', 'Chabahil, Kathmandu'),
(4, 'Sajha Publishers', '9834567890', 'sajhapub@yahoo.com', 'Patan, Lalitpur'),
(5, 'Panchthar Press', '9845678901', 'info@panchtharpress.com', 'Maitidevi, Kathmandu'),
(6, 'MeroPustak Pvt. Ltd.', '9856789012', 'contact@meropustak.com', 'Sundhara, Kathmandu'),
(7, 'Lumbini Publications', '9867890123', 'lumbinipub@gmail.com', 'Naxal, Kathmandu'),
(8, 'Shree Harsha Publishers', '9878901234', 'info@shreeharsha.com', 'Boudha, Kathmandu'),
(9, 'Sagarmatha Books Pvt. Ltd.', '9889012345', 'sagarmathabooks@gmail.com', 'Kalanki, Kathmandu'),
(10, 'Chhavi Publications', '9890123456', 'chhavi.pub@hotmail.com', 'Kalimati, Kathmandu');


CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT
);

INSERT INTO Author (AuthorID, AuthorName, PhoneNumber, Email, Address)
VALUES
(1, 'Pradeep Sharma', '9845123456', 'pradeep.sharma@gmail.com', 'Boudha, Kathmandu'),
(2, 'Sita Rai', '9846234567', 'sita.rai@yahoo.com', 'Maitidevi, Kathmandu'),
(3, 'Dipendra Thapa', '9857345678', 'dipendra.thapa@hotmail.com', 'Jorpati, Kathmandu'),
(4, 'Anjali Koirala', '9868456789', 'anjali.koirala@gmail.com', 'Naxal, Kathmandu'),
(5, 'Kiran Adhikari', '9879567890', 'kiran.adhikari@gmail.com', 'Thamel, Kathmandu'),
(6, 'Maya Gurung', '9880678901', 'maya.gurung@hotmail.com', 'Lalitpur, Kathmandu'),
(7, 'Rohit Yadav', '9891789012', 'rohit.yadav@yahoo.com', 'Patan, Lalitpur'),
(8, 'Usha Poudel', '9802890123', 'usha.poudel@gmail.com', 'Sundhara, Kathmandu'),
(9, 'Bishal Rathi', '9813901234', 'bishal.rathi@hotmail.com', 'Chabahil, Kathmandu'),
(10, 'Nirmala Tamang', '9824012345', 'nirmala.tamang@gmail.com', 'Kalanki, Kathmandu');


CREATE TABLE LoanedBook (
    LoanID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
	LoanDate DATE,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);



INSERT INTO LoanedBook (LoanID, MemberID, BookID, LoanDate, DueDate, ReturnDate)
VALUES(13, 7, 21, '2022-06-15', '2022-07-15', '2022-07-14');
(1, 3, 7, '2022-05-01', '2022-06-01', '2022-06-03'), -- Late return
(2, 5, 10, '2023-02-10', '2023-03-10', '2023-03-09'),
(3, 8, 1, '2022-07-15', '2022-08-15', '2022-08-16'), -- Late return
(4, 3, 4, '2023-01-05', '2023-02-05', '2023-02-04'),
(5, 2, 12, '2024-04-20', '2024-05-20', '2024-05-22'), -- Late return
(6, 6, 15, '2023-09-01', '2023-10-01', '2023-10-01'),
(7, 5, 8, '2022-10-10', '2022-11-10', '2022-11-11'), -- Late return
(8, 1, 7, '2023-03-10', '2023-04-10', '2023-04-09'),
(9, 9, 3, '2024-01-20', '2024-02-20', '2024-02-20'),
(10, 7, 10, '2022-06-15', '2022-07-15', '2022-07-14');

INSERT INTO LoanedBook (LoanID, MemberID, BookID, LoanDate, DueDate, ReturnDate)
VALUES (11, 2, 10, '2022-07-15', '2022-08-15', '2022-08-19');

INSERT INTO LoanedBook (LoanID, MemberID, BookID, LoanDate, DueDate, ReturnDate)
VALUES (12, 2, 19, '2023-02-06', '2022-03-06', '2022-03-10');



select * from LoanedBook


CREATE TABLE Fine (
    FineID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    OverDueDate DATE,
    FineAmount DECIMAL(10, 2),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Fine (FineID, MemberID, BookID, OverDueDate, FineAmount)
VALUES
(1, 3, 7, '2022-06-01', DATEDIFF(DAY, '2022-06-01', '2022-06-03') * 5),  -- Member 3, BookID 7, 2 days late, fine = 10 NPR
(2, 5, 10, '2023-03-10', DATEDIFF(DAY, '2023-03-10', '2023-03-09') * 5),  -- Member 5, BookID 10, 1 day late, fine = 5 NPR
(3, 8, 1, '2022-08-15', DATEDIFF(DAY, '2022-08-15', '2022-08-16') * 5),  -- Member 8, BookID 1, 1 day late, fine = 5 NPR
(4, 2, 12, '2024-05-20', DATEDIFF(DAY, '2024-05-20', '2024-05-22') * 5); 

INSERT INTO Fine (FineID, MemberID, BookID, OverDueDate, FineAmount)
VALUES
(5, 2, 10, '2022-08-15', DATEDIFF(DAY, '2022-08-15', '2022-08-19') * 5); 

INSERT INTO Fine (FineID, MemberID, BookID, OverDueDate, FineAmount)
VALUES
(6, 2, 19, '2022-03-06', DATEDIFF(DAY, '2022-03-06', '2022-03-10') * 5); 




CREATE TABLE RoomBooking (
    ReservationID INT PRIMARY KEY,
    MemberID INT,
    RoomNo INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

INSERT INTO RoomBooking (ReservationID, MemberID, RoomNo, Date, Time)
VALUES
(1, 3, 101, '2023-05-01', '09:00:00'),
(2, 1, 105, '2023-06-15', '14:00:00'),
(3, 4, 103, '2024-01-10', '10:30:00'),
(4, 5, 102, '2024-02-20', '11:45:00'),
(5, 2, 106, '2023-11-05', '15:30:00'),
(6, 6, 104, '2024-03-25', '16:00:00'),
(7, 8, 101, '2023-08-18', '13:15:00'),  -- Same room 101 booked again
(8, 7, 108, '2022-12-12', '08:00:00'),
(9, 9, 107, '2024-04-01', '17:00:00'),
(10, 3, 103, '2023-10-22', '12:30:00');

CREATE TABLE BookReservation (
    ReservationID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    Date DATE NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


INSERT INTO BookReservation (ReservationID, MemberID, BookID, Date)
VALUES
(1, 3, 7, '2023-06-15'),  -- Member 3 reserves Book 7
(2, 1, 10, '2023-07-05'), -- Member 1 reserves Book 10
(3, 4, 5, '2023-08-20'),  -- Member 4 reserves Book 5
(4, 5, 3, '2023-09-10'),  -- Member 5 reserves Book 3
(5, 2, 12, '2023-10-01'), -- Member 2 reserves Book 12
(6, 6, 1, '2023-11-15'),  -- Member 6 reserves Book 1
(7, 8, 8, '2024-01-05'),  -- Member 8 reserves Book 8
(8, 7, 11, '2024-02-25'), -- Member 7 reserves Book 11
(9, 9, 6, '2024-03-12'),  -- Member 9 reserves Book 6
(10, 3, 4, '2024-04-20'); -- Member 3 reserves Book 4






-- Things to include (SS) in the assignment

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

EXEC sp_help 'Member';

EXEC sp_tables @table_type = "'TABLE'";

--1.List all the book names, descriptions, category name and category description that are currently not on loan and available for loan.
--The results are sorted in alphabetical order of book name.
SELECT 
    Title AS BookName, 
    Description, 
    Category, 
    Genre 
FROM Books 
WHERE Loanable = 1 
  AND BookID NOT IN (SELECT BookID FROM LoanedBook WHERE ReturnDate IS NULL)
ORDER BY Title ASC;

--2.Display the active members and list of books they have borrowed in year 2023.
--The result must consist of members’ first name, last name, book name, and the borrow date.
--Sort the result by borrow date in ascending order.
SELECT 
    LEFT(Name, CHARINDEX(' ', Name + ' ') - 1) AS FirstName,
    LTRIM(SUBSTRING(Name, CHARINDEX(' ', Name + ' '), LEN(Name))) AS LastName,
    Books.Title AS BookName,
    LoanedBook.LoanDate
FROM Member
JOIN LoanedBook ON Member.MemberID = LoanedBook.MemberID
JOIN Books ON LoanedBook.BookID = Books.BookID
WHERE Member.MemberStatus = 'Active' 
  AND YEAR(LoanedBook.LoanDate) = 2023
ORDER BY LoanedBook.LoanDate ASC;

--3.Show members who had paid overdue more than 2 times.
--The results must consist of their first name, last name, contact number, number of overdue, and total due amount.

SELECT 
    LEFT(Name, CHARINDEX(' ', Name + ' ') - 1) AS FirstName,
    LTRIM(SUBSTRING(Name, CHARINDEX(' ', Name + ' '), LEN(Name))) AS LastName,
    PhoneNo AS ContactNumber,
    COUNT(Fine.FineID) AS OverdueCount,
    SUM(Fine.FineAmount) AS TotalDueAmount
FROM Member
JOIN Fine ON Member.MemberID = Fine.MemberID
GROUP BY Name, PhoneNo
HAVING COUNT(Fine.FineID) > 2;

--4.Display the name and description of the book borrowed most in each tag color.
--Sort the result by tag color in descending order. 
ALTER TABLE Books ALTER COLUMN Description NVARCHAR(MAX);
WITH BookBorrowCount AS (
    SELECT 
        Books.BookID,
        Books.Title,
        Books.Description,
        Books.ColorTag,
        COUNT(LoanedBook.LoanID) AS BorrowCount
    FROM Books
    LEFT JOIN LoanedBook ON Books.BookID = LoanedBook.BookID
    GROUP BY Books.BookID, Books.Title, Books.Description, Books.ColorTag
),
MaxBorrowByColorTag AS (
    SELECT 
        ColorTag,
        MAX(BorrowCount) AS MaxBorrow
    FROM BookBorrowCount
    GROUP BY ColorTag
)
SELECT 
    bbc.ColorTag,
    bbc.Title,
    bbc.Description,
    bbc.BorrowCount
FROM BookBorrowCount bbc
JOIN MaxBorrowByColorTag mbt 
    ON bbc.ColorTag = mbt.ColorTag AND bbc.BorrowCount = mbt.MaxBorrow
ORDER BY bbc.ColorTag DESC;

--5.Show the genre which has the greatest number of books.
SELECT TOP 1 Genre, COUNT(*) AS BookCount
FROM Books
GROUP BY Genre
ORDER BY BookCount DESC;

--6.Show the total number of books reserved in year 2023.

SELECT COUNT(*) AS TotalBooksReserved
FROM LoanedBook
WHERE YEAR(loanDate) = 2023;

--7.Show the publisher whose books are least-in-quantity for yellow tagged books.
SELECT 
    p.PublisherName,
    COUNT(b.BookID) AS YellowBookCount
FROM 
    Books b
JOIN 
    Publisher p ON b.PublisherID = p.PublisherID
WHERE 
    b.ColorTag = 'Yellow'
GROUP BY 
    p.PublisherName
HAVING 
    COUNT(b.BookID) = (
        SELECT MIN(YellowBookCount) 
        FROM (
            SELECT 
                COUNT(b2.BookID) AS YellowBookCount
            FROM 
                Books b2
            JOIN 
                Publisher p2 ON b2.PublisherID = p2.PublisherID
            WHERE 
                b2.ColorTag = 'Yellow'
            GROUP BY 
                p2.PublisherName
        ) AS SubQuery
    );

	--8.Show the number of books written by each author,
	--sort the result according to book count (author with most books sorted on top).
	SELECT 
    a.AuthorName,
    COUNT(b.BookID) AS BookCount
FROM 
    Books b
JOIN 
    Author a ON b.AuthorID = a.AuthorID
GROUP BY 
    a.AuthorName
ORDER BY 
    BookCount DESC;

	--9.Display the name and contact number of member(s) who had at least borrowed book 
	--under genre ‘fantasy’ once.
	SELECT DISTINCT 
    Member.Name AS MemberName, 
    Member.PhoneNo AS ContactNumber
FROM Member
JOIN LoanedBook ON Member.MemberID = LoanedBook.MemberID
JOIN Books ON LoanedBook.BookID = Books.BookID
WHERE Books.Genre = 'Fantasy';

--10.Show books that cost more than RM50. Result should show name of the book, description, publisher name and publisher address.
SELECT 
    Books.Title, 
    Books.Description, 
    Publisher.PublisherName, 
    Publisher.Address
FROM Books
JOIN Publisher ON Books.PublisherID = Publisher.PublisherID
WHERE Books.Price > 50;

--11.Display the name and address of publisher(s) who had published more than 4 books.
SELECT 
    p.PublisherName, 
    CAST(p.Address AS VARCHAR(255)) AS Address
FROM Publisher p
JOIN Books b ON p.PublisherID = b.PublisherID
GROUP BY p.PublisherID, p.PublisherName, CAST(p.Address AS VARCHAR(255))
HAVING COUNT(b.BookID) > 4;


--12.Display the member(s) who had never made any room booking.
SELECT m.MemberID, m.Name
FROM Member m
LEFT JOIN RoomBooking rb ON m.MemberID = rb.MemberID
WHERE rb.ReservationID IS NULL;