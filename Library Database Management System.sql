
/******************************************************************************************/
/*                        PROJECT Library Database Management Sy                          */

/*                                  WED,FEB 2025CE                                        */

/*                             BY : MOHAMMMAD AL-SHORMAN                                  */

/*******************************************************************************************/


/************************************************************************************************/

CREATE DATABASE LibraryDB;

/************************************************************************************************/


/***************************************************/
/*                      TEST                      */
/*                                                 */
/* SELECT *  FROM Books;                           */
/* SELECT *  FROM Members;                         */
/* SELECT *  FROM LibraryStaff;                    */
/* SELECT *  FROM Categories;                      */                        
/* SELECT *  FROM Reservations;                    */
/* SELECT *  FROM FinancialFines;                  */      
/* SELECT *  FROM MemberBook                       */
/***************************************************/



CREATE TABLE Books (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(255) NOT NULL,
    Genre NVARCHAR(100),
    PublicationYear INT,
    AvailabilityStatus NVARCHAR(50) CHECK (AvailabilityStatus IN ('Available', 'Borrowed'))
);



CREATE TABLE Members (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    ContactInfo NVARCHAR(255),
    MembershipType NVARCHAR(50) CHECK (MembershipType IN ('Student', 'Teacher', 'Visitor')),
    RegistrationDate DATE
);

CREATE TABLE LibraryStaff (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    ContactInfo NVARCHAR(255),
    AssignedSection NVARCHAR(100),
    EmploymentDate DATE
);

CREATE TABLE Categories (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);

CREATE TABLE Reservations (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BookID INT FOREIGN KEY REFERENCES Books(ID),
    ReservationDate DATE,
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Cancelled', 'Completed'))
);

CREATE TABLE FinancialFines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    Amount DECIMAL(10,2) CHECK (Amount >= 0),
    PaymentStatus NVARCHAR(50) CHECK (PaymentStatus IN ('Paid', 'Unpaid'))
);

CREATE TABLE MemberBook (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BookID INT FOREIGN KEY REFERENCES Books(ID),
    BorrowingDate DATE,
    DueDate DATE,
    ReturnDate DATE NULL
);


/***************************************************************************/

INSERT INTO Books (Title, Author, Genre, PublicationYear, AvailabilityStatus) VALUES
('Database Fundamentals', 'John Smith', 'Technology', 2020, 'Available'),
('SQL for Beginners', 'Jane Doe', 'Education', 2019, 'Available'),
('C# Programming', 'Mark Johnson', 'Programming', 2018, 'Borrowed'),
('Python Essentials', 'Emily Davis', 'Technology', 2021, 'Available'),
('Data Structures and Algorithms', 'Michael Brown', 'Computer Science', 2017, 'Available');

INSERT INTO Members (Name, ContactInfo, MembershipType, RegistrationDate) VALUES
('Alice Johnson', 'alice@example.com', 'Student', '2024-01-01'),
('Bob Williams', 'bob@example.com', 'Teacher', '2023-05-10'),
('Charlie Brown', 'charlie@example.com', 'Visitor', '2022-09-15'),
('David Miller', 'david@example.com', 'Student', '2024-02-05'),
('Emma Wilson', 'emma@example.com', 'Teacher', '2023-07-20');

INSERT INTO LibraryStaff (Name, ContactInfo, AssignedSection, EmploymentDate) VALUES
('John Carter', 'john.carter@example.com', 'Fiction', '2015-06-10'),
('Sarah Adams', 'sarah.adams@example.com', 'Science', '2017-03-22'),
('Michael Reed', 'michael.reed@example.com', 'Technology', '2018-11-05'),
('Jessica Hall', 'jessica.hall@example.com', 'History', '2019-08-30'),
('Daniel Lewis', 'daniel.lewis@example.com', 'Children', '2021-04-12');

INSERT INTO Categories (Name, Description) VALUES
('Science Fiction', 'Books related to futuristic concepts and science advancements'),
('History', 'Books covering historical events and analysis'),
('Technology', 'Books discussing technological developments'),
('Education', 'Educational and academic materials'),
('Programming', 'Books about software development and coding techniques');


INSERT INTO Reservations (MemberID, BookID, ReservationDate, Status) VALUES
(1, 2, '2024-02-01', 'Pending'),
(3, 4, '2024-01-15', 'Completed'),
(2, 1, '2024-03-05', 'Cancelled'),
(5, 3, '2024-02-20', 'Pending'),
(4, 5, '2024-01-30', 'Completed');

