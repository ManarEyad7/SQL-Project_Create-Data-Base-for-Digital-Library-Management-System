/*--------------------------------------------------------------------------*/
create table AUTHOR (
Author_ID number(5), 
Author_Name varchar(20),
Author_Phone varchar(15) not null unique,
Author_Email varchar(30) not null unique
);
--Alter Table-------------------------------------------------------------------
alter table AUTHOR add constraint ATH_PK primary key(Author_ID); 

INSERT INTO AUTHOR VALUES (10001, 'Mark Styles', '0514559632', 'MarkStyles@gmail.com'); 
INSERT INTO AUTHOR VALUES (10002, 'Henry Evans', '0589665472', 'HenryEvans@gmail.com'); 
INSERT INTO AUTHOR VALUES (10003, 'Harvey Specter', '059648512', 'HarveySpecter@gmail.com'); 
INSERT INTO AUTHOR VALUES (10004, 'Sebastian Stan', '0596445827', 'SebastianStan@gmail.com'); 
INSERT INTO AUTHOR VALUES (10005, 'Stiles Stilinski', '0585669748', 'StilesStilinski@gmail.com'); 
INSERT INTO AUTHOR VALUES (10006, 'AymanOtoom', '053953536', 'AymanOtoom@gmail.com'); 
INSERT INTO AUTHOR VALUES (10007, 'Jennifer Armentrout', '0555146584', 'JenniferArt@gmail.com'); 

Select * from AUTHOR;


/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table PUBLISHER (
Publisher_ID number(5), 
Publisher_Name varchar(20),
Publisher_Phone varchar(15) not null unique,
Publisher_Email varchar(30) not null unique
);
--Alter Table-------------------------------------------------------------------
alter table PUBLISHER add constraint PUB_PK primary key(Publisher_ID); 

INSERT INTO PUBLISHER VALUES (24008, 'Jarir', '055223648', 'Jarir@gmail.com');
INSERT INTO PUBLISHER VALUES (24007, 'Rndom House', '054778451', 'RndomHouse@gmail.com');
INSERT INTO PUBLISHER VALUES (24001, 'HarperCollins', '054996785', 'HarperCollins@gmail.com');
INSERT INTO PUBLISHER VALUES (24002, 'Scholastic', '05996488', 'Scholastic@gmail.com');
INSERT INTO PUBLISHER VALUES (24003, 'aseeralkotb', '056584541', 'aseeralkotb@gmail.com');
INSERT INTO PUBLISHER VALUES (24004, 'Dar al Faris', '0559874584', 'Dar al Faris@gmail.com');
INSERT INTO PUBLISHER VALUES (24005, 'Pearsson', '058974528', 'Pearsson@gmail.com');

Select * from PUBLISHER;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table BOOK_CATEGORY (

Category_Name varchar(20), 
Age_Classification number(2)

);
--Alter Table-------------------------------------------------------------------
alter table BOOK_CATEGORY add constraint BC_PK primary key(Category_Name); 

INSERT INTO BOOK_CATEGORY VALUES ('Fantasy', 12);
INSERT INTO BOOK_CATEGORY VALUES ('Kids', 7);
INSERT INTO BOOK_CATEGORY VALUES ('Romance', 20);
INSERT INTO BOOK_CATEGORY VALUES ('Science', 20);
INSERT INTO BOOK_CATEGORY VALUES ('Horror', 20);
INSERT INTO BOOK_CATEGORY VALUES('Novel',18);
INSERT INTO BOOK_CATEGORY VALUES('History',15);




Select * from BOOK_CATEGORY;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table SYSTEM_USER (

User_ID number(5), 
User_Name varchar(20),
User_DateOfBirth date,
User_Gender varchar(10),
CreditCardNumber varchar(25)   /* 16 digit */


);
--Alter Table-------------------------------------------------------------------
alter table SYSTEM_USER add constraint User_PK primary key(User_ID); 
alter table SYSTEM_USER add constraint User_Gender check (User_Gender in ('Male','Female')); 


INSERT INTO SYSTEM_USER VALUES( 52486, 'Leena', '1-Dec-2010','Female', '0120152489673259');
INSERT INTO SYSTEM_USER VALUES( 52458, 'Naief ', '1-Feb-2015 ','Male', ' 0120152489673000');  
INSERT INTO SYSTEM_USER VALUES( 52412, 'Huda', '1-May-2002','Female', '0120152489600032');
INSERT INTO SYSTEM_USER VALUES( 52496, 'Sara', '1-Nov-2002','Female', '0120152489673413');
INSERT INTO SYSTEM_USER VALUES( 52418, 'Noora', '1-APR-2002','Female', '0120152489679935');

/*calculate age*/
 
