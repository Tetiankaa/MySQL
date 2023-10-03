use tanya;

show tables;

select * from cars;

create table users
(
    id int not null auto_increment primary key ,
    name varchar(255) not null,
    age int not null ,
    gender varchar(6) not null
);

insert into users values (null,'Anna',23,'female');
select * from users;
select id,name from users;

select * from users where age >18;

select * from users where name like 'o%';
select * from users where name like '%o%';
select * from users where name like '__n%';

select * from users where age != 16;

select * from users where age between 20 and 30;

select * from users where age in (30,25,22);

select * from  users where age=18 or (age = 44 and name = 'oleh');

select * from users where length(name)>4;

/* sorting */
select * from users order by name desc;
select * from users limit 4;
select * from users limit 3 offset 4;
select * from users where age>20 order by age limit 3 offset 3;

/* aggregate functions */

select min(age) as minAge from users;
select max(age) as maxAge from users;
select avg(age) as avgAge from users;
select sum(age) as sumAge from users;
select count(*) from users;

/* ############################### */
select * from  cars;
select count(*),model from cars where year>2020 group by model;

select count(*),sum(price),min(price),max(price),model from cars where year>2020 group by model;
select count(*),model from cars where model like 'a%' group by model;

/*  update */

update users set age=27 where id=5;

delete from users where id=1;

/*
MySQL - used for managing and storing data.

use - switch to the particular database
show tables - show list of the tables in database
drop table - used to delete the table
create table - used to create the table
primary key - ensuring that each record has a unique identifier
auto-increment - allows a unique number to be generated automatically
not null - the value must be not empty
insert into "name of table" values - used to insert values into table
WHERE - is used to filter records
like 'o%' - allows to search for the value that starts with provided character
like '%o%' - allows to search for the value that contains provided character
like '%o' - allows to search for the value that ends with provided character
like '__n%' - skip one character (third letter is "n")
between - used to set range when filtering values
in - selects all rows that matches any of the values

// order by - allows to sort the data in ascending order (asc) or descending order (desc)
// limit - is used to specify the number of records to return
// offset -is used to specify how much records will be skipped

//Aggregate functions are used to calculate a set of values and return a single value as a result.
    MIN(): Retrieves the minimum value in a column
    MAX(): Retrieves the maximum value in a column
    AVG(): Computes the average of values in a numeric column.
    SUM(): Calculates the sum of values in a numeric column.
    COUNT(): Counts the number of rows
 "AS" keyword is used to give a column alias with more meaningful name
 GROUP BY - groups rows that have the same values into summary rows

update - used to update specific rows
*/