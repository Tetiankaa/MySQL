use tanya;

/* OneToOne */
create table users
(
    id int primary key auto_increment,
    username varchar(20) not null ,
    password varchar(20) not null
);

create table profile(
                        id int primary key auto_increment,
                        name varchar(20) not null ,
                        surname varchar(20) not null ,
                        photo varchar(255) null ,
                        phone varchar(10) not null ,
                        user_id int null unique ,
                        foreign key (user_id) references users(id)
);

insert into users values (null,'Yi_jfk','qwert'),(null,'FFjd-fjf','yyuuu'),(null,'dnsvnk44','gggggg'),(null,'ncvhsj55-','zxzzzzvx');

insert into profile values (null,'Max','Popov',null,'095368574',1),(null,'Kira','Plug',null,'0967485123',2),(null,'Oleh','Droza',null,'0937485159',3),(null,'Anton','Chop',null,'0633574899',4);

/* ManyToMany */

create table users_cars(
                           user_id int not null ,
                           car_id bigint not null ,
                           primary key (user_id,car_id),
                           foreign key (user_id) references users(id),
                           foreign key (car_id) references cars(id)
);

select * from cars
                  join users_cars uc on cars.id = uc.car_id
                  join users u on u.id = uc.user_id
where model='audi';

select u.*,model from cars join users_cars uc on cars.id = uc.car_id
                           join users u on u.id = uc.user_id
where username='dnsvnk44';

/* OneToMany */

create table orders(
                       order_id int primary key auto_increment,
                       order_date datetime not null ,
                       total_amount int not null ,
                       user_id int not null ,
                       foreign key (user_id) references users(id)
);

select id,username,order_date,total_amount from users join orders o on users.id = o.user_id;

/*
OneToOne relationship - a row in a table is related to only one row in another table and vice versa

ManyToMany relationship -a row from one table can have multiple matching rows in another table, and a row in the other table can also have multiple matching rows in the first table.
The relationship is implemented through a separate table.

OneToMany relationship - a row from one table can have multiple matching rows in another table
*/