SELECT User_ID , User_Name , User_Gender, CreditCardNumber , TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) AS User_Age FROM SYSTEM_USER;


/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table USER_INTREST (
User_ID number(5), 
Intersts varchar(20)
);
--Alter Table-------------------------------------------------------------------
alter table USER_INTREST add constraint UserIntrests_PK primary key(User_ID, Intersts); 
alter table USER_INTREST add constraint User_ID_FK foreign key(User_ID) references SYSTEM_USER(User_ID) on delete cascade; 

INSERT INTO USER_INTREST VALUES(52486, 'Fantasy');
INSERT INTO USER_INTREST VALUES(52458, 'Kids');
INSERT INTO USER_INTREST VALUES(52412, 'Romance');
INSERT INTO USER_INTREST VALUES(52496, 'Science');
INSERT INTO USER_INTREST VALUES(52418, 'Horror');

 

SELECT * FROM USER_INTREST;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table SUBSCRIPTION (
Subscription_ID number(5), 
Subscription_Cost Number(5),
Subscription_Period number(5), /* in months*/
Subscription_Start_Date date,
Subscription_End_Date date,
User_ID number(5)
);
--Alter Table-------------------------------------------------------------------
alter table SUBSCRIPTION add constraint Subscription_PK primary key(Subscription_ID); 
alter table SUBSCRIPTION add constraint Subscription_FK foreign key (User_ID) references SYSTEM_USER(User_ID) on delete cascade; 
alter table SUBSCRIPTION add constraint Subscription_Period  check (Subscription_Period = 6 or Subscription_Period = 12 or Subscription_Period = 3); 
alter table SUBSCRIPTION modify Subscription_Start_Date date default sysdate ;

insert into SUBSCRIPTION values(85987, 102, 12, '10-APR-2021', TO_DATE(ADD_MONTHS('10-APR-2021' , 12)),52486);
insert into SUBSCRIPTION values(85988, 29 , 6 , '5-SEP-2022', TO_DATE(ADD_MONTHS('5-SEP-2022' , 6)),  52458);
insert into SUBSCRIPTION values(85982, 50 , 3 , '22-FEB-2021', TO_DATE(ADD_MONTHS('22-FEB-2021' , 3)),  52412);
insert into SUBSCRIPTION values(85981, 102 , 12 , '12-MAY-2020', TO_DATE(ADD_MONTHS('12-MAY-2020' , 12)),  52418);
insert into SUBSCRIPTION values(85985, 102 , 3 , '19-Oct-2019', TO_DATE(ADD_MONTHS('19-Oct-2019', 3)),  52496);

select *  FROM SUBSCRIPTION;



/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table EBOOK (
Book_ID number(5), 
Book_Title varchar(30),
Book_Year varchar(30),

Author_ID number(5),
Publisher_ID number(5),
Category_Name varchar(20)


);
--Alter Table-------------------------------------------------------------------
alter table EBOOK add constraint Book_PK primary key(Book_ID); 
alter table EBOOK add constraint Book_FK1 foreign key(Author_ID) references AUTHOR(Author_ID) on delete set null; 
alter table EBOOK add constraint Book_FK2 foreign key(Publisher_ID) references PUBLISHER(Publisher_ID) on delete set null; 
alter table EBOOK add constraint Book_FK3 foreign key(Category_Name) references BOOK_CATEGORY(Category_Name) on delete set null; 

INSERT INTO EBOOK VALUES(00001, 'Sylvans(Warcraft)', '2-05-2000', 10001,24008, 'Fantasy');
INSERT INTO EBOOK VALUES(00002, 'The Good Dinosaur', '18-09-2010', 10002,24007, 'Kids');
INSERT INTO EBOOK VALUES(00003, 'Romeo & Juliet','11-06-1990' , 10002,24001, 'Romance');
INSERT INTO EBOOK VALUES(00004, 'Geology', '1-10-1999', 10004,24002, 'Science');
INSERT INTO EBOOK VALUES(00005, 'Silent Hill', '12-01-2001', 10005, 24005, 'Horror');
INSERT INTO EBOOK VALUES(00006, 'Nineteen', '27-01-2018', 10006, 24003, 'Fantasy');
INSERT INTO EBOOK VALUES(00007, 'They Hear Its Senses', '1-10-2012', 10006, 24003, 'Novel');
INSERT INTO EBOOK VALUES(00008, 'Ya Sahibay al-Sijn', '10-03-2012', 10006, 24004, 'Novel');
INSERT INTO EBOOK VALUES(00009, 'The War of Two Queens', '15-03-2022', 10007, 24001, 'Fantasy');
INSERT INTO EBOOK VALUES(00010, 'The School for Good Mothers', '4-01-2022', 10007, 24001, 'Fantasy');





