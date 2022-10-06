/************************************************************************/
/* Date			Programmer			Description							*/
/*																		*/
/* 03/04/2022	ARosenberger		Initial creation of disk database	*/
/* 03/11/2022	ARosenberger		Implementing INSERT statements		*/
/* 03/18/2022	ARosenberger		Add report statements				*/
/* 03/28/2022	ARosenberger		Add stored PROCs to INSERT and 		*/
/*									UPDATE disk_has_borrower			*/
/* 03/30/2022	ARosenberger		Add SP's to INSERT, UPDATE and 		*/
/*									DELETE borrower and disk			*/
/*																		*/
/************************************************************************/
USE master;
GO
DROP DATABASE IF EXISTS diskInventoryAR;
GO
CREATE DATABASE diskInventoryAR; --Example was disk_inventoryjw
GO
--Add server user
IF SUSER_ID('diskUserar') IS NULL
	CREATE LOGIN diskUserar
	WITH PASSWORD = 'Pa$$w0rd', 
	DEFAULT_DATABASE = diskInventoryAR
USE diskInventoryAR;
GO
--Add database user
CREATE USER diskUserar;
ALTER ROLE db_datareader
	ADD MEMBER diskUserar;
GO
--Create lookup tables
CREATE TABLE disk_type (
	disk_type_id	INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
); --CD, DVD, Vinyl, 8track, Cassette
CREATE TABLE genre (
	genre_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
); --Country, Folk, Indie Rock, Alternative, etc.
CREATE TABLE status (
	status_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
); --Available, On Loan, Damaged, Missing, Unavailable
CREATE TABLE borrower (
	borrower_id		INT NOT NULL IDENTITY PRIMARY KEY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NOT NULL,
	phone_num		VARCHAR(15) NOT NULL
);
CREATE TABLE disk (
	disk_id			INT NOT NULL IDENTITY PRIMARY KEY,
	disk_name		NVARCHAR(60) NOT NULL,
	release_date	DATE NOT NULL,
	genre_id		INT NOT NULL REFERENCES genre(genre_id),
	status_id		INT NOT NULL REFERENCES status(status_id),
	disk_type_id	INT NOT NULL REFERENCES disk_type(disk_type_id)
);
CREATE TABLE disk_has_borrower (
	disk_has_borrower_id		INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_id					INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id						INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date				DATETIME2 NOT NULL,
	returned_date				DATETIME2 NULL
);

-- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ --
-- Project 3
-- Start insert statements, insert data into disk_type
-- c. Disk_type, Genre, & Status – insert 5+ rows into each using real-world data
INSERT INTO disk_type
	(description)
VALUES
	('CD'),
	('Vinyl'),
	('8track'),
	('Cassette'),
	('DVD');
INSERT INTO genre
	(description)
VALUES
	('Alternative'),
	('Indie Rock'),
	('Folk'),
	('Electro Swing'),
	('Metal');
INSERT INTO status
	(description)
VALUES
	('Available'),
	('On Loan'),
	('Damaged'),
	('Missing'),
	('Unavailable');
-- e. 1. Insert 21 borrowers
-- 1.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Nick', 'Nack', '760-000-0001');
-- 2.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Ovaltine', 'Jenkins', '760-000-0002');
-- 3.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Shmuel', 'Cohen', '760-000-0003');
-- 4.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Galileo', 'Humpkins', '760-000-0004');
-- 5.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Lavender', 'Gooms', '760-000-0005');
-- 6.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Lemongrass', 'Gogulope', '760-000-0006');
-- 7.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Methuselah', 'Honeysuckle', '760-000-0007');
-- 8.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Chesterfield', 'McMillan', '760-000-0008');
-- 9.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Longbranch', 'Pennywhistle', '760-000-0009');
-- 10.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Scrooge', 'Jones', '760-000-0010');
-- 11.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Hummingbird', 'Saltalamacchia', '760-000-0011');
-- 12.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Doughnut', 'Holschtein', '760-000-0012');
-- 13.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Ghee', 'Buttersnaps', '760-000-0013');
-- 14.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Clementine', 'Woollysocks', '760-000-0014');
-- 15.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Jingleheimer', 'Schmidt', '760-000-0015');
-- 16.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Santonio', 'Holmes', '760-000-0016');
-- 17.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Gurton', 'Buster', '760-000-0017');
-- 18.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Burton', 'Guster', '760-000-0018');
-- 19.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Yasmine', 'Bleeth', '760-000-0019');
-- 20.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Karl', 'Rotmensen', '760-000-0020');
-- 21.
INSERT INTO borrower
	(fname, lname, phone_num)
