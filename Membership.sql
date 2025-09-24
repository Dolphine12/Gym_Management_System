-- Create Database
Create Database GymManagement;
Use GymManagement;
-- Create table for gym memberships
CREATE TABLE Memberships (
	MembershipID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT NOT NULL,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) NOT NULL UNIQUE,
	Phone NVARCHAR(20),
	MembershipType NVARCHAR(50) NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	Status NVARCHAR(20) NOT NULL,
	CreatedAt DATETIME DEFAULT GETDATE(),
	UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Index for fast lookup by UserID
CREATE INDEX IDX_UserID ON Memberships(UserID);

-- CRUD Operations

-- CREATE: Add a new membership
INSERT INTO Memberships (UserID, FullName, Email, Phone, MembershipType, StartDate, EndDate, Status)
VALUES (@UserID, @FullName, @Email, @Phone, @MembershipType, @StartDate, @EndDate, @Status);

-- READ: Get membership by MembershipID
SELECT * FROM Memberships WHERE MembershipID = @MembershipID;

-- READ: Get all memberships (with pagination for large datasets)
SELECT * FROM Memberships ORDER BY MembershipID OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;

-- UPDATE: Update membership details
UPDATE Memberships
SET FullName = @FullName,
	Email = @Email,
	Phone = @Phone,
	MembershipType = @MembershipType,
	StartDate = @StartDate,
	EndDate = @EndDate,
	Status = @Status,
	UpdatedAt = GETDATE()
WHERE MembershipID = @MembershipID;

-- DELETE: Remove a membership
DELETE FROM Memberships WHERE MembershipID = @MembershipID;
