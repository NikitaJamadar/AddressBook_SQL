
 create database Address_Book; --UC1 Ability to create a Address Book Service DataBase

 --UC2 Ability to create a Address Book Table with first and last name, address, city, state, zipcode, phone number and email as its attributes
create table Address_Book(
Id int identity(1,1) primary key,
first_name varchar(255),
last_name varchar(255),
Address varchar(255),
City varchar(50),
State varchar(50),
ZipCode int,
Phone_No bigint,
Email_Id varchar(255)
);

select * from Address_Book;

--UC3 Insert contacts in table
insert into Address_Book values('Nikita','Jamadar','Mulaj','Omerga','Maharashtra',442406,123456789,'nikita@gmail.com');
insert into Address_Book values('Aaaa','patil','dabka','Satara','Maharashtra',4112334,987654321,'aaa@gmail.com');
insert into Address_Book values('Ammmm','nnnn','Lahore','Sangli','Maharashtra',310943,0965423464,'dddd@gmail.com');
insert into Address_Book values('Kkk','Nnnn','Gandhi Chowk ','Solapur','Maharashtra',411232,5783297382,'rrr@gmail.com');
insert into Address_Book values('Virat','Kohli','Shivaji Chowk','Pune','Maharashtra',127431,9174829526,'cccc@gmail.com');

--UC4 Edit existing contact using name
UPDATE Address_Book SET first_name = 'Ranjeet' , last_name = 'Bhosale', Email_Id = 'ranjeet@gmail.com' where first_name = 'Virat';


--UC5 Delete person using first name
delete from Address_Book where City = 'Pune';

--UC6 Ability to retrieve person belonging to a city or state 
select * from Address_Book where City='Sangli';

--UC7 Count size of addressbook by city and state
select count(City) as TotalContact from Address_Book;  

--UC8 Ability to retrieve entries sorted  alphabetically by person's name for a given city
select * from Address_Book where State='Maharashtra' order by (first_name);

--UC9 Altering Address Book to add new columns, Address Book Name and Type of contacts
alter table Address_Book add addressBookType varchar(30), AddressBookName varchar(40);
update Address_Book set addressBookType = 'Friends' where City ='Sangli';
update Address_Book set addressBookName = 'BookRecords';
update Address_Book set addressBookType = 'Family' where last_name ='Patil';
update Address_Book set addressBookType = 'Profession' where addressBookType is null;

select * from Address_Book;

--UC10 Getting number of contact persons for each ContactType
select addressBookType, count(addressBookType) as NumberOfContacts from Address_Book group by addressBookType;

--UC11 Ability to add person to both Friend and Family
insert into Address_Book values('Ajay', 'Yadav','CSTM','Mumbai', 'Maharashtra', 214566,941144333, 'adhar@gmail.com','Family','BookRecords');

--UC12 Drawing ER diagrams
DROP TABLE Address_Book;

CREATE TABLE AddressBookNameT
(
AddressBookId INT IDENTITY (1,1) PRIMARY KEY,
AddressBookName VARCHAR(50)
);

INSERT INTO AddressBookNameT
VALUES('NIKU'),('MAHI');
SELECT * FROM AddressBookNameT;

CREATE TABLE PersonDetails
(
PersonID INT IDENTITY (1,1) PRIMARY KEY,
FirstName VARCHAR(30),
LastName VARCHAR(50),
Addresss VARCHAR(150),
City VARCHAR(50),
StateName VARCHAR (50),
Zip INT,
PhoneNo BIGINT,
Email VARCHAR(60),
AddressBookSelect INT,
FOREIGN KEY (AddressBookSelect) REFERENCES AddressBookNameT(AddressBookId)
);
SELECT * FROM PersonDetails

INSERT INTO PersonDetails
VALUES
('Chiku','Patil','Mulaj','Omerga','Maharashtra',123456,11111111111,'chiku@gmail.com',1),
('Ashish','Bhosale','Pune','puna','maha',321456,333333333333,'ashish@gmail.com',1),
('Akshata','Nadde','Bidar','Kalyan','Karnataka',345678,45678904321,'akshata@gmail.com',2),
('Mahi','Mammale','chincholi','Solapur','Karna',367890,234567890,'mahi@gmail.com',2);

CREATE TABLE AddressBookType
(
TypeID INT IDENTITY (1,1) PRIMARY KEY,
TypeName VARCHAR(30)
);

INSERT INTO AddressBookType
VALUES ('Friend'),('Professional'),('Family');

SELECT * FROM AddressBookType

CREATE TABLE AddressBookTypeTable
(
TypeSelect INT,
PersonSelect INT,
FOREIGN KEY (TypeSelect) REFERENCES AddressBookType(TypeID),
FOREIGN KEY (PersonSelect) REFERENCES PersonDetails(PersonID)
)

INSERT INTO AddressBookTypeTable
VALUES (1,1),(2,2),(3,2),(1,2),(2,3),(3,3);
SELECT * FROM AddressBookTypeTable

--UC12 Retriving data
SELECT PersonID,AddressBookName,FirstName,LastName,Addresss,City,StateName,Zip,PhoneNo,Email,TypeName FROM AddressBookNameT
INNER JOIN PersonDetails ON AddressBookNameT.AddressBookId = PersonDetails.AddressBookSelect
INNER JOIN AddressBookTypeTable ON PersonDetails.PersonID = AddressBookTypeTable.PersonSelect
INNER JOIN AddressBookType ON AddressBookTypeTable.TypeSelect = AddressBookType.TypeID

--UC13 Retrieving All data in Prevoius UC's
--Retrieving data from A Particular City or State
SELECT PersonID,AddressBookName,FirstName,LastName,Addresss,City,StateName,Zip,PhoneNo,Email,TypeName FROM AddressBookNameT
INNER JOIN PersonDetails ON AddressBookNameT.AddressBookId = PersonDetails.AddressBookSelect AND (City = 'Omerga' AND StateName='Maharashtra')
INNER JOIN AddressBookTypeTable ON PersonDetails.PersonID = AddressBookTypeTable.PersonSelect
INNER JOIN AddressBookType ON AddressBookTypeTable.TypeSelect = AddressBookType.TypeID

SELECT COUNT(*),City FROM PersonDetails GROUP BY City
SELECT COUNT(*),City,StateName FROM PersonDetails GROUP BY City,StateName

--Sort address book Alphabatically by First Name
SELECT PersonID,AddressBookName,CONCAT(FirstName,' ',LastName) AS FullName,CONCAT(Addresss,',',City,',',StateName,',',Zip) AS FullAddress,PhoneNo,Email,TypeName FROM PersonDetails
INNER JOIN AddressBookNameT ON AddressBookNameT.AddressBookId = PersonDetails.AddressBookSelect
INNER JOIN AddressBookTypeTable ON PersonDetails.PersonID = AddressBookTypeTable.PersonSelect
INNER JOIN AddressBookType ON AddressBookTypeTable.TypeSelect = AddressBookType.TypeID
ORDER BY FirstName
