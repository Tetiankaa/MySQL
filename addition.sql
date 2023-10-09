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

insert into transactions(transactions.id,amount) values (null,9.99);

/* primary key */

alter table transactions add constraint primary key (id); /* if you forgot set primary key during creation the table*/

/* auto_increment */

create table test2 (
                       id int primary key auto_increment,
                       amount decimal(5,2)

);

alter table test2 auto_increment=100;
insert into test2(amount) values (5.99),(6.40);

select * from test2;
drop table test2;

/* foreign keys */

create table customers(
                          id int primary key auto_increment,
                          first_name varchar(50),
                          last_name varchar(50)
);

insert into customers values (null,'Tom','Kuki'),(null,'Olha','Kutlikova'),(null,'Mariana','Chorolska');
insert into customers values (null,'Igor','Ustimenko');
select * from customers;

create table transactions(
                             id int primary key auto_increment,
                             amount decimal(5,2),
                             customer_id int,
                             foreign key (customer_id) references customers(id)
);
select *from transactions;

alter table transactions drop foreign key transactions_ibfk_1; /* delete foreign key */
alter table transactions add constraint fk_customer_id foreign key (customer_id) references customers(id); /* add foreign key after creation the table */

insert into transactions values (null,4.90,2),(null,9.90,2),(null,15.7,1),(null,1.99,3);
insert into transactions values (null,5.1,null);

/* joins - combines rows from 2 or more tables */
/* inner join - selects records that have matching values in both tables  */
select * from transactions inner join customers on transactions.customer_id = customers.id;
select transactions.id,amount,first_name,last_name from transactions inner join customers c on transactions.customer_id = c.id;

/*RIGHT JOIN keyword returns all records from the right table, and the matching records from the left table */
select * from transactions right join customers c on c.id = transactions.customer_id;
/*LEFT JOIN keyword returns all records from the left table, and the matching records from the right table */
select * from transactions left join customers c on c.id = transactions.customer_id;

/* functions */
select count(amount) as count from transactions;

select min(amount) as minimum from transactions;
select max(amount) as maximum from transactions;
select min(amount) as minimum,max(amount) as maximum from transactions;

select avg(amount) as average from transactions;

select sum(amount) as sum from transactions;

select concat(first_name,' ', last_name) as full_name from customers;

/* AND, OR, NOT */

select * from employees;
delete from employees where id>=7;

alter table employees add column job varchar(25) after hourly_pay;

update employees set employees.job = 'cook' where id=4 or id=5;

select * from employees where hire_date < '2023-01-01' and job='cook';

select * from employees where job = 'cook' or job='cashier';

select * from employees where not job = 'cook';

select * from employees where hire_date between '2023-01-01' and '2023-08-01';

select * from employees where job in ('cook','cashier');

/* wild card characters %, _ */

select * from employees where first_name like 'o%';
select * from employees where first_name like '%a';

select * from employees where first_name like '_u%a';

select * from employees where hire_date like '____-06-__';

/* order by */
select * from employees order by first_name;
select * from employees order by first_name desc ;

select * from employees order by hire_date;

select * from transactions;
insert into transactions values (null,4.90,3);

select * from transactions order by amount,customer_id; /* if there are records with duplicate values, we can add additional column to order the results */

/* limit */

select * from customers limit 1;

select * from customers order by last_name limit 1;

select *  from customers limit 2 offset 1;

/* union - combines results of two or more select statements */

create table income (
                        orders decimal(10,2),
                        merchandise decimal(10,2),
                        services decimal(10,2)
);
insert into income values (100000.00,40000.00,175.000);

create table expenses(
                         wages decimal(10,2),
                         tax decimal(10,2),
                         repairs decimal(10,2)
);
insert into expenses values (-25000.00,-50000.00,-9000.00);

(select * from income) union (select * from expenses);

/* self joins */

alter table customers add referral_id int;
update customers set customers.referral_id = 2 where id = 1;
update customers set customers.referral_id = 2 where id=3 or id=4;
select * from customers;

select * from customers as a inner join customers as b on a.referral_id=b.id;

select a.id, a.last_name,a.first_name, b.first_name,b.last_name from customers as a inner join customers as b on a.referral_id=b.id;

/* VIEWS */
/* a virtual table based on the result-set of an SQL-statement */
/* if we add new data to main table, it will automatically update in view table */

select * from employees;

create view employee_attendance as select first_name,last_name from employees;

select * from employee_attendance;
drop view employee_attendance;

/* ############### */
alter table customers add column email varchar(50);
update customers set email='email3@gmail.com' where id=3;

create view customer_emails as select email from customers;
select * from customer_emails;

/* INDEXES (BTree data structure) */
/* are used to find values within a specific column more quickly */

show indexes from customers;

create index last_name_index on customers(last_name);
alter table customers drop index last_name_index;

create index last_name_first_name_index on customers(last_name,first_name);

/* SUBQUERY */
/* a query within another query */

select first_name,last_name,hourly_pay,(select avg(hourly_pay) from employees) as avg_pay from employees;

select * from  employees where hourly_pay >(select avg(hourly_pay) from employees);

/* ################## */

select first_name,last_name from customers where id in (select distinct customer_id from transactions where customer_id is not null);

/* GROUP BY */

alter table transactions add order_date date;

select sum(amount), order_date from transactions group by order_date;

select sum(amount),customer_id from transactions group by customer_id;

/* ROLLUP */
/*  used to produce the summary output */

select sum(amount),order_date from transactions group by order_date with rollup ;

/* ON DELETE */
/* ON DELETE SET NULL - when a foreign key is deleted, replace foreign key with NULL */
/* ON DELETE CASCADE - when a foreign key is deleted, delete row */

alter table transactions add constraint fk_customer_id foreign key (customer_id) references customers(id) on DELETE set null;
delete from customers where id=1;
select * from transactions;


alter table transactions drop foreign key fk_customer_id;
alter table transactions add constraint fk_transactions_id foreign key (customer_id) references customers(id) on delete cascade ;
delete from customers where id=3;

/* TRIGGERS */

alter table employees add column  salary decimal(10,2);

update employees set salary = hourly_pay*2080;

delimiter //
create trigger before_hourly_pay_update before update on employees
    for each row
begin
    set NEW.salary = (NEW.hourly_pay * 2080);
end;
//
delimiter ;