INSERT INTO FinancialFines (MemberID, Amount, PaymentStatus) VALUES
(1, 5.00, 'Paid'),
(2, 10.00, 'Unpaid'),
(3, 7.50, 'Paid'),
(4, 12.00, 'Unpaid'),
(5, 3.00, 'Paid');

INSERT INTO MemberBook (MemberID, BookID, BorrowingDate, DueDate, ReturnDate) VALUES
(1, 3, '2024-01-05', '2024-01-20', '2024-01-22'),
(2, 5, '2024-02-10', '2024-02-25', NULL),
(3, 1, '2024-01-15', '2024-02-01', '2024-02-02'),
(4, 2, '2024-03-01', '2024-03-15', NULL),
(5, 4, '2024-02-20', '2024-03-05', '2024-03-06');



/************************************************************************************************/
/*                                       SOLVE                                                  */
/************************************************************************************************/



-- 1. Select members who registered on a specific date

SELECT * FROM Members WHERE RegistrationDate = '2024-01-01';


-- 2. Select details of a book by its title "Database Fundamentals"

SELECT * FROM Books WHERE Title = 'Database Fundamentals';

-- 3. Add a new column ‘Email’ to the Members table

ALTER TABLE Members ADD Email NVARCHAR(255);

SELECT * FROM Members;


-- 4. Insert a new member record
INSERT INTO Members (Name, ContactInfo, MembershipType, RegistrationDate, Email) 
VALUES ('Omar', '9876543210', 'Student', '2024-06-05', 'Omar@gmail.com');

SELECT * FROM Members;



-- 5.. Select members who have reservations in the system
SELECT DISTINCT Members.* FROM Members 
JOIN Reservations ON Members.ID = Reservations.MemberID;

-- 6. . Select members who have borrowed a specific book TITLE "SQL for Beginners"
SELECT DISTINCT Members.* FROM Members 
JOIN MemberBook ON Members.ID = MemberBook.MemberID 
JOIN Books ON MemberBook.BookID = Books.ID 
WHERE Books.Title = 'SQL for Beginners';

-- 7. Select members who have borrowed and returned a specific book "C# Programming"
SELECT DISTINCT Members.* FROM Members 
JOIN MemberBook ON Members.ID = MemberBook.MemberID 
JOIN Books ON MemberBook.BookID = Books.ID 
WHERE Books.Title = 'C# Programming' AND MemberBook.ReturnDate IS NOT NULL;

-- 8. Find members who made a late return
SELECT DISTINCT Members.* FROM Members 
JOIN MemberBook ON Members.ID = MemberBook.MemberID 
WHERE MemberBook.ReturnDate > MemberBook.DueDate;

-- 9.Select books borrowed more than 3 times
SELECT Books.Title, COUNT(MemberBook.BookID) AS BorrowCount FROM MemberBook 
JOIN Books ON MemberBook.BookID = Books.ID 
GROUP BY Books.Title HAVING COUNT(MemberBook.BookID) > 3;

INSERT INTO MemberBook (MemberID, BookID, BorrowingDate, DueDate, ReturnDate) VALUES
(1, 3, '2024-01-05', '2024-01-20', '2024-01-22'),
(2, 3, '2024-02-10', '2024-02-25', NULL),
(3, 3, '2024-03-01', '2024-03-15', NULL),
(4, 3, '2024-03-20', '2024-04-05', NULL),
(5, 3, '2024-04-10', '2024-04-25', NULL);


--SELECT * FROM MemberBook;

-- 10. Find members who have borrowed books between two dates
SELECT DISTINCT Members.* FROM Members 
JOIN MemberBook ON Members.ID = MemberBook.MemberID 
WHERE MemberBook.BorrowingDate BETWEEN '2024-01-01' AND '2024-01-10';

-- 11. Count the total number of books in the library
SELECT COUNT(*) AS TotalBooks FROM Books;

-- 12.. (Optional)Find members who have borrowed books but not returned them
SELECT DISTINCT Members.* FROM Members 
JOIN MemberBook ON Members.ID = MemberBook.MemberID 
WHERE MemberBook.ReturnDate IS NULL;

-- 13. (Optional)Find members who have borrowed books in a specific category "Science Fiction"
SELECT DISTINCT Members.* FROM Members 
JOIN MemberBook ON Members.ID = MemberBook.MemberID 
JOIN Books ON MemberBook.BookID = Books.ID 
JOIN Categories ON Books.Genre = Categories.Name 
WHERE Categories.Name = 'Education';

