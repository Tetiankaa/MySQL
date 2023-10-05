use tanya;

create table employees
(
    id int auto_increment primary key ,
    first_name varchar(20),
    last_name varchar(20),
    hourly_pay decimal(5,2),
    hire_date date
);
/* how to create a table */
rename table employees to workers;
rename table workers to employees;

alter table employees add phone_number int;

alter table employees modify column first_name varchar(50);

alter table employees modify hire_date date after last_name;

alter table employees drop column phone_number;

select * from employees;

/* insert values */

insert into employees values (null,'Diana','Voloshyna','2023-07-05',4.00);

insert into employees values (null,'Olha','Petrova','2020-06-02',4.00),
                             (null,'Yulia','Oharenko','2018-06-15',6.00);

insert into employees (first_name,last_name) values ('Valer','Muchov');
select * from employees;

/* select */
select first_name,last_name from employees;

select * from employees where  employees.id=4;

select * from employees where hourly_pay >=6;

select * from employees where hire_date<='2023-01-01';

select * from employees where employees.id != 1;

select * from employees where hire_date is null ;

select * from employees where hire_date is not null ;

/* update & delete */
update employees set employees.hourly_pay = 5 where employees.id=4;

delete from employees where employees.id=2;

delete from employees; /* delete all rows */

/* currentDate & currentTime */

create table test
(
    my_date date,
    my_time time,
    my_datetime datetime
);

insert into test values (current_date,current_time,now());
insert into test values (current_date+1,null,null);
select * from test;

/* unique */

create table products
(
    id int primary key auto_increment,
    product_name varchar(30) unique ,
    price decimal (4,2)
);
alter table products add constraint unique (product_name); /* if you forgot to add UNIQUE while creating table */

insert into products values (null,'hamburger',9.99),(null,'fries',6.99),(null,'ice cream',4.80);
insert into products values (null,'pizza',12.5);
select * from products;

/* NOT NULL */

alter table products modify column price decimal(4,2) not null ;

/* check */

alter table employees add constraint check_hourly_pay check (employees.hourly_pay >4 );
insert into employees values (null,'Anton','Kotov','2023-09-16',3.99);

alter table employees drop check check_hourly_pay; /* remove check */

/* default */
select * from products;

alter table products alter price set default 0;
insert into products(products.id,product_name) values (null,'ribs');

SET time_zone = 'Europe/Bratislava';

create table transactions
(
    id int primary key auto_increment,
    amount decimal(5,2),
    transaction_date datetime default now()
);

select * from transactions;

insert into transactions(transactions.id,amount) values (null,9.99)