SELECT * FROM EBOOK;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table EBOOK_SUBSCRIPTION (
Subscription_ID number(5), 
Book_ID number(5)
);
--Alter Table-------------------------------------------------------------------
alter table EBOOK_SUBSCRIPTION add constraint EBookSub_PK primary key(Subscription_ID, Book_ID); 
alter table EBOOK_SUBSCRIPTION add constraint EBOOK_SUBSCRIPTION_FK1 foreign key (Subscription_ID) references SUBSCRIPTION(Subscription_ID) on delete cascade; 
alter table EBOOK_SUBSCRIPTION add constraint EBOOK_SUBSCRIPTION_FK2 foreign key (Book_ID) references EBOOK(Book_ID) on delete set null;

INSERT INTO EBOOK_SUBSCRIPTION VALUES(85987, 00001);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85988, 00002);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85982, 00003);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85985, 00004);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85981, 00005);

SELECT * FROM EBOOK_SUBSCRIPTION;



-- Queries ---------------------------------------------------------------------
/*

   - we shall write at least 4 queries

   - also we shall use
     1- Where,
     2- Order by,
     3- Group by,
     4- Aggregate function,
     5- Subquery,
     6- Join query
     
     */

-- Q1: calculate the average ages of the system users by using (Aggregate function)

select avg(TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25)) as the_average_ages_of_system_users
from SYSTEM_USER;


-- Q2: show the number of subscription in each subscription package by using (group by and order by)

select SUBSCRIPTION_PERIOD as months, count(SUBSCRIPTION_PERIOD) as Number_SUBSCRIPTION
from  SUBSCRIPTION
group by SUBSCRIPTION_PERIOD
order by months;

-- Q3: show the User ID And SUBSCRIPTION ID of who subscribed with 12 months package by using (where)

select U.User_ID, U.USER_NAME, SUBSCRIPTION_ID
from SYSTEM_USER U , SUBSCRIPTION S
where U.User_ID = S.USER_ID
And S.SUBSCRIPTION_PERIOD = 12;
------------------------------------
select * from SYSTEM_USER;
select * from SUBSCRIPTION;

-- Q4: show the author ID, author name and publisher of the book "Geology" by using (Equi-join)

select a.Author_ID, Author_Name, Publisher_Name ,Book_Title
from  Author a , Publisher p, EBOOK b
where a.Author_ID = b.Author_ID
and p.Publisher_ID = b.Publisher_ID
and Book_Title = 'Geology';

select * from Author;
select * from Publisher;
select * from EBOOK;

-- Q5: show the number of books in each category

select BOOK_CATEGORY.Category_Name, count(EBOOK.Book_ID) as number_of_books
from BOOK_CATEGORY left outer join EBOOK
on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
group by BOOK_CATEGORY.Category_Name order by number_of_books desc;


-- Q6: What is the category name which has maximum number of books? By using (subquery)

select Category_Name , count(EBOOK.Book_ID)
from  EBOOK
group by Category_Name
having count(Book_ID) = (select max(count(Book_ID))
from  EBOOK
group by Category_Name);

-- Q7: What is the category name and the number books in the category which has minimum number of books?

select BOOK_CATEGORY.Category_Name, count(EBOOK.Book_ID)
from BOOK_CATEGORY left outer join EBOOK
on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
group by BOOK_CATEGORY.Category_Name
having count(EBOOK.Book_ID) = (SELECT min(count(EBOOK.Book_ID)) FROM BOOK_CATEGORY
                left outer join EBOOK
                on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
                group by BOOK_CATEGORY.Category_Name);


-- Q8: What is the category name and the number books in the category which has maximum number of books?

select BOOK_CATEGORY.Category_Name, count(EBOOK.Book_ID)
from BOOK_CATEGORY left outer join EBOOK
on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
group by BOOK_CATEGORY.Category_Name
having count(EBOOK.Book_ID) = (SELECT Max (count(EBOOK.Book_ID)) FROM BOOK_CATEGORY
                left outer join EBOOK
                on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
                group by BOOK_CATEGORY.Category_Name);


-- Q9: show the user ID and user name and user gender and user birth of date of the youngest user

select User_ID, User_Name,User_Gender, User_DateOfBirth
from SYSTEM_USER
where TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) = (select min(TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25))
from SYSTEM_USER);

-- Anthor way ... 
select User_ID, User_Name,User_Gender, User_DateOfBirth
from SYSTEM_USER
where User_DateOfBirth = (select max(User_DateOfBirth)
                            from SYSTEM_USER);
    
-- Q10: what is the publisher ID and the publisher name which published maximum number of books

-- first how many books each publisher has published?