VALUES
	('Flapjack', 'Palmdale', '760-000-0021');
-- e. 2. Delete only 1 borrower row using a WHERE clause
DELETE borrower
WHERE borrower_id = 21;
-- d. 1. Insert at least 20 rows of disk data into the table using real-world disk names
-- 1.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Feel Good Inc', '1/1/2005', 1, 1, 1);
-- 2.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('DARE', '1/2/2005', 1, 3, 1);
-- 3.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Momentary Bliss', '1/3/2020', 1, 1, 3);
-- 4.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Good Bad Times', '1/4/2020', 2, 1, 2);
-- 5.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Drive', '1/5/2014', 3, 1, 1);
-- 6.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Janie in Love ', '1/6/2016', 3, 3, 1);
-- 7.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Blue Vapor', '1/7/2018', 3, 1, 1);
-- 8.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('For the Sun', '1/8/2019', 3, 1, 1);
-- 9.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Firecrackers', '1/9/2015', 3, 1, 1);
-- 10.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Nothing in My Heart', '1/10/2015', 3, 1, 1);
-- 11.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Was It a Dream', '1/11/2015', 3, 1, 1);
-- 12.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('END', '1/12/2021', 2, 1, 2);
-- 13.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('THIS IS CHAI', '1/13/2021', 2, 1, 2);
-- 14.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('NO MORE CAKE', '1/14/2020', 2, 1, 2);
-- 15.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Jolie Coquine', '1/15/2012', 4, 2, 4);
-- 16.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Lone Digger', '1/16/2015', 4, 1, 4);
-- 17.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Comics', '1/17/2015', 4, 1, 4);
-- 18.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Wonderland', '1/18/2016', 4, 2, 4);
-- 19.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Detroit Rock City', '1/19/2008', 5, 1, 3);
-- 20.
INSERT disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Suzy', '1/20/2012', 4, 1, 4);
-- d. 2. Update only 1 disk row using a WHERE clause
UPDATE disk
SET release_date = '1/21/2022'
WHERE disk_name = 'END';
-- f. Insert borrowed rows DiskHasBorrowerTable
INSERT disk_has_borrower
	(borrower_id, disk_id, borrowed_date, returned_date)
VALUES
	(1, 1, '1-10-2019', '2-15-2019'),
	(3, 5, '3-20-2019', '4-25-2019'),
	(1, 1, '5-5-2019', '6-10-2019'),
	(17, 15, '7-15-2019', NULL),
	(14, 11, '8-20-2019', '9-25-2019'), -- 5.
	(5, 3, '10-5-2019', '11-10-2019'),
	(4, 3, '12-15-2019', '1-20-2020'),
	(1, 9, '2-25-2020', '3-5-2020'),
	(10, 1, '4-10-2020', '5-15-2020'),
	(16, 1, '6-20-2020', '7-25-2020'), -- 10.
	(1, 1, '8-5-2020', '9-10-2020'),
	(18, 18, '10-15-2020', NULL),
	(1, 8, '11-20-2020', '12-25-2020'),
	(1, 20, '1-5-2021', '2-10-2021'),
	(19, 13, '3-15-2021', '4-20-2021'), -- 15.
	(2, 2, '5-25-2021', '6-5-2021'),
	(10, 1, '7-10-2021', '8-15-2021'),
	(7, 4, '9-20-2021', '10-25-2021'),
	(7, 6, '11-5-2021', '12-10-2021'),
	(1, 16, '1-15-2022', '2-20-2022') -- 20.
;
-- g. Create a query to list the disks that are on loan and have not been returned
SELECT borrower_id AS Borrower_id, disk_id as Disk_id,
	CAST(borrowed_date AS date) AS Borrowed_date, returned_date AS Return_date
FROM disk_has_borrower
WHERE returned_date IS NULL;

-- After testing, push file to GitHub
-- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ --
-- Project 4
-- 1. Show all disks in your database, the type and status.
-- Use the disk, disk_type, genre and status tables.
SELECT 'Disk Name' = disk_name, release_date,
	disk_type.description, genre.description, status.description -- Check column names and format
FROM disk
JOIN disk_type
	ON disk.disk_type_id = disk_type.disk_type_id
JOIN genre
	ON disk.genre_id = genre.genre_id
JOIN status
	ON disk.status_id = status.status_id
ORDER BY disk_name
;
-- 2. Show all borrowed disks and who borrowed them.
SELECT lname, fname, disk_name, borrowed_date, returned_date -- Check column names
FROM disk_has_borrower
JOIN borrower
	ON disk_has_borrower.borrower_id = borrower.borrower_id
