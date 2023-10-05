use tanya;

create table cities
(
    id int primary key auto_increment,
    city varchar(20) not null
);
create table users
(
    id int primary key auto_increment,
    name varchar(20) not null ,
    age int not null ,
    city_id int null ,
    foreign key (city_id) references cities(id)
);

insert into cities values (null,'Odesa');
insert into users values (null,'Bogdan',20,3);

select * from users join cities c on c.id = users.city_id;
select users.id,name,age,city from users join cities c on c.id = users.city_id;
select users.*,city from users join cities c on c.id = users.city_id;

select * from users left join cities c on c.id = users.city_id;
select * from users right join cities c on c.id = users.city_id;

select users.* from users join cities c on c.id = users.city_id where city='Kyiv';

select city from users join cities c on c.id = users.city_id where users.id=3;

select * from client join tanya.application a on client.idClient = a.Client_idClient;

select * from client join tanya.application a on client.idClient = a.Client_idClient join tanya.department d on d.idDepartment = client.Department_idDepartment;


select distinct name from users;

(select * from users order by age desc limit 1)
union
(select * from users order by age limit 1);

select * from cities where id in(select city_id from users where name = 'Tanya');
/*
foreign key (current table) references anotherTable(key)- establishes a relationship between the column in the current table and the column in another table
JOIN ON - is used to retrieve data from both tables where there is a matching relationship
"LEFT JOIN" is used to combine rows from two tables based on a specified condition and include all rows from the first table, even if there are no matching relationships in the second table
"RIGHT JOIN" is used to combine rows from two tables based on a specified condition and include all rows from the second table, even if there are no matching relationships in the first table
DISTINCT - is used to retrieve unique values from a specified column
UNION operator is used to combine results of two or more queries into a single result set.
*/