select EBOOK.Publisher_ID, Publisher_Name, count(Book_ID) as Number_of_books
from EBOOK join PUBLISHER
on (EBOOK.Publisher_ID = PUBLISHER.Publisher_ID)
group by EBOOK.Publisher_ID, Publisher_Name;

-- second find the publisher which published maximum number of books

select EBOOK.Publisher_ID, Publisher_Name
from   EBOOK join PUBLISHER
on (EBOOK.Publisher_ID = PUBLISHER.Publisher_ID)
group by EBOOK.Publisher_ID, Publisher_Name
having  count(Book_ID) = (select max(count(Book_ID))
                            from EBOOK
                            group by Publisher_ID);

-- Q11: show the Author Name and Author ID and number of books Author wrote

select EBOOK.Author_ID, Author_Name, count(Book_ID) as Number_of_books
from EBOOK join Author
on (EBOOK.Author_ID = Author.Author_ID)
group by EBOOK.Author_ID, Author_Name;


--------------------------------------------

-- Procedure 1 : This procedure takes as input the user id then shows Subscription_details of her/his.
 
CREATE OR REPLACE Procedure Subscription_details(userID IN SUBSCRIPTION.USER_ID%type) 
as 
UserName SYSTEM_USER.USER_NAME%type;
UserGender SYSTEM_USER.USER_GENDER%type;
SubscriptionId  SUBSCRIPTION.SUBSCRIPTION_ID%type;
SubscriptionCost  SUBSCRIPTION.SUBSCRIPTION_COST%type;
SubscriptionPeriod SUBSCRIPTION.SUBSCRIPTION_PERIOD%type;
SubscriptionEndDate SUBSCRIPTION.SUBSCRIPTION_END_DATE%type;

begin 
select SUBSCRIPTION_ID, SUBSCRIPTION_COST, SUBSCRIPTION_PERIOD,SUBSCRIPTION_END_DATE ,USER_NAME, USER_GENDER 
  into  SubscriptionId,  SubscriptionCost,  SubscriptionPeriod  ,SubscriptionEndDate , UserName, UserGender 
    FROM SUBSCRIPTION s ,SYSTEM_USER u where s.USER_ID = userID And s.User_ID = u.User_ID ; 


 dbms_output.put_line('===============User & Subscription Details================'); 
 dbms_output.put_line('User ID : '|| userID); 
 dbms_output.put_line('User Gender : '|| UserGender);
 dbms_output.put_line('User Name : '|| UserName); 
 dbms_output.put_line('Subscription ID : '|| SubscriptionId); 
  dbms_output.put_line('Subscription Period:'|| SubscriptionPeriod); 
 dbms_output.put_line('Subscription Cost : '|| SubscriptionCost);
 dbms_output.put_line('Subscription End Date : '|| SubscriptionEndDate); 

 end Subscription_details; 
 
 
 exec Subscription_details(52486);
 
 select * from SYSTEM_USER ;
 select * from SUBSCRIPTION ;

-------------------------------------------------------------------------------

-- Procedure 2 : This procedure updates the Subscription_Cost with 15% discount for all subscribers over the age of 15.


Create or replace Procedure  dicount_15 

AS
    newCost SUBSCRIPTION.SUBSCRIPTION_COST%type;
    discountValue float(4) := 15/100 ;

cursor curs_prop is 
SELECT SUBSCRIPTION.User_ID,
       Subscription_ID,
       User_Name,
       TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) as user_age,
       Subscription_Cost
       FROM SUBSCRIPTION INNER JOIN SYSTEM_USER ON SUBSCRIPTION.User_ID = SYSTEM_USER.User_ID where TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) > 15;
       
       
begin

    for rec in curs_prop 
        loop  
        newCost := rec.Subscription_Cost-( discountValue * rec.Subscription_Cost);
            UPDATE SUBSCRIPTION
            SET Subscription_Cost = newCost
            where  SUBSCRIPTION_ID = rec.SUBSCRIPTION_ID;
            
                dbms_output.put_line(    'User Name: '       || rec.User_Name || '   || ' 
                                      || 'User_ID : '       || rec.User_ID   || '   || ' 
                                      || 'User Age: '       || rec.user_Age  || '   || '
                                      || 'Subscription ID: ' || rec.Subscription_ID);
                dbms_output.put_line('                                              ');
                dbms_output.put_line('Cost before discount: ' || rec.Subscription_Cost );
                dbms_output.put_line('Cost After discount: ' || newCost );
                dbms_output.put_line('------------------------------------------------------------------------');

 end loop;    
        dbms_output.put_line('      The 15% discount has been successfully applied');


end ;