JOIN disk
	ON disk_has_borrower.disk_id = disk.disk_id
ORDER BY lname
;
-- 3. Show the disks that have been borrowed more than once.
SELECT disk_name, COUNT(*)
FROM disk_has_borrower
JOIN disk
	ON disk_has_borrower.disk_id = disk.disk_id
GROUP BY disk_name
HAVING COUNT(*) > 1
ORDER BY disk_name
;
-- 4. Show the disks outstanding or on loan and who took each disk.
SELECT disk_name, borrowed_date, returned_date, lname, fname
FROM disk
JOIN disk_has_borrower
	ON disk.disk_id = disk_has_borrower.disk_id
JOIN borrower
	ON borrower.borrower_id = disk_has_borrower.borrower_id
WHERE returned_date IS NULL
ORDER BY disk_name
;
GO
-- 5. Create a view called View_Borrower_No_Loans that shows the borrowers who have not borrowed a disk. Include the borrower_id in the view definition but do not display the id in your output.
-- Could be done with a correlated subquery using exists, non-correlated subquery using in, or and outer join.
CREATE VIEW View_Borrower_No_Loans
AS
	SELECT borrower_id, lname, fname
	FROM borrower
	WHERE borrower_id NOT IN
		(SELECT DISTINCT borrower_id
		FROM disk_has_borrower)
;
GO
SELECT lname, fname -- Check column names
FROM View_Borrower_No_Loans
ORDER BY lname, fname
;
-- 6. Show the borrowers who have borrowed more than 1 disk.
SELECT lname, fname, COUNT(disk_id) -- Check column names
FROM disk_has_borrower
JOIN borrower
	ON borrower.borrower_id = disk_has_borrower.borrower_id
GROUP BY lname, fname
HAVING COUNT(*) > 1
ORDER BY lname, fname

-- Push to GitHub

-- Chapter 15 Lab (28, March 2022 Monday)
-- Create 2 stored procedures:
	-- Insert into diskHasBorrower. Parameters for all columns except the PK.
	-- Update to diskHasBorrower. Accept all columns & updates based on the PK. Set a default value of null for the return date.
	-- Include drop logic, error checking, and execution statements (1 that works & 1 that generates a user error).
	-- Grant execute permission to your disk_inventory user.

USE diskInventoryAR;
-- Create PROC sp_ins_disk_has_borrower
DROP PROC IF EXISTS sp_ins_disk_has_borrower;
GO

CREATE PROC sp_ins_disk_has_borrower
	@borrower_id INT, @disk_id INT, @borrowed_date DATETIME2, @returned_date DATETIME2 = NULL
AS
BEGIN TRY
	INSERT disk_has_borrower
		(borrower_id, disk_id, borrowed_date, returned_date)
	VALUES
		(@borrower_id, @disk_id, @borrowed_date, @returned_date);
END TRY
BEGIN CATCH
	PRINT 'An error occurred.'
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXEC ON sp_ins_disk_has_borrower TO diskUserar;
GO
sp_ins_disk_has_borrower 2, 3, '3-27-2022', '3-28-2022'
GO
sp_ins_disk_has_borrower 4, 5, '3-27-2022'
GO
sp_ins_disk_has_borrower 44, 5, '3-27-2022'
GO

DROP PROC IF EXISTS sp_upd_disk_has_borrower;
GO
CREATE PROC sp_upd_disk_has_borrower
	@disk_has_borrower_id INT, @borrower_id INT, @disk_id INT, @borrowed_date DATETIME2, @returned_date DATETIME2 = NULL
AS
BEGIN TRY
	UPDATE disk_has_borrower
	SET borrower_id = @borrower_id,
		disk_id = @disk_id,
		borrowed_date = @borrowed_date,
		returned_date = @returned_date
	WHERE disk_has_borrower_id = @disk_has_borrower_id;
END TRY
BEGIN CATCH
	PRINT 'An error occurred.'
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXEC ON sp_upd_disk_has_borrower TO diskUserar;
GO
DECLARE @today DATETIME2 = GETDATE();
EXEC sp_upd_disk_has_borrower 25, 2, 3, '3-13-2022', @today;
GO
sp_upd_disk_has_borrower 25, 2, 3, '2-22-2022';
GO
sp_upd_disk_has_borrower 25, 44, 3, '2-22-2022';
GO
-- Push to GitHub

-- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~-- ~~ -- ~~ -- ~~ -- ~~
-- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~-- ~~ -- ~~ -- ~~ -- ~~
-- Create Insert, Update, and Delete stored procedures for the disk table. Update procedure accepts input parameters for all columns. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete.
DROP PROC IF EXISTS sp_ins_disk;
GO
CREATE PROC sp_ins_disk
	@disk_name NVARCHAR(60), @release_date DATE, @genre_id INT, @status_id INT, @disk_type_id INT
