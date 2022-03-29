
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