exec dicount_15 ;
/*--------------------------------------------------------------------------*/
create table AUTHOR (
Author_ID number(5), 
Author_Name varchar(20),
Author_Phone varchar(15) not null unique,
Author_Email varchar(30) not null unique
);
--Alter Table-------------------------------------------------------------------
alter table AUTHOR add constraint ATH_PK primary key(Author_ID); 

INSERT INTO AUTHOR VALUES (10001, 'Mark Styles', '0514559632', 'MarkStyles@gmail.com'); 
INSERT INTO AUTHOR VALUES (10002, 'Henry Evans', '0589665472', 'HenryEvans@gmail.com'); 
INSERT INTO AUTHOR VALUES (10003, 'Harvey Specter', '059648512', 'HarveySpecter@gmail.com'); 
INSERT INTO AUTHOR VALUES (10004, 'Sebastian Stan', '0596445827', 'SebastianStan@gmail.com'); 
INSERT INTO AUTHOR VALUES (10005, 'Stiles Stilinski', '0585669748', 'StilesStilinski@gmail.com'); 
INSERT INTO AUTHOR VALUES (10006, 'AymanOtoom', '053953536', 'AymanOtoom@gmail.com'); 
INSERT INTO AUTHOR VALUES (10007, 'Jennifer Armentrout', '0555146584', 'JenniferArt@gmail.com'); 

Select * from AUTHOR;


/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table PUBLISHER (
Publisher_ID number(5), 
Publisher_Name varchar(20),
Publisher_Phone varchar(15) not null unique,
Publisher_Email varchar(30) not null unique
);
--Alter Table-------------------------------------------------------------------
alter table PUBLISHER add constraint PUB_PK primary key(Publisher_ID); 

INSERT INTO PUBLISHER VALUES (24008, 'Jarir', '055223648', 'Jarir@gmail.com');
INSERT INTO PUBLISHER VALUES (24007, 'Rndom House', '054778451', 'RndomHouse@gmail.com');
INSERT INTO PUBLISHER VALUES (24001, 'HarperCollins', '054996785', 'HarperCollins@gmail.com');
INSERT INTO PUBLISHER VALUES (24002, 'Scholastic', '05996488', 'Scholastic@gmail.com');
INSERT INTO PUBLISHER VALUES (24003, 'aseeralkotb', '056584541', 'aseeralkotb@gmail.com');
INSERT INTO PUBLISHER VALUES (24004, 'Dar al Faris', '0559874584', 'Dar al Faris@gmail.com');
INSERT INTO PUBLISHER VALUES (24005, 'Pearsson', '058974528', 'Pearsson@gmail.com');

Select * from PUBLISHER;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table BOOK_CATEGORY (

Category_Name varchar(20), 
Age_Classification number(2)

);
--Alter Table-------------------------------------------------------------------
alter table BOOK_CATEGORY add constraint BC_PK primary key(Category_Name); 

INSERT INTO BOOK_CATEGORY VALUES ('Fantasy', 12);
INSERT INTO BOOK_CATEGORY VALUES ('Kids', 7);
INSERT INTO BOOK_CATEGORY VALUES ('Romance', 20);
INSERT INTO BOOK_CATEGORY VALUES ('Science', 20);
INSERT INTO BOOK_CATEGORY VALUES ('Horror', 20);
INSERT INTO BOOK_CATEGORY VALUES('Novel',18);
INSERT INTO BOOK_CATEGORY VALUES('History',15);




Select * from BOOK_CATEGORY;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table SYSTEM_USER (

User_ID number(5), 
User_Name varchar(20),
User_DateOfBirth date,
User_Gender varchar(10),
CreditCardNumber varchar(25)   /* 16 digit */


);
--Alter Table-------------------------------------------------------------------
alter table SYSTEM_USER add constraint User_PK primary key(User_ID); 
alter table SYSTEM_USER add constraint User_Gender check (User_Gender in ('Male','Female')); 


INSERT INTO SYSTEM_USER VALUES( 52486, 'Leena', '1-Dec-2010','Female', '0120152489673259');
INSERT INTO SYSTEM_USER VALUES( 52458, 'Naief ', '1-Feb-2015 ','Male', ' 0120152489673000');  
INSERT INTO SYSTEM_USER VALUES( 52412, 'Huda', '1-May-2002','Female', '0120152489600032');
INSERT INTO SYSTEM_USER VALUES( 52496, 'Sara', '1-Nov-2002','Female', '0120152489673413');
INSERT INTO SYSTEM_USER VALUES( 52418, 'Noora', '1-APR-2002','Female', '0120152489679935');

/*calculate age*/
 
SELECT User_ID , User_Name , User_Gender, CreditCardNumber , TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) AS User_Age FROM SYSTEM_USER;