AS
	BEGIN TRY
		INSERT disk
		(disk_name, release_date, genre_id, status_id, disk_type_id)
		VALUES
		(@disk_name, @release_date, @genre_id, @status_id, @disk_type_id);
	END TRY
	BEGIN CATCH
		PRINT 'An error occurrred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO
-- Add grant permissions
GRANT EXECUTE ON sp_ins_disk TO diskUserar;
GO
EXEC sp_ins_disk 'Toxic', '2/2/2003', 4, 1, 1
GO -- Works without error
EXEC sp_ins_disk 'Toxic', '2/2/2003', 4, 1, NULL
GO -- Generates controlled error

DROP PROC IF EXISTS sp_upd_disk;
GO
CREATE PROC sp_upd_disk
		@disk_id INT, @disk_name NVARCHAR(60), @release_date DATE, @genre_id INT, @status_id INT, @disk_type_id INT
AS
	BEGIN TRY
		UPDATE disk
		SET disk_name = @disk_name,
			release_date = @release_date,
			genre_id = @genre_id,
			status_id = @status_id,
			disk_type_id = @disk_type_id
		WHERE disk_id = @disk_id;
	END TRY
	BEGIN CATCH
		PRINT 'An error occurrred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO
-- Add grant permissions
GRANT EXECUTE ON sp_upd_disk TO diskUserar;
GO
EXEC sp_upd_disk 21, 'Toxic', '2003-1-1', 5, 4, 3
GO -- Updates without error
EXEC sp_upd_disk 21, 'Toxic', NULL, 5, 4, 3
GO -- Controlled error

DROP PROC IF EXISTS sp_del_disk;
GO
CREATE PROC sp_del_disk
	@disk_id INT
AS
	BEGIN TRY
		DELETE FROM [dbo].[disk]
			WHERE disk_id = @disk_id;
	END TRY
	BEGIN CATCH
		PRINT 'An error occurrred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO
-- Add permissions
GRANT EXECUTE ON sp_del_disk TO diskUserar;
GO
EXEC sp_del_disk 21; -- Works without error
GO
EXEC sp_del_disk 3; -- Controlled error
GO
-- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~-- ~~ -- ~~ -- ~~ -- ~~
-- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~ -- ~~-- ~~ -- ~~ -- ~~ -- ~~
-- Create Insert, Update, and Delete stored procedures for the borrower table. Update procedure accepts input parameters for all columns. Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete
DROP PROC IF EXISTS sp_ins_borrower
GO
CREATE PROC sp_ins_borrower
	@fname NVARCHAR(60), @lname NVARCHAR(60), @phone_num VARCHAR(15)
AS
	BEGIN TRY
		INSERT borrower
		(fname, lname, phone_num)
		VALUES
		(@fname, @lname, @phone_num);
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

-- Add Grant Permissions
GRANT EXECUTE ON sp_ins_borrower TO diskUserar;
GO
EXEC sp_ins_borrower 'Gusjay', 'Gupta', '760-000-0022'
GO -- Updates without error
EXEC sp_ins_borrower 'Gusjay', 'Gupta', NULL
GO -- Controlled error

DROP PROC IF EXISTS sp_upd_borrower
GO
CREATE PROC sp_upd_borrower
	@borrower_id INT, @fname NVARCHAR(60), @lname NVARCHAR(60), @phone_num VARCHAR(15)
AS
	BEGIN TRY
		UPDATE borrower
		SET fname = @fname,
			lname = @lname,
			phone_num = @phone_num
		WHERE borrower_id = @borrower_id;
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

-- Add grant permissions
GRANT EXECUTE ON sp_upd_borrower TO diskUserar;
GO
EXEC sp_upd_borrower 22, 'Mission', 'Figgs', '760-000-0022'
GO -- Updates without error
EXEC sp_upd_borrower 22, 'Mission', 'Figgs',  NULL
GO -- Controlled error

DROP PROC IF EXISTS sp_del_borrower;
GO

CREATE PROC sp_del_borrower
@borrower_id INT
AS
	BEGIN TRY
		DELETE FROM borrower
			WHERE borrower_id = @borrower_id;
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

-- Add grant permissions
GRANT EXECUTE ON sp_del_borrower TO diskUserar;
GO
EXEC sp_del_borrower 22;
GO -- Deletes without error
EXEC sp_del_borrower 19;
GO -- Controlled error