/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table USER_INTREST (
User_ID number(5), 
Intersts varchar(20)
);
--Alter Table-------------------------------------------------------------------
alter table USER_INTREST add constraint UserIntrests_PK primary key(User_ID, Intersts); 
alter table USER_INTREST add constraint User_ID_FK foreign key(User_ID) references SYSTEM_USER(User_ID) on delete cascade; 

INSERT INTO USER_INTREST VALUES(52486, 'Fantasy');
INSERT INTO USER_INTREST VALUES(52458, 'Kids');
INSERT INTO USER_INTREST VALUES(52412, 'Romance');
INSERT INTO USER_INTREST VALUES(52496, 'Science');
INSERT INTO USER_INTREST VALUES(52418, 'Horror');

 

SELECT * FROM USER_INTREST;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table SUBSCRIPTION (
Subscription_ID number(5), 
Subscription_Cost Number(5),
Subscription_Period number(5), /* in months*/
Subscription_Start_Date date,
Subscription_End_Date date,
User_ID number(5)
);
--Alter Table-------------------------------------------------------------------
alter table SUBSCRIPTION add constraint Subscription_PK primary key(Subscription_ID); 
alter table SUBSCRIPTION add constraint Subscription_FK foreign key (User_ID) references SYSTEM_USER(User_ID) on delete cascade; 
alter table SUBSCRIPTION add constraint Subscription_Period  check (Subscription_Period = 6 or Subscription_Period = 12 or Subscription_Period = 3); 
alter table SUBSCRIPTION modify Subscription_Start_Date date default sysdate ;

insert into SUBSCRIPTION values(85987, 102, 12, '10-APR-2021', TO_DATE(ADD_MONTHS('10-APR-2021' , 12)),52486);
insert into SUBSCRIPTION values(85988, 29 , 6 , '5-SEP-2022', TO_DATE(ADD_MONTHS('5-SEP-2022' , 6)),  52458);
insert into SUBSCRIPTION values(85982, 50 , 3 , '22-FEB-2021', TO_DATE(ADD_MONTHS('22-FEB-2021' , 3)),  52412);
insert into SUBSCRIPTION values(85981, 102 , 12 , '12-MAY-2020', TO_DATE(ADD_MONTHS('12-MAY-2020' , 12)),  52418);
insert into SUBSCRIPTION values(85985, 102 , 3 , '19-Oct-2019', TO_DATE(ADD_MONTHS('19-Oct-2019', 3)),  52496);

select *  FROM SUBSCRIPTION;



/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table EBOOK (
Book_ID number(5), 
Book_Title varchar(30),
Book_Year varchar(30),

Author_ID number(5),
Publisher_ID number(5),
Category_Name varchar(20)


);
--Alter Table-------------------------------------------------------------------
alter table EBOOK add constraint Book_PK primary key(Book_ID); 
alter table EBOOK add constraint Book_FK1 foreign key(Author_ID) references AUTHOR(Author_ID) on delete set null; 
alter table EBOOK add constraint Book_FK2 foreign key(Publisher_ID) references PUBLISHER(Publisher_ID) on delete set null; 
alter table EBOOK add constraint Book_FK3 foreign key(Category_Name) references BOOK_CATEGORY(Category_Name) on delete set null; 

INSERT INTO EBOOK VALUES(00001, 'Sylvans(Warcraft)', '2-05-2000', 10001,24008, 'Fantasy');
INSERT INTO EBOOK VALUES(00002, 'The Good Dinosaur', '18-09-2010', 10002,24007, 'Kids');
INSERT INTO EBOOK VALUES(00003, 'Romeo & Juliet','11-06-1990' , 10002,24001, 'Romance');
INSERT INTO EBOOK VALUES(00004, 'Geology', '1-10-1999', 10004,24002, 'Science');
INSERT INTO EBOOK VALUES(00005, 'Silent Hill', '12-01-2001', 10005, 24005, 'Horror');
INSERT INTO EBOOK VALUES(00006, 'Nineteen', '27-01-2018', 10006, 24003, 'Fantasy');
INSERT INTO EBOOK VALUES(00007, 'They Hear Its Senses', '1-10-2012', 10006, 24003, 'Novel');
INSERT INTO EBOOK VALUES(00008, 'Ya Sahibay al-Sijn', '10-03-2012', 10006, 24004, 'Novel');
INSERT INTO EBOOK VALUES(00009, 'The War of Two Queens', '15-03-2022', 10007, 24001, 'Fantasy');
INSERT INTO EBOOK VALUES(00010, 'The School for Good Mothers', '4-01-2022', 10007, 24001, 'Fantasy');





SELECT * FROM EBOOK;

/*--------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------*/
create table EBOOK_SUBSCRIPTION (
Subscription_ID number(5), 
Book_ID number(5)
);
--Alter Table-------------------------------------------------------------------
alter table EBOOK_SUBSCRIPTION add constraint EBookSub_PK primary key(Subscription_ID, Book_ID); 
alter table EBOOK_SUBSCRIPTION add constraint EBOOK_SUBSCRIPTION_FK1 foreign key (Subscription_ID) references SUBSCRIPTION(Subscription_ID) on delete cascade; 
alter table EBOOK_SUBSCRIPTION add constraint EBOOK_SUBSCRIPTION_FK2 foreign key (Book_ID) references EBOOK(Book_ID) on delete set null;

INSERT INTO EBOOK_SUBSCRIPTION VALUES(85987, 00001);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85988, 00002);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85982, 00003);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85985, 00004);
INSERT INTO EBOOK_SUBSCRIPTION VALUES(85981, 00005);

SELECT * FROM EBOOK_SUBSCRIPTION;



-- Queries ---------------------------------------------------------------------
/*

   - we shall write at least 4 queries

   - also we shall use
     1- Where,
     2- Order by,
     3- Group by,
     4- Aggregate function,
     5- Subquery,
     6- Join query
     
     */

-- Q1: calculate the average ages of the system users by using (Aggregate function)

select avg(TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25)) as the_average_ages_of_system_users
from SYSTEM_USER;


-- Q2: show the number of subscription in each subscription package by using (group by and order by)

select SUBSCRIPTION_PERIOD as months, count(SUBSCRIPTION_PERIOD) as Number_SUBSCRIPTION
from  SUBSCRIPTION
group by SUBSCRIPTION_PERIOD
order by months;

-- Q3: show the User ID And SUBSCRIPTION ID of who subscribed with 12 months package by using (where)

select U.User_ID, U.USER_NAME, SUBSCRIPTION_ID
from SYSTEM_USER U , SUBSCRIPTION S
where U.User_ID = S.USER_ID
And S.SUBSCRIPTION_PERIOD = 12;
------------------------------------
select * from SYSTEM_USER;
select * from SUBSCRIPTION;

-- Q4: show the author ID, author name and publisher of the book "Geology" by using (Equi-join)

select a.Author_ID, Author_Name, Publisher_Name ,Book_Title
from  Author a , Publisher p, EBOOK b
where a.Author_ID = b.Author_ID
and p.Publisher_ID = b.Publisher_ID
and Book_Title = 'Geology';

select * from Author;
select * from Publisher;
select * from EBOOK;

-- Q5: show the number of books in each category

select BOOK_CATEGORY.Category_Name, count(EBOOK.Book_ID) as number_of_books
from BOOK_CATEGORY left outer join EBOOK
on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
group by BOOK_CATEGORY.Category_Name order by number_of_books desc;


-- Q6: What is the category name which has maximum number of books? By using (subquery)

select Category_Name , count(EBOOK.Book_ID)
from  EBOOK
group by Category_Name
having count(Book_ID) = (select max(count(Book_ID))
from  EBOOK
group by Category_Name);

-- Q7: What is the category name and the number books in the category which has minimum number of books?

select BOOK_CATEGORY.Category_Name, count(EBOOK.Book_ID)
from BOOK_CATEGORY left outer join EBOOK
on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
group by BOOK_CATEGORY.Category_Name
having count(EBOOK.Book_ID) = (SELECT min(count(EBOOK.Book_ID)) FROM BOOK_CATEGORY
                left outer join EBOOK
                on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
                group by BOOK_CATEGORY.Category_Name);


-- Q8: What is the category name and the number books in the category which has maximum number of books?

select BOOK_CATEGORY.Category_Name, count(EBOOK.Book_ID)
from BOOK_CATEGORY left outer join EBOOK
on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
group by BOOK_CATEGORY.Category_Name
having count(EBOOK.Book_ID) = (SELECT Max (count(EBOOK.Book_ID)) FROM BOOK_CATEGORY
                left outer join EBOOK
                on BOOK_CATEGORY.Category_Name = EBOOK.Category_Name
                group by BOOK_CATEGORY.Category_Name);


-- Q9: show the user ID and user name and user gender and user birth of date of the youngest user

select User_ID, User_Name,User_Gender, User_DateOfBirth
from SYSTEM_USER
where TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) = (select min(TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25))
from SYSTEM_USER);

-- Anthor way ... 
select User_ID, User_Name,User_Gender, User_DateOfBirth
from SYSTEM_USER
where User_DateOfBirth = (select max(User_DateOfBirth)
                            from SYSTEM_USER);
    
-- Q10: what is the publisher ID and the publisher name which published maximum number of books

-- first how many books each publisher has published?

select EBOOK.Publisher_ID, Publisher_Name, count(Book_ID) as Number_of_books
from EBOOK join PUBLISHER
on (EBOOK.Publisher_ID = PUBLISHER.Publisher_ID)
group by EBOOK.Publisher_ID, Publisher_Name;

-- second find the publisher which published maximum number of books

select EBOOK.Publisher_ID, Publisher_Name
from   EBOOK join PUBLISHER
on (EBOOK.Publisher_ID = PUBLISHER.Publisher_ID)
group by EBOOK.Publisher_ID, Publisher_Name
having  count(Book_ID) = (select max(count(Book_ID))
                            from EBOOK
                            group by Publisher_ID);

-- Q11: show the Author Name and Author ID and number of books Author wrote

select EBOOK.Author_ID, Author_Name, count(Book_ID) as Number_of_books
from EBOOK join Author
on (EBOOK.Author_ID = Author.Author_ID)
group by EBOOK.Author_ID, Author_Name;


--------------------------------------------

-- Procedure 1 : This procedure takes as input the user id then shows Subscription_details of her/his.
 
CREATE OR REPLACE Procedure Subscription_details(userID IN SUBSCRIPTION.USER_ID%type) 
as 
UserName SYSTEM_USER.USER_NAME%type;
UserGender SYSTEM_USER.USER_GENDER%type;
SubscriptionId  SUBSCRIPTION.SUBSCRIPTION_ID%type;
SubscriptionCost  SUBSCRIPTION.SUBSCRIPTION_COST%type;
SubscriptionPeriod SUBSCRIPTION.SUBSCRIPTION_PERIOD%type;
SubscriptionEndDate SUBSCRIPTION.SUBSCRIPTION_END_DATE%type;

begin 
select SUBSCRIPTION_ID, SUBSCRIPTION_COST, SUBSCRIPTION_PERIOD,SUBSCRIPTION_END_DATE ,USER_NAME, USER_GENDER 
  into  SubscriptionId,  SubscriptionCost,  SubscriptionPeriod  ,SubscriptionEndDate , UserName, UserGender 
    FROM SUBSCRIPTION s ,SYSTEM_USER u where s.USER_ID = userID And s.User_ID = u.User_ID ; 


 dbms_output.put_line('===============User & Subscription Details================'); 
 dbms_output.put_line('User ID : '|| userID); 
 dbms_output.put_line('User Gender : '|| UserGender);
 dbms_output.put_line('User Name : '|| UserName); 
 dbms_output.put_line('Subscription ID : '|| SubscriptionId); 
  dbms_output.put_line('Subscription Period:'|| SubscriptionPeriod); 
 dbms_output.put_line('Subscription Cost : '|| SubscriptionCost);
 dbms_output.put_line('Subscription End Date : '|| SubscriptionEndDate); 

 end Subscription_details; 
 
 
 exec Subscription_details(52486);
 
 select * from SYSTEM_USER ;
 select * from SUBSCRIPTION ;

-------------------------------------------------------------------------------

-- Procedure 2 : This procedure updates the Subscription_Cost with 15% discount for all subscribers over the age of 15.


Create or replace Procedure  dicount_15 

AS
    newCost SUBSCRIPTION.SUBSCRIPTION_COST%type;
    discountValue float(4) := 15/100 ;

cursor curs_prop is 
SELECT SUBSCRIPTION.User_ID,
       Subscription_ID,
       User_Name,
       TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) as user_age,
       Subscription_Cost
       FROM SUBSCRIPTION INNER JOIN SYSTEM_USER ON SUBSCRIPTION.User_ID = SYSTEM_USER.User_ID where TRUNC(TO_NUMBER(SYSDATE -TO_DATE(User_DateOfBirth)) / 365.25) > 15;
       
       
begin

    for rec in curs_prop 
        loop  
        newCost := rec.Subscription_Cost-( discountValue * rec.Subscription_Cost);
            UPDATE SUBSCRIPTION
            SET Subscription_Cost = newCost
            where  SUBSCRIPTION_ID = rec.SUBSCRIPTION_ID;
            
                dbms_output.put_line(    'User Name: '       || rec.User_Name || '   || ' 
                                      || 'User_ID : '       || rec.User_ID   || '   || ' 
                                      || 'User Age: '       || rec.user_Age  || '   || '
                                      || 'Subscription ID: ' || rec.Subscription_ID);
                dbms_output.put_line('                                              ');
                dbms_output.put_line('Cost before discount: ' || rec.Subscription_Cost );
                dbms_output.put_line('Cost After discount: ' || newCost );
                dbms_output.put_line('------------------------------------------------------------------------');

 end loop;    
        dbms_output.put_line('      The 15% discount has been successfully applied');


end ;

exec dicount_15